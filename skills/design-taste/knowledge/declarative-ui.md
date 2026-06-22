---
knowledge: declarative-ui
description: >-
  声明式 UI 协议理论基础 — A2UI 协议原理、邻接表模型、组件目录协商、安全模型、数据流设计。
  来源：Google A2UI (Agent-to-User Interface) v0.8 + 生产实践提炼。
  本文件是知识层（理论），执行规范见 domains/agent-ui.md。
---

# 声明式 UI 理论基础

> **核心理念**：Agent 不应该生成可执行代码（HTML/JS），而是发送**声明式数据描述**，由客户端用预定义组件渲染。
> 这不是新概念——React 本身就是声明式的。但 A2UI 将这种理念扩展到了**跨信任边界**的 Agent-to-Client 通信。

---

## 1. 问题域：为什么 Agent 直接生成 UI 是危险的

### 1.1 三层风险

| 风险层 | 描述 | 示例 |
|--------|------|------|
| **注入攻击** | Agent 生成的 HTML/JS 包含恶意代码 | XSS、DOM Clobbering、Prototype Pollution |
| **视觉不一致** | Agent 生成的设计偏离品牌系统 | 字体/颜色/间距/布局与 Design System 冲突 |
| **失控复杂度** | Agent 输出任意复杂度的 UI | 嵌套地狱、不可预测的布局、性能崩溃 |

### 1.2 传统方案的困境

| 方案 | 优势 | 劣势 |
|------|------|------|
| **纯文本对话** | 安全 | 效率极低，无法展示富交互 |
| **Agent 生成 HTML/JS** | 灵活 | 安全噩梦，品牌不一致 |
| **固定模板** | 安全+可控 | 不灵活，Agent 无法表达复杂意图 |
| **声明式 JSON** ✅ | 安全+灵活+可控 | 需要协议设计+组件体系 |

---

## 2. A2UI 核心架构

### 2.1 三层解耦

```
┌─────────────────┐     声明式 JSON      ┌─────────────────┐
│   AI Agent      │ ──────────────────→ │   A2UI 协议      │
│  (推理 + 工具)   │                      │  (消息格式)      │
└─────────────────┘                      └────────┬────────┘
                                                  │ 声明式数据
                                                  ▼
                                        ┌─────────────────┐
                                        │   Client 渲染器   │
                                        │  (原生组件 + 框架) │
                                        └─────────────────┘
```

**关键洞察**：Agent 只描述"要什么"（what），不描述"怎么做"（how）。

### 2.2 邻接表模型 vs 嵌套树

这是 A2UI 最精妙的设计决策。

#### 嵌套树（传统方案）

```json
{
  "type": "Column",
  "children": [
    {
      "type": "Card",
      "children": [
        {
          "type": "Text",
          "value": "标题"
        },
        {
          "type": "Row",
          "children": [
            { "type": "Button", "label": "确认" },
            { "type": "Button", "label": "取消" }
          ]
        }
      ]
    }
  ]
}
```

**问题**：LLM 必须一次性生成正确的嵌套深度，任何层级错误导致整体解析失败。无法流式传输。

#### 邻接表（A2UI 方案）

```json
{
  "widgets": [
    { "id": "w1", "type": "Column", "parentId": null },
    { "id": "w2", "type": "Card",   "parentId": "w1" },
    { "id": "w3", "type": "Text",   "parentId": "w2", "value": "标题" },
    { "id": "w4", "type": "Row",    "parentId": "w2" },
    { "id": "w5", "type": "Button", "parentId": "w4", "label": "确认" },
    { "id": "w6", "type": "Button", "parentId": "w4", "label": "取消" }
  ]
}
```

**优势对比**：

| 特性 | 嵌套树 | 邻接表 |
|------|--------|--------|
| LLM 生成难度 | 高（一次性正确嵌套） | **低（逐组件生成）** |
| 增量更新 | 困难（需重发整棵树） | **简单（按 ID 更新）** |
| 流式传输 | 不支持 | **原生支持** |
| 错误恢复 | 整体失败 | **单组件失败不影响其他** |
| JSON 深度 | 可能很深 | **始终扁平（depth=1）** |

### 2.3 四种消息类型

| 消息类型 | 职责 | 类比 |
|---------|------|------|
| **surfaceUpdate** | 定义 UI 结构（扁平组件列表） | DOM 树构建 |
| **dataModelUpdate** | 填充数据（与结构分离） | React setState |
| **beginRendering** | 触发渲染（缓冲→一次性显示） | React commit |
| **deleteSurface** | 清理 UI 区域 | DOM 卸载 |

**设计亮点**：数据和结构分离。修改一个数据点只需发 `dataModelUpdate`，无需重发整个 UI 结构。

---

## 3. 安全模型：四层纵深防御

### 3.1 防御层

| 层 | 机制 | 防御什么 |
|----|------|---------|
| **1. 声明式数据** | Agent 只发送数据，不发送代码 | 注入攻击、任意代码执行 |
| **2. 组件白名单** | Client 只渲染已注册的组件类型 | 未定义组件的渲染 |
| **3. 目录协商** | Agent 和 Client 双向声明能力，取交集 | 超出 Client 能力的组件请求 |
| **4. Schema 约束** | LLM 输出受 JSON Schema 强制限制 | 格式错误、类型错误 |

### 3.2 组件目录协商流程

