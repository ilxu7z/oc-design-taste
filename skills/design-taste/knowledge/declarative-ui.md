---
knowledge: declarative-ui
description: >-
  声明式 UI 协议理论基础 — A2UI v1.0 协议原理、邻接表模型、组件目录、安全模型、数据流设计。
  来源：A2UI (Agent-to-User Interface) v1.0 Specification + 生产实践提炼。
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
| **声明式 JSON（A2UI）** ✅ | 安全+灵活+可控 | 需要协议设计+组件体系 |

---

## 2. A2UI v1.0 核心架构

### 2.1 三层解耦

```
┌─────────────────┐     声明式 JSON      ┌─────────────────┐
│   AI Agent      │ ──────────────────→ │   A2UI v1.0     │
│  (推理 + 工具)   │                      │  (JSON 协议)     │
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

A2UI 最精妙的设计决策：**UI 定义为扁平组件列表，父子关系通过 ID 引用建立。**

#### 嵌套树（传统方案 — A2UI 不使用）

```json
{
  "type": "Column",
  "children": [
    {
      "type": "Card",
      "children": [
        { "type": "Text", "value": "标题" },
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

#### 邻接表（A2UI v1.0 方案）

```json
{
  "updateComponents": {
    "surfaceId": "form_1",
    "components": [
      { "id": "root", "component": "Column", "children": ["card_1"] },
      { "id": "card_1", "component": "Card", "child": "title_1" },
      { "id": "title_1", "component": "Text", "text": "标题" },
      { "id": "row_1", "component": "Row", "children": ["btn_ok", "btn_cancel"] },
      { "id": "btn_ok", "component": "Button", "child": "btn_ok_text", "action": { "event": { "name": "confirm" } } },
      { "id": "btn_ok_text", "component": "Text", "text": "确认" },
      { "id": "btn_cancel", "component": "Button", "child": "btn_cancel_text", "action": { "event": { "name": "cancel" } } },
      { "id": "btn_cancel_text", "component": "Text", "text": "取消" }
    ]
  }
}
```

**优势对比**：

| 特性 | 嵌套树 | 邻接表（A2UI） |
|------|--------|----------------|
| LLM 生成难度 | 高（一次性正确嵌套） | **低（逐组件生成）** |
| 增量更新 | 困难（需重发整棵树） | **简单（按 ID 更新）** |
| 流式传输 | 不支持 | **原生支持** |
| 错误恢复 | 整体失败 | **单组件失败不影响其他** |
| JSON 深度 | 可能很深 | **始终扁平（depth=1）** |

### 2.3 六种消息类型（v1.0）

| 消息类型 | 方向 | 职责 | 类比 |
|---------|------|------|------|
| **createSurface** | Server→Client | 创建 UI Surface（可内嵌初始 components + dataModel） | 创建 DOM 树 |
| **updateComponents** | Server→Client | 添加/更新组件定义（扁平列表） | DOM 节点操作 |
| **updateDataModel** | Server→Client | 更新数据（路径 + 值，Upsert 语义） | React setState |
| **deleteSurface** | Server→Client | 删除整个 Surface | DOM 卸载 |
| **actionResponse** | Server→Client | 响应客户端发起的 action（同步 RPC） | HTTP Response |
| **callFunction** | Server→Client | 调用客户端注册的函数 | Remote Procedure Call |

### 2.4 Single-Message UI（v1.0 新增）

v1.0 允许在 `createSurface` 中内嵌完整的组件树和数据模型，实现**一条消息完成 UI 构建**：

```json
{
  "version": "v1.0",
  "createSurface": {
    "surfaceId": "hello_card",
    "catalogId": "https://a2ui.org/specification/v1_0/catalogs/basic/catalog.json",
    "components": [
      { "id": "root", "component": "Card", "child": "msg" },
      { "id": "msg", "component": "Text", "text": { "path": "/greeting" } }
    ],
    "dataModel": { "greeting": "你好，世界！" }
  }
}
```

### 2.5 数据绑定类型（Dynamic Types）

A2UI 定义了 5 种 Dynamic 类型，使任何属性都可以绑定到数据模型或函数调用：

| 类型 | 说明 | 可接受的值 |
|------|------|----------|
| **DynamicString** | 字符串 | 字面量、JSON Pointer `{"path":"/user/name"}`、FunctionCall `{"call":"formatDate","args":{...}}` |
| **DynamicNumber** | 数字 | 同上 |
| **DynamicBoolean** | 布尔值 | 同上 |
| **DynamicStringList** | 字符串列表 | 同上 |
| **DynamicValue** | 任意值 | 同上（用于 formatDate 等需要多类型的场景） |

---

## 3. 数据模型与绑定

### 3.1 JSON Pointer 路径解析

数据绑定基于 **JSON Pointer（RFC 6901）**，支持两种作用域：

| 路径类型 | 格式 | 解析方式 | 示例 |
|---------|------|---------|------|
| **绝对路径** | `/` 开头 | 从 DataModel 根解析 | `/user/profile/name` → 根下 user.profile.name |
| **相对路径** | 无 `/` 前缀 | 从当前 Collection Scope 解析 | `firstName` → 在 List 模板中解析为 `/users/0/firstName` |

**集合作用域（Collection Scope）**：当 Row/Column/List 使用模板绑定（`children.path` 指向数组）时，每个迭代项创建独立作用域。模板内的相对路径在该作用域内解析。

```json
{
  "id": "user_list",
  "component": "List",
  "children": { "path": "/employees", "componentId": "employee_card" }
},
{
  "id": "employee_card",
  "component": "Column",
  "children": ["emp_name", "company_name"]
},
{
  "id": "emp_name",
  "component": "Text",
  "text": { "path": "name" }
  // 相对路径 → /employees/N/name
},
{
  "id": "company_name",
  "component": "Text",
  "text": { "path": "/company" }
  // 绝对路径 → /company（全局）
}
```

### 3.2 Two-Way Binding（双向绑定）

输入组件（TextField/CheckBox/Slider/ChoicePicker/DateTimeInput）建立双向绑定：

| 方向 | 机制 | 说明 |
|------|------|------|
| **Read（Model→View）** | 组件从绑定 path 读取值 | dataModel 更新时自动重渲染 |
| **Write（View→Model）** | 用户交互立即更新 dataModel | 局部状态，不自动发网络请求 |
| **Server Sync** | action 事件中附带 context | 用户提交时，绑定值随 action 发送到服务端 |

**核心规则**：双向绑定是**客户端局部行为**。用户输入不自动触发网络请求，只在用户触发 action 时同步到服务端。

### 3.3 表单提交模式

```
1. TextField 绑定到 /form/email
2. 用户输入 "jane@example.com" → 本地 dataModel 即时更新
3. Submit Button 的 action.event.context 引用 {"path": "/form/email"}
4. 用户点击 → 客户端解析路径值，随 action 发送到服务端
```

### 3.4 DataModel 同步（sendDataModel）

当 `createSurface.sendDataModel = true` 时，客户端在**每次发送消息到服务端时**自动附带完整 dataModel。

- **目标投递**：仅发送给创建该 Surface 的服务端
- **触发条件**：用户 action（不是被动输入）
- **Payload 位置**：Transport 的 metadata 字段

---

## 4. 安全模型：四层纵深防御

### 4.1 防御层

| 层 | 机制 | 防御什么 |
|----|------|---------|
| **1. 声明式数据** | Agent 只发送数据，不发送代码 | 注入攻击、任意代码执行 |
| **2. 组件白名单（Catalog）** | Client 只渲染 Catalog 中注册的组件 | 未定义组件的渲染 |
| **3. Schema 约束** | JSON Schema 强制验证 LLM 输出 | 格式错误、类型错误 |
| **4. Catalog 协商** | Agent 和 Client 双向声明能力，取交集 | 超出 Client 能力的组件请求 |

### 4.2 Catalog 机制

Catalog 是 A2UI 的核心安全基础设施：

| 概念 | 说明 |
|------|------|
| **catalogId** | 唯一标识符（建议用域名，如 `https://mycompany.com/catalogs/v1`） |
| **components** | 组件类型 → JSON Schema 定义映射 |
| **functions** | 客户端可调用的验证/工具函数定义 |
| **surfaceProperties** | 可定制的视觉属性 Schema |
| **instructions** | Markdown 格式的设计指导（嵌入给 LLM） |
| **自定义 Catalog** | 开发者可定义自己的 Catalog，覆盖/扩展 Basic Catalog |

### 4.3 函数执行边界

v1.0 引入 `callableFrom` 元数据，控制函数可被谁调用：

| 边界 | 说明 |
|------|------|
| **clientOnly**（默认） | 只能客户端本地调用，服务端 callFunction 会被拒绝 |
| **remoteOnly** | 只能服务端远程调用，客户端不能直接使用 |
| **clientOrRemote** | 双向可用 |

**安全原则**：自定义组件的实现代码在 Client 侧，Agent 只能传递数据参数，永远无法注入逻辑。

---

## 5. 双向 RPC（v1.0 新增）

### 5.1 Client→Server：Action + Response

```
Client                                    Server
  │                                         │
  │──── action (wantResponse: true) ───────→│  用户点击 Submit
  │     { name, surfaceId, context }       │
  │                                         │
  │←──── actionResponse ───────────────────│  服务端处理完毕，同步回复
  │     { actionId, value/error }           │
```

- `actionResponse.value`：成功时的返回值
- `actionResponse.error`：失败时的 `{code, message}`

### 5.2 Server→Client：callFunction

```
Server                                    Client
  │                                         │
  │──── callFunction ─────────────────────→│  服务端请求执行客户端函数
  │     { call: "getScreenResolution",      │
  │       args: { screenIndex: 0 } }       │
  │                                         │
  │←──── functionResponse ────────────────│  客户端返回执行结果
  │     { functionCallId, call, value }     │
```

**安全验证**：客户端收到 callFunction 时，必须在 Catalog 中查找该函数的 `callableFrom`。如果配置为 `clientOnly` 或未注册，客户端**必须拒绝**并返回 `INVALID_FUNCTION_CALL` 错误。

### 5.3 系统函数 @index

`@index()` 返回 List 模板中当前项的 0-based 索引，是 A2UI 的通用系统函数：

- 仅在 Collection Scope（列表模板渲染）中可用
- `@index(offset: 1)` 产生 1-based 索引
- Root Scope 中调用是错误

---

## 6. formatString 与表达式插值

`formatString` 是 A2UI 的字符串插值函数，支持 `${expression}` 语法：

### 6.1 支持的表达式类型

| 类型 | 语法 | 示例 |
|------|------|------|
| **数据路径（绝对）** | `${/path/to/field}` | `${/user/firstName}` |
| **数据路径（相对）** | `${relativeField}` | `${name}`（在 List 模板中） |
| **函数调用（无参）** | `${functionName()}` | `${now()}` |
| **函数调用（命名参数）** | `${func(arg:value, ... )}` | `${formatDate(value:${/date}, format:'MM-dd')}` |
| **嵌套表达式** | `${outer(${inner})}` | `${upper(${/name})}` |
| **字面量转义** | `\${` | 不解释的 `${` |

### 6.2 类型转换

| 输入类型 | 转为 String | 转为 Number | 转为 Boolean |
|---------|-------------|-------------|--------------|
| `"true"/"false"` | 不变 | — | true/false（其他字符串→false） |
| 非零数字 | 不变 | — | true |
| 0 | 不变 | — | false |
| null/undefined | `""`（空字符串） | 0 | false |
| Object/Array | JSON.stringify | — | — |

---

## 7. 对 Design Taste 的启发

### 7.1 可借鉴的设计模式

| A2UI v1.0 概念 | Design Taste 融合点 |
|----------------|-------------------|
| 邻接表模型 | 组件模式可以用扁平化描述，避免 Agent 嵌套失误 |
| Catalog 白名单 | "已知组件词汇表"概念——先声明组件能力再生成 |
| DataModel + Components 分离 | 将"布局骨架"和"内容数据"分开生成/更新 |
| Single-Message UI | 简单 UI 可一条消息完成，复杂 UI 分步构建 |
| Two-Way Binding | 输入组件自动同步状态，减少手动管理 |
| 双向 RPC | Agent 可以在用户操作后立即响应，或获取客户端信息 |
| Schema 验证 | 输出前用结构化检查验证完整性 |
| formatString 插值 | 组件文案可动态绑定数据，无需硬编码 |
| @index | 列表项编号问题标准解决 |
| Catalog.instructions | 设计指导可直接嵌入 Catalog，Agent 自动遵循 |

### 7.2 不直接照搬的部分

| A2UI 概念 | 为什么不完全照搬 |
|-----------|----------------|
| 传输协议（A2A/AG-UI/SSE） | Design Taste 是 prompt skill，不关心传输 |
| SDK/渲染器实现 | Agent 不写渲染器，只写 A2UI JSON 或直接写代码 |
| Catalog Schema 7 条严格规则 | Agent 定义 Catalog 时才需要，日常设计不涉及 |
| SurfaceModel/ComponentContext 架构 | 渲染器内部实现，与设计品味无关 |

### 7.3 核心收获

**Agent 生成 UI 的正确方法论**：
1. **先声明组件能力**（知道有哪些积木 — Catalog）
2. **再描述组件关系**（邻接表思维，扁平 + ID 引用）
3. **数据和结构分离**（Components 定义骨架，DataModel 填充内容）
4. **增量构建**（Simple UI 用 Single-Message，Complex UI 分步 updateComponents）
5. **白名单思维**（只用 Catalog 中已注册的组件，不发明新组件）
6. **Schema 验证**（生成的 JSON 必须通过 Catalog Schema 验证）
7. **双向交互**（action 触发服务端处理，callFunction 获取客户端状态）

---

## 8. 参考资源

- A2UI v1.0 Protocol Spec: https://a2ui.org/specification/v1_0/docs/a2ui_protocol.md
- A2UI Basic Catalog (v1.0): https://a2ui.org/specification/v1_0/catalogs/basic/catalog.json
- A2UI Renderer Guide: https://a2ui.org/specification/v1_0/docs/renderer_guide.md
- A2UI GitHub: https://github.com/a2ui-project/a2ui
- A2UI 官方文档: https://a2ui.org

---

## §8. 协议版本演进与 Breaking Changes

A2UI 协议经历了从 v0.8 到 v1.0 的四次迭代，每次迭代都基于 LLM 生成 UI 的实际痛点进行重构。理解演进脉络有助于 Agent 生成兼容特定版本的 Payload。

### §8.1 v0.8 基线：Structured Output First

v0.8 是 A2UI 的首个公开协议版本，设计哲学是 **Structured Output / Function Calling 优先**——适配支持严格 JSON 模式的 LLM。

**四种核心消息类型**：

| 消息 | 方向 | 职责 |
|------|------|------|
| `beginRendering` | Server→Client | 信号：初始组件已发完，可以渲染；包含 `root` ID 和 `styles` |
| `surfaceUpdate` | Server→Client | 添加/更新组件（扁平列表，但组件类型用嵌套 key 包装） |
| `dataModelUpdate` | Server→Client | 更新数据模型（邻接表格式：`[{key, valueString}]`） |
| `deleteSurface` | Server→Client | 删除 Surface |

**嵌套组件语法**（v0.8 特征——组件类型作为 key 包装）：

```json
{
  "id": "title",
  "component": {
    "Text": {
      "text": { "literalString": "Hello" },
      "usageHint": "h3"
    }
  }
}
```

**数据绑定语法**：

| 写法 | 含义 |
|------|------|
| `{ "literalString": "foo" }` | 字面量字符串 |
| `{ "literalNumber": 42 }` | 字面量数字 |
| `{ "path": "/user/name" }` | JSON Pointer 绑定 |

**四种基本组件**：Row, Column, Text, Image（另有 Card, Button, List, Modal 等扩展组件）。`children` 用 `explicitList`/`childrenProperty` 定义，`userAction` 作为客户端事件消息，无 `version` 字段要求。

### §8.2 v0.8 → v0.9 变更：Prompt First 大重构

v0.9 是**哲学级变更**——从 "Structured Output First" 转向 **"Prompt First"**。Schema 重新设计为更 token 高效、更易于 LLM 理解的格式。

| 变更领域 | v0.8 | v0.9 | 原因 |
|----------|------|------|------|
| **消息重命名** | `beginRendering` | `createSurface` | 语义更准确 |
| | `surfaceUpdate` | `updateComponents` | 动词-名词一致 |
| | `dataModelUpdate` | `updateDataModel` | 简化命名 |
| **扁平化组件** | `{"Text": {"text": ...}}` 嵌套包装 | `"component": "Text", "text": ...` 扁平化 | LLM 更容易一致生成 |
| **数据绑定** | `{ "literalString": ... }` / `{ "path": ... }` | 原生 JSON 类型 + `{ "path": ... }` | 减少冗余包装 |
| **新增 theme** | `styles: { primaryColor }` | `theme: { primaryColor }` | 统一主题属性 |
| **version 必填** | 无要求 | `"version": "v0.9"` | 协议版本显式声明 |
| **functions 数组** | 组件和函数分开 | 统一 Catalog，functions 为数组 | 简化能力协商 |
| **Dynamic Types** | 无 | DynamicString/Number/Boolean 等 | 统一绑定语法 |
| **sendDataModel** | 隐式 | `createSurface.sendDataModel: true` | 显式数据同步控制 |
| **children 语法** | `explicitList` / `childrenProperty` | `ChildList`（array 或 object） | 统一子组件引用 |
| **Action 事件** | `userAction` | `action` | 简化命名 |
| **Button variant** | `primary: true` (boolean) | `variant: "primary"` (enum) | 更灵活的样式系统 |
| **TextField** | `textFieldType` + `validationRegexp` | `variant` + `checks` | 统一验证机制 |
| **ChoicePicker** | `MultipleChoice` + `maxAllowedSelections` | `variant: "mutuallyExclusive"` / `"multipleSelection"` | 语义更清晰 |
| **Row/Column** | `distribution` / `alignment` | `justify` / `align` | 标准化命名 |

### §8.3 v0.9 → v0.9.1 变更：小幅修正

v0.9.1 是 v0.9 的微小修正版本，**完全向后兼容**（Schema 同时接受 `"v0.9"` 和 `"v0.9.1"`）：

| 变更 | 说明 |
|------|------|
| **MIME Type 标准化** | `application/json+a2ui` → `application/a2ui+json`（符合 IANA 规范） |
| **surfaceId 唯一性放宽** | 从"渲染器生命周期内全局唯一"放宽为"当前活跃 Surface 中唯一" |

迁移方式：更新 MIME 类型引用即可，其他无变更。

### §8.4 v0.9.1 → v1.0 变更：双向 RPC + 品牌解耦

v1.0 是**功能级大版本**，引入双向 RPC 和多项架构改进。

| 变更领域 | v0.9.1 | v1.0 | 影响 |
|----------|--------|------|------|
| **theme → surfaceProperties** | `theme: { primaryColor }` | `surfaceProperties`（布局与品牌分离） | 移除 `primaryColor`，视觉属性由 Catalog 定义 |
| **primaryColor 移除** | 在 theme 中 | 从 Catalog Schema 中删除 | 品牌色通过自定义 Catalog 注入 |
| **functions array → map** | `functions: [...]` 数组 | `functions: { "name": {...} }` 映射 | 函数定义按键名索引 |
| **actionResponse 新增** | 无 | Server→Client 同步响应 action | 支持 action + response RPC |
| **callFunction 新增** | 无 | Server→Client 调用客户端函数 | 双向 RPC 完整闭环 |
| **functionResponse 新增** | 无 | Client→Server 返回函数结果 | |
| **callableFrom 从 wire 移除** | 在 FunctionCall 中 | 移至 Catalog 静态定义 | 运行时查 Catalog 验证 |
| **returnType 从 wire 移除** | 在 FunctionCall 中 | 移至 Catalog 静态定义 | |
| **UAX#31 命名强制** | 无约束 | 组件名/函数名/参数键必须符合 UAX#31 | 正则：XID_Start + XID_Continue |
| **@index 系统函数** | 无 | List 模板中返回当前索引，`@` 前缀保留 | 仅在 Collection Scope 中可用 |
| **Single-Message UI** | 需 createSurface + updateComponents + updateDataModel | createSurface 可内嵌 components + dataModel | 一条消息完成 UI 构建 |
| **instructions 字段** | 外部 `rules.txt` | Catalog 内嵌 `instructions` (Markdown) | 设计指导直接随 Catalog 分发 |
| **deleteSurface 语义** | 无明确规范 | 在 createSurface 前必须先 delete | surfaceId 全局唯一/会话内 |
| **JSON Schema metadata** | 不支持 | 支持 `$schema`, `$id`, `title`, `description` | inline Catalog 不再验证失败 |
| **Video posterUrl** | 无 | 可选预览图 | |
| **TextField placeholder** | 无 | 可选占位提示 | |
| **Slider steps** | 无 | 可选离散步进值 | |
| **Icon path 重命名** | `svgPath` | `path` | |
| **数据删除语义** | 省略 key = 删除 | `null` = 删除（省略不再删除） | updateDataModel 行为变更 |

### §8.5 完整 Breaking Changes 速查表

| 版本跨度 | 变更 | Breaking? | 迁移方式 |
|---------|------|-----------|---------|
| v0.8→v0.9 | `beginRendering` → `createSurface` | ✅ | 全局替换消息名 |
| v0.8→v0.9 | `surfaceUpdate` → `updateComponents` | ✅ | 全局替换消息名 |
| v0.8→v0.9 | `dataModelUpdate` → `updateDataModel` | ✅ | 全局替换消息名 |
| v0.8→v0.9 | 组件嵌套语法 → 扁平化 | ✅ | 重写组件定义 |
| v0.8→v0.9 | `literalString`/`literalNumber` → 原生类型 | ✅ | 去掉包装器 |
| v0.8→v0.9 | `version` 字段必填 | ✅ | 每条消息添加 `"version"` |
| v0.8→v0.9 | `userAction` → `action` | ✅ | 替换事件消息名 |
| v0.8→v0.9 | `usageHint` → `variant` | ✅ | 全局替换属性名 |
| v0.8→v0.9 | `distribution`/`alignment` → `justify`/`align` | ✅ | 替换 Row/Column 属性 |
| v0.8→v0.9 | `primary: true` → `variant: "primary"` | ✅ | 替换 Button 属性 |
| v0.8→v0.9 | `MultipleChoice` → `ChoicePicker` | ✅ | 替换组件类型名 |
| v0.8→v0.9 | `entryPointChild`/`contentChild` → `trigger`/`content` | ✅ | 替换 Modal 属性 |
| v0.8→v0.9 | `tabItems` → `tabs` | ✅ | 替换 Tabs 属性 |
| v0.9→v0.9.1 | MIME type `application/json+a2ui` → `application/a2ui+json` | ⚠️ 轻微 | 更新传输层常量 |
| v0.9.1→v1.0 | `theme` → `surfaceProperties` | ✅ | 替换属性名，移除 primaryColor |
| v0.9.1→v1.0 | `functions` array → map | ✅ | 重构 Catalog 定义 |
| v0.9.1→v1.0 | 新增 `actionResponse`/`callFunction` | ⚠️ 新增 | 渲染器需实现新消息处理 |
| v0.9.1→v1.0 | `callableFrom`/`returnType` 从 wire 移除 | ✅ | 移至 Catalog 定义 |
| v0.9.1→v1.0 | UAX#31 命名强制 | ✅ | 检查所有标识符合规性 |
| v0.9.1→v1.0 | `null` = 删除（省略不再删除） | ✅ | updateDataModel 用 null 显式删除 |
| v0.9.1→v1.0 | `svgPath` → `path`（Icon） | ✅ | 替换属性名 |

### §8.6 版本选择决策规则

| 场景 | 推荐版本 | 原因 |
|------|---------|------|
| **新项目** | v1.0 | 最新稳定版，功能最完整 |
| **需要双向 RPC** | v1.0（必须） | actionResponse/callFunction 仅 v1.0 支持 |
| **需要 Single-Message UI** | v1.0（必须） | createSurface 内嵌组件仅 v1.0 支持 |
| **现有 v0.9 项目** | v0.9 或升级 v1.0 | 评估是否需要 v1.0 新功能 |
| **需要兼容旧渲染器** | 对应版本 | 渲染器决定最低版本 |
| **自定义 Catalog + 品牌** | v1.0 | surfaceProperties 品牌解耦更灵活 |
| **研究/学习** | v1.0 + 阅读 v0.8/v0.9 演进 | 理解设计决策的来龙去脉 |

**核心原则**：Agent 发送的 `version` 字段必须与目标渲染器支持的版本匹配。版本不匹配时，渲染器应报错或降级处理。
