---
knowledge: a2ui-agent-sdk
description: >-
  A2UI Agent SDK 指南 — 能力管理、动态 Prompt 工程、流式解析、Payload 修复与验证、A2A 传输集成。
  融合自 agent_sdk_guide.md + a2ui-agent-maintenance + a2ui-sdk-design。
  面向 Agent 开发者的知识文档，帮助理解 SDK 内部架构和最佳实践。
---

# A2UI Agent SDK 指南

> 融合自 [a2ui-project/a2ui](https://github.com/a2ui-project/a2ui) agent_sdk_guide.md

---

## 1. 架构总览：五阶段数据流

Agent SDK 的核心职责是**能力管理、动态 Prompt 工程和 A2UI Payload 验证**——让 LLM 知道它能构建什么 UI，并确保产出物有效。

```
┌──────────────┐    1. 定义能力     ┌──────────────┐
│  Catalog      │───────────────→  │  Schema      │
│  Config       │                   │  Manager     │
└──────────────┘                   └──────┬───────┘
                                          │ 2. 生成 Prompt
                                          ▼
                                   ┌──────────────┐
                                   │  Inference    │
                                   │  Strategy     │
                                   └──────┬───────┘
                                          │ 3. 流式解析
                                          ▼
                                   ┌──────────────┐
                                   │  Streaming    │
                                   │  Parser       │
                                   └──────┬───────┘
                                          │ 4. 验证
                                          ▼
                                   ┌──────────────┐
                                   │  Validator +  │
                                   │  PayloadFixer │
                                   └──────┬───────┘
                                          │ 5. 传输
                                          ▼
                                   ┌──────────────┐
                                   │  A2A         │
                                   │  DataPart     │
                                   └──────────────┘
```

| 阶段 | 输入 | 输出 | 关键模块 |
|------|------|------|---------|
| 1. 定义能力 | Catalog JSON Schema | A2uiCatalog 实例 | CatalogConfig + Provider |
| 2. 生成 Prompt | Catalog + 角色/工作流描述 | System Prompt 字符串 | InferenceStrategy |
| 3. 流式解析 | LLM 输出流（文本块） | ResponsePart 列表 | A2uiStreamParser |
| 4. 验证修复 | 原始 JSON 字符串 | 合规 A2UI Payload | PayloadFixer + A2uiValidator |
| 5. 传输 | 已验证 Payload | A2A DataPart | createA2uiPart helper |

---

## 2. 核心接口详解

### 2.1 CatalogConfig：能力定义的入口

`CatalogConfig` 是 Catalog 的元数据描述，定义了从哪里加载 Schema、可选的 few-shot 示例路径。

```python
class CatalogConfig:
    name: str                        # Catalog 名称标识
    provider: A2uiCatalogProvider     # Schema 加载器（从包资源或文件系统）
    examples_path: Optional[str]      # few-shot 示例目录（可选）
```

| 字段 | 用途 | 注意事项 |
|------|------|---------|
| `name` | 唯一标识 Catalog | 如 `"basic"`, `"reporting"` |
| `provider` | 负责读取 JSON Schema 定义 | 优先从 SDK 打包资源加载，`specification/` 仅用于开发回退 |
| `examples_path` | 指向 few-shot 示例文件目录 | Agent 生成准确性的关键——无示例则 LLM 容易违反 Schema |

**加载优先级**：
1. SDK 包内资源（`importlib.resources` / 等价物）
2. 本地 `specification/` 目录（仅开发模式）
3. 抛出明确的 SchemaNotFound 错误

### 2.2 A2uiCatalog：已处理的 Catalog

加载后的 Catalog 对象，提供验证和 Prompt 渲染能力：

```python
class A2uiCatalog:
    name: str
    validator: A2uiValidator

    def render_as_llm_instructions(self, options: InstructionOptions) -> str:
        """将 Schema + Examples 渲染为适合注入 LLM System Prompt 的字符串"""
```

`render_as_llm_instructions()` 是 Prompt 工程的核心方法。它的输出决定了 LLM "看到"的 UI 能力描述。

| 选项 | 说明 |
|------|------|
| `include_schema` | 是否包含完整 JSON Schema |
| `include_examples` | 是否注入 few-shot 示例 |
| `validate_examples` | 是否先验证示例本身的合规性 |
| `allowed_components` | 剪枝：只暴露指定组件子集 |
| `allowed_messages` | 只允许指定消息类型 |

**最佳实践**：
- 始终包含 few-shot 示例（LLM 对示例的响应远优于纯 Schema）
- 简单 Agent 做剪枝（只暴露 `Text` + `Button` 可节省 60% token）
- 验证示例后再注入（坏示例比没有示例更糟）

### 2.3 InferenceStrategy：动态 Prompt 工程

`InferenceStrategy` 是抽象基类，定义如何将角色描述、工作流描述和 UI 描述组合成 System Prompt：

```python
class InferenceStrategy(ABC):
    @abstractmethod
    def generate_system_prompt(
        self,
        role_description: str,           # Agent 角色定义
        workflow_description: str = "",   # 工作流程指引
        ui_description: str = "",         # UI 相关描述
        client_ui_capabilities: Optional[dict] = None,  # 客户端能力声明
        allowed_components: Optional[list[str]] = None,   # 组件白名单
        allowed_messages: Optional[list[str]] = None,    # 消息类型白名单
        include_schema: bool = False,      # 注入 Schema
        include_examples: bool = False,    # 注入示例
        validate_examples: bool = False,   # 验证示例
    ) -> str:
        ...
```

#### 两种标准实现

| 实现 | 策略 | 适用场景 |
|------|------|---------|
| **A2uiSchemaManager** | 动态加载 Catalog Schema + Examples，组装为 Prompt | 通用 Agent（推荐默认） |
| **A2uiTemplateManager** | 使用预定义 UI 模板或静态结构 | 固定 UI 场景（如表单生成器） |

### 2.4 A2uiValidator：深度语义验证

`A2uiValidator` 执行超越标准 JSON Schema 检查的**深度语义和完整性验证**：

| 检查层 | 内容 | 作用 |
|--------|------|------|
| **JSON Schema** | Payload 是否符合 A2UI JSON Schema | 基础类型/结构合规 |
| **组件完整性** | 所有 ID 唯一、存在 `root` 组件 | 防止孤岛和缺失根 |
| **拓扑与可达性** | 循环引用检测、孤儿组件检测 | 所有组件必须从 root 可达 |
| **递归深度限制** | 嵌套 ≤ 50 层、函数调用 ≤ 5 层 | 防止客户端栈溢出 |
| **路径语法** | JSON Pointer 格式校验 | 确保 data binding 路径有效 |

**为什么不能只用 JSON Schema**：JSON Schema 无法表达"所有组件从 root 可达"或"无循环引用"这类**图论约束**。A2uiValidator 补充了这些语义层检查。

### 2.5 PayloadFixer：LLM 输出修复

LLM 生成的 JSON 经常有格式问题。`PayloadFixer` 在结构化解析前进行预处理：

| 修复项 | 示例 | 说明 |
|--------|------|------|
| **尾逗号** | `{"a": 1, "b": 2,}` → 移除最后一个逗号 | 最常见的 LLM JSON 错误 |
| **缺失引号** | `{name: "foo"}` → `{"name": "foo"}` | LLM 有时会省略键名引号 |
| **未闭合括号** | `{"a": [1, 2` → `{"a": [1, 2]}` | 输出截断时的典型问题 |
| **注释残留** | `{"a": 1 /* comment */}` → 移除注释 | 部分 LLM 会插入代码风格注释 |

**修复链**：PayloadFixer → JSON Parse → A2uiValidator。如果修复后仍无效，SDK 返回结构化错误。

---

## 3. 流式解析器（StreamingParser）

### 3.1 工作原理

`A2uiStreamParser` 使用 **regex 块解析**从 LLM 文本输出流中提取 A2UI JSON：

```
LLM 输出流："让我帮你创建一个表单\n<a2ui-json>\n{\"createSurface\": ...}\n</a2ui-json>\n希望这能满足需求"
                          ┌──────────────────────────┐
                          │        解析过程              │
                          └──────────────────────────┘
    文本块 → buffer → 检测 <a2ui-json> → 提取内容 → 清理 markdown → JSON 解析 → ResponsePart
```

### 3.2 标准标签协议

LLM 输出必须用标准标签包装 A2UI JSON，使解析器能确定性提取：

```
CONVERSATIONAL TEXT RESPONSE
<a2ui-json>
[{
  "version": "v1.0",
  "createSurface": { ... }
}]
</a2ui-json>
MORE CONVERSATIONAL TEXT
```

| 标签 | 用途 |
|------|------|
| `<a2ui-json>` | 开始 A2UI JSON 块 |
| `</a2ui-json>` | 结束 A2UI JSON 块 |
| 标签外文本 | 作为对话文本直接流式输出 |

### 3.3 内部机制

| 阶段 | 实现 | 说明 |
|------|------|------|
| **分块缓冲** | 内部 buffer 追加 | 文本块追加到 buffer，等待标签检测 |
| **标签检测** | 正则匹配 `<a2ui-json>` | 遇到开始标签后切换为 JSON 捕获模式 |
| **块提取** | `<a2ui-json>(.*?)</a2ui-json>` (re.DOTALL) | 提取标签间原始 JSON 字符串 |
| **清理** | 移除 `\`\`\`json` 等 markdown 分隔符 | LLM 有时在标签内包裹代码块 |
| **多块支持** | 全局搜索所有标签对 | 一个 buffer 中可包含多个 A2UI 块 |

### 3.4 高层用法

```python
parser = A2uiStreamParser(catalog=my_catalog)

for chunk in llm_stream:
    parts = parser.process_chunk(chunk)
    for part in parts:
        if part.a2ui_json:
            send_to_client(part.a2ui_json)   # UI 更新 → 客户端
        if part.text:
            stream_text(part.text)           # 对话文本 → 用户
```

---

## 4. Prompt Engineering 最佳实践

### 4.1 动态 System Prompt 组装

Agent SDK 的核心价值是**动态生成 token 高效的 System Prompt**：

```python
prompt = strategy.generate_system_prompt(
    role_description="你是一个餐厅推荐助手",
    ui_description="使用 A2UI Basic Catalog 构建结果卡片",
    allowed_components=["Card", "Text", "Image", "Button", "Row", "Column"],
    include_schema=True,
    include_examples=True,
    validate_examples=True,
)
```

**组装顺序**（推荐）：
1. 角色描述（role_description）
2. UI 能力描述（从 Catalog 渲染）
3. JSON Schema（可选，按需剪枝）
4. Few-shot 示例（强烈建议）
5. 标准标签指令（告知 LLM 用 `<a2ui-json>` 包装输出）
6. 工作流约束（workflow_description）

### 4.2 Schema 剪枝策略

当 Agent 只需部分组件时，剪枝可大幅节省 token：

| 场景 | 组件子集 | 节省比例 |
|------|---------|---------|
| 简单信息卡片 | Text, Image, Card | ~60% |
| 表单输入 | Text, TextField, Button, Column, Row, ChoicePicker | ~50% |
| 列表展示 | List, Column, Text, Card, Image, Divider | ~55% |
| 全量（不剪枝） | 全部 18 组件 | 0% |

### 4.3 Few-Shot 注入规则

| 规则 | 说明 |
|------|------|
| 示例必须合规 | 注入前用 A2uiValidator 验证 |
| 覆盖典型场景 | 至少包含：简单文本、带交互按钮、动态列表 |
| 使用标准标签 | 示例输出同样用 `<a2ui-json>` 包装 |
| 从 Catalog 的 `examples/` 目录加载 | 保持与 Schema 版本一致 |

### 4.4 标准输出格式指令

Prompt 中必须包含的输出格式指引：

```
你的 UI 输出必须用以下标签包装：
<a2ui-json>
[{"version": "v1.0", "createSurface": {...}}, ...]
</a2ui-json>

标签之外的文本作为对话内容直接展示给用户。
不要在 <a2ui-json> 标签内使用 markdown 代码块标记。
```

---

## 5. A2A Transport 集成

### 5.1 DataPart 包装

验证通过的 A2UI Payload 需要包装为 A2A 传输格式：

| 标准 | 值 | 说明 |
|------|-----|------|
| **MIME Type** | `application/a2ui+json` | 告诉渲染器如何解释流数据 |
| **Part 类型** | `DataPart` | A2A 协议标准数据块 |

```python
# 标准 helper
def create_a2ui_part(a2ui_json: dict) -> DataPart:
    return DataPart(
        mimeType="application/a2ui+json",
        data=json.dumps(a2ui_json).encode()
    )
```

### 5.2 两种输出策略

| 策略 | 触发时机 | 说明 |
|------|---------|------|
| **完整对象** | LLM 完成生成 | 整条消息作为单个 DataPart 发送 |
| **增量流式** | LLM 生成过程中 | StreamingParser 解析出完整块后立即发送 |

### 5.3 Part Converters

Part Converter 将 LLM 输出翻译为标准传输 Parts：

| 转换器 | 输入 | 输出 | 场景 |
|--------|------|------|------|
| **Tool-to-Part** | LLM 调用 UI 工具 | A2A DataPart | Agent Framework 集成模式 |
| **Text-to-Part** | LLM 文本 + `<a2ui-json>` 标签 | A2A DataPart | 标签解析模式 |

### 5.4 Event Converters

Event Converter 拦截 Agent Framework 的事件流，自动应用 Part Converter，使验证和提取在后台无缝进行，无需修改核心 Agent 逻辑。

---

## 6. Agent Framework 集成（工具化）

### 6.1 Toolset 架构

SDK 提供标准工具集（`SendA2uiToClientToolset`）将 A2UI 能力暴露给 LLM：

| 组件 | 职责 |
|------|------|
| **Dynamic Providers** | 运行时决定 A2UI 是否启用、使用哪个 Catalog |
| **UI Tool** | 暴露给 LLM 的工具（如 `send_a2ui_json_to_client`），调用前先验证 JSON |

### 6.2 集成模式

```
┌──────────────────────────────────────────────────┐
│                  Agent Framework                   │
│                                                   │
│  LLM → Tool Call → UI Tool → Schema Validate →   │
│         Part Converter → Event Converter → A2A     │
│                                                   │
└──────────────────────────────────────────────────┘
```

**关键原则**：UI Tool 在返回成功给 Framework **之前**必须完成验证。不合格的 JSON 不应触发传输。

---

## 7. Schema 管理与版本感知

### 7.1 加载原则

| 原则 | 说明 |
|------|------|
| **独立 Catalog** | 每个 Catalog 自包含类型定义或引用同目录相对路径 |
| **版本感知** | Schema Manager 必须尊重协议版本（`v0.8` 请求 → `v0.8` Schema） |
| **资源打包** | 标准 Schema 随 SDK 包分发，不依赖运行时文件系统 |

### 7.2 版本目录结构

```
specification/
  v0_8/          # v0.8 协议 + Schema
  v0_9/          # v0.9 协议 + Schema
  v0_9_1/        # v0.9.1 协议 + Schema
  v1_0/          # v1.0 协议 + Schema（当前稳定）
```

---

## 8. Basic Catalog 标准

SDK 应提供开箱即用的 Basic Catalog 配置，使 "Hello World" Agent 无需定义自定义 Schema：

```python
# Python 示例
from a2ui_sdk import BasicCatalog

config = BasicCatalog.get_config()  # 自动加载 Button/Text/Row/Column 等
catalog = A2uiCatalog(config)
```

| 语言 SDK | 等价 API |
|---------|---------|
| Python | `BasicCatalog.get_config()` |
| Kotlin | `BasicCatalog.config()` |
| C++ | `BasicCatalog::getConfig()` |

---

## 9. Agent Maintenance Skill 核心要点

Agent 维护技能的 5 条核心原则，确保 Agent 指令文件与代码库同步：

| 原则 | 说明 |
|------|------|
| **Agent 无关性** | 不使用厂商特定名称（如 "Gemini CLI"），使用通用替代（如 "helper subagent"） |
| **对抗近因偏差** | 修改文档前先用子 Agent 做客观代码审计，不依赖近期任务记忆 |
| **Specification 优先** | 更新基于 `specification/` 下的 JSON Schema，非通用 markdown |
| **关注点分离** | AGENTS.md 指向权威来源；Skills 只放任务配方，不重复 Schema |
| **Monorepo 脚本统一** | 所有 Node.js 项目使用 Yarn workspace + 标准脚本目标 |

### 维护工作流

```
1. 审计仓库（子 Agent 提取变更）
2. 分析范围（是否影响 Spec/SDK/目录结构）
3. 验证脚本卫生（package.json 脚本合规）
4. 更新 AGENTS.md（精确编辑）
5. 更新 Skills（不引入重复引用）
6. 建议变更（不自动提交）
```

---

## 10. SDK Design Skill 核心要点

SDK 设计技能的规范导航原则——如何找到正确的权威文件：

### 权威信息源（按优先级）

| 优先级 | 文件类型 | 职责 | 位置 |
|--------|---------|------|------|
| 1 | **JSON Schemas** (`json/*.json`) | 消息格式的绝对权威 | `server_to_client.json`, `client_to_server.json`, `common_types.json` |
| 2 | **Catalogs** (`catalogs/*/catalog.json`) | 组件和函数的权威定义 | `catalogs/basic/catalog.json` |
| 3 | **Protocol Guide** (`docs/a2ui_protocol.md`) | 消息流、指针作用域、双向绑定语义 | 各版本 `docs/` 目录 |
| 4 | **Renderer Guide** (`docs/renderer_guide.md`) | 状态层分离、响应式模型、订阅生命周期 | 各版本 `docs/` 目录 |

### 导航规则

- **动态探索**：用文件系统工具探索 `specification/` 目录，不硬编码活跃 Schema 路径
- **版本感知**：先确认目标版本文件夹（如 `specification/v1_0/`），再深入读取
- **全量读取**：每个核心文件应完整读取，不跳过章节

---

## 11. 多语言 SDK 移植指南

### 11.1 分阶段实现路径

| 阶段 | 目标 | 交付物 |
|------|------|--------|
| **Step 1: 核心基础** | CatalogConfig + A2uiCatalog + InferenceStrategy | 能加载 JSON 并打印 Schema |
| **Step 2: Prompt 生成** | generateSystemPrompt | 输出包含 Schema + 示例的有效 Markdown |
| **Step 3: 解析验证** | parseResponse + Validation | 通过 conformance suite 测试 |
| **Step 4: 传输** | A2A DataPart helpers | 能包装和发送 JSON |
| **Step 5: 示例应用** | 端到端 Sample | 命令行 Agent 或本地 Server |

### 11.2 语言生态映射

| Python | Kotlin | C++ |
|--------|--------|-----|
| Pydantic | kotlinx.serialization | nlohmann/json |
| importlib.resources | ClassLoader.getResource | CMake 资源嵌入 |
| pytest + conformance | JUnit + conformance | GoogleTest + conformance |

### 11.3 一致性原则

- 架构模式跨语言一致（InferenceStrategy、Validator、StreamParser）
- 协议标准跨语言一致（同版本的 Schema 产出相同验证结果）
- **实现风格应契合目标语言**（Java 用 Builder 模式，C++ 用宏，不要硬套 Python 风格）

---

## 12. 跨语言功能同步

A2UI Agent SDK 是多语言生态。功能同步流程：

```
Lead Language (Python)          Other Languages (Kotlin, C++, ...)
        │                                  ▲
        │ 1. 开发并合并                     │ 5. 实现
        │                                  │
        ▼ 2. 为其他语言创建 Issue           │
   GitHub Issues ──────────────────────────┘
        │
        ▼ 3. 在 Issue 中交叉引用原始 PR
   PR/Issue 链接
        │
        ▼ 4. 各语言独立排期
```

| 规则 | 说明 |
|------|------|
| 功能可在一种语言先实现 | 通常 Python 作为参考实现 |
| 作者**必须**为其他语言创建 Issue | 确保追踪不遗漏 |
| 交叉引用原始 PR | 保持上下文可追溯 |
| 实现风格本地化 | 架构一致，代码风格符合目标语言习惯 |

---

## 13. Conformance Testing

项目维护**语言无关的一致性测试套件**（`agent_sdks/conformance/`），确保所有 SDK 实现的流式解析和验证行为完全一致。

| 测试域 | 覆盖内容 |
|--------|---------|
| 流式解析 | 分块、多块、标签边界、markdown 清理 |
| 验证 | Schema 违规、循环引用、深度超限、路径语法 |
| 修复 | 尾逗号、缺失引号、未闭合括号 |
| 端到端 | 完整 Prompt → LLM → Parse → Validate → Transport 流程 |

---

## 14. 对 Design Taste 的启发

### Agent SDK 架构中可借鉴的模式

| SDK 模式 | Design Taste 应用 |
|----------|-------------------|
| CatalogConfig + Provider | "能力声明"模式——先声明可用组件再生成 |
| Schema 剪枝 | Token 优化意识——只给 LLM 它需要的信息 |
| Few-shot 注入 | 示例驱动——用好的示例代替冗长规则 |
| PayloadFixer | 容错思维——LLM 输出会有格式问题，先修复再验证 |
| 五阶段管道 | 管道模式——每个阶段有明确输入输出，便于调试 |
| Conformance Suite | 一致性保障——多语言/多 Agent 共享同一套测试标准 |
| Specification 优先 | 权威来源思维——Schema > 文档 > 记忆 |

---

## 15. 参考资源

- A2UI Agent SDK Guide: [agent_sdk_guide.md](https://github.com/a2ui-project/a2ui/blob/main/agent_sdks/agent_sdk_guide.md)
- A2UI Agent Maintenance Skill: [.agents/skills/a2ui-agent-maintenance/](https://github.com/a2ui-project/a2ui/blob/main/.agents/skills/a2ui-agent-maintenance/SKILL.md)
- A2UI SDK Design Skill: [.agents/skills/a2ui-sdk-design/](https://github.com/a2ui-project/a2ui/blob/main/.agents/skills/a2ui-sdk-design/SKILL.md)
- Conformance Testing: [agent_sdks/conformance/](https://github.com/a2ui-project/a2ui/tree/main/agent_sdks/conformance)
- A2UI GitHub: https://github.com/a2ui-project/a2ui