```
Client                                    Agent
  │                                         │
  │──── ClientCapabilities ────────────────→│  Client 声明支持的组件目录
  │      { supportedCatalogs: [...] }       │
  │                                         │
  │←──── CatalogChoice ─────────────────────│  Agent 选择一个目录
  │      { selectedCatalog: "v1" }           │
  │                                         │
  │←──── surfaceUpdate ──────────────────────│  Agent 按选定目录的组件发送
  │      { widgets: [...] }                  │
```

### 3.3 未知组件处理

当 Agent 发送了 Client 不认识的组件类型时：

1. **静默忽略** — 跳过该组件，渲染其余
2. **占位符显示** — 渲染一个 `[Unknown Widget: ModalDialog]` 占位
3. **错误反馈** — 通过协议消息通知 Agent："组件 ModalDialog 未注册"

**安全原则**：自定义组件的实现代码在 Client 侧，Agent 只能传递数据参数，永远无法注入逻辑。

---

## 4. LLM 约束机制

### 4.1 四层约束链

| 层 | 约束方式 | 作用 |
|----|---------|------|
| **LLM 层** | JSON Schema / Structured Output | 强制输出符合 Schema 的 JSON |
| **Agent 层** | Prompt 中嵌入组件目录 | 告诉 LLM 可用的组件和属性 |
| **协议层** | 目录协商 | Agent 只能选 Client 支持的目录 |
| **渲染层** | 组件白名单 | Client 只渲染已注册的类型 |

### 4.2 Prompt Engineering 要点

```
系统提示词中需要包含：
1. 组件目录清单（哪些组件可用）
2. 每个组件的可选属性和类型
3. 数据绑定语法（如何引用 dataModel 中的数据）
4. 交互事件名称（Client 会回传哪些事件）
5. 输出格式示例
```

---

## 5. 数据流完整示例

### 5.1 餐厅预订场景

```
用户："帮我预订明天晚上 7 点的餐厅"

Step 1: Agent 发送 surfaceUpdate
{
  "surfaceId": "reservation-form",
  "widgets": [
    { "id": "root",  "type": "Column", "parentId": null,  "padding": 24 },
    { "id": "title", "type": "Text",   "parentId": "root", "text": "餐厅预订" },
    { "id": "date",  "type": "DateInput",  "parentId": "root", "label": "日期" },
    { "id": "time",  "type": "TextField",  "parentId": "root", "label": "时间", "value": "19:00" },
    { "id": "guests","type": "Slider",     "parentId": "root", "label": "人数", "min": 1, "max": 10 },
    { "id": "btn",   "type": "Button",     "parentId": "root", "label": "确认预订", "onClick": "confirm" }
  ]
}

Step 2: Client 渲染表单

Step 3: 用户填写并点击"确认预订"

Step 4: Client 回传交互事件
{
  "type": "interaction",
  "widgetId": "btn",
  "eventName": "confirm",
  "formData": { "date": "2026-06-23", "time": "19:00", "guests": 4 }
}

Step 5: Agent 处理（调用工具/子Agent/直接模拟）

Step 6: Agent 发送新 surface（确认页面）
{
  "surfaceId": "confirmation",
  "widgets": [
    { "id": "root", "type": "Card",   "parentId": null, "padding": 24 },
    { "id": "msg",  "type": "Text",   "parentId": "root", "text": "预订成功！明天 19:00，4 位。" }
  ]
}
```

### 5.2 职责边界

**A2UI 只管 UI 层。** 业务逻辑（调 API、数据库操作、子 Agent 委派）由 Agent 自己决定。

类比：A2UI 是"显示器"，Agent 是"CPU"。显示器负责显示，CPU 负责计算。

---

## 6. 对 Design Taste 的启发

### 6.1 可借鉴的设计模式

| A2UI 概念 | Design Taste 融合点 |
|-----------|-------------------|
| 邻接表模型 | 组件模式可以用扁平化描述，避免 Agent 嵌套失误 |
| 组件白名单 | "已知组件词汇表"概念——先声明组件能力再生成 |
| 数据/结构分离 | 将"布局骨架"和"内容数据"分开生成/更新 |
| 目录协商 | 与 Design Read 的信号读取类似——先了解能力再行动 |
| Schema 约束 | 输出前用结构化检查验证完整性 |
| 增量更新 | 复杂 UI 可以分步构建，不必一次完成 |

### 6.2 不直接照搬的部分

| A2UI 概念 | 为什么不完全照搬 |
|-----------|----------------|
| 协议消息格式 | 我们是直接生成代码，不是协议通信 |
| 组件目录协商 | 我们不需要 Client/Agent 双向协商 |
| 4 种消息类型 | 过度工程化，我们的场景更直接 |
| beginRendering 缓冲 | Web 渲染不需要缓冲机制 |

### 6.3 核心收获

**Agent 生成 UI 的正确方法论**：
1. **先声明组件能力**（知道有哪些积木）
2. **再描述组件关系**（邻接表思维，扁平+引用）
3. **数据和结构分离**（骨架先行，数据填充）
4. **增量构建**（分步生成，逐步完善）
5. **白名单思维**（只用已验证的模式，不发明新组件）

---

## 7. 参考资源

- A2UI GitHub: https://github.com/google/a2ui
- A2UI 官方文档: https://a2ui.dev
- A2UI v0.8 协议规范
- Google I/O 2025 A2UI 演讲
- CSDN 解析文章: https://yuqingteck.blog.csdn.net/article/details/157385801
