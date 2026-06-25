---
knowledge: a2ui-mcp-integration
status: preview
description: >-
  [前瞻] A2UI × MCP 集成指南 — 三种互补集成模式，围绕 application/a2ui+json 统一 MIME 类型。
  A2UI 协议尚未在 OpenClaw 中原生支持，此文件为前瞻性知识储备。
---

# A2UI × MCP 集成指南

> 融合自 [a2ui-project/a2ui](https://github.com/a2ui-project/a2ui) 三篇 MCP 集成指南

---

## §1. 概述

A2UI 与 Model Context Protocol (MCP) 之间存在三种互补的集成模式，都围绕 **`application/a2ui+json`** 统一 MIME 类型展开。

### 1.1 三种模式对比

| 模式 | 方向 | 核心思路 | 适用场景 |
|------|------|---------|---------|
| **A2UI over MCP** | MCP Server → Client | Server 通过 Resource/Tool 返回 A2UI JSON，Client 渲染 | Agent 工具返回富交互 UI |
| **MCP Apps in A2UI** | MCP App → A2UI Surface | 第三方 MCP App 通过双 iframe 沙箱嵌入 A2UI | 安全运行不可信第三方 UI |
| **A2UI in MCP Apps** | A2UI → MCP App | MCP App 内部包含 A2UI Surface，实现动态 UI 更新 | MCP App 内部需要 Agent 驱动的 UI |

### 1.2 关系图

```
┌──────────┐  ① A2UI over MCP   ┌──────────┐
│ MCP      │ ◄─────────────────► │ MCP      │
│ Server   │  Resource/Tool 返回  │ Client   │
└────┬─────┘   A2UI JSON 负载    └────┬─────┘
     │ ③ A2UI in MCP Apps            │ ② MCP Apps in A2UI
     ▼                                ▼
┌──────────────────────────────────────────┐
│  MCP App (双 iframe 沙箱)                │
│  ┌──────────────────────────────────┐   │
│  │  A2UI Surface (动态 Agent UI)    │   │
│  └──────────────────────────────────┘   │
└──────────────────────────────────────────┘
```

---

## §2. A2UI over MCP（服务端架构 + 消息流）

### 2.1 两种交付方式

MCP Server 通过两种方式交付 A2UI 内容：

1. **Resource 读取**（`resources/read`）：Client 直接读取 MCP Resource，获取 A2UI JSON。适合静态 UI（表单、配置面板）。
2. **Tool 调用**（`tools/call`）：Client 调用 MCP Tool，Server 在 `CallToolResult` 中通过 `EmbeddedResource` 返回 A2UI JSON。适合动态 UI。

### 2.2 消息流

```
① Resource 模式（静态 UI）
Client ──resources/read──► MCP Server ──► A2UI JSON ──► Client ◄──ResourceContents── MCP Server
                                                                 (application/a2ui+json)
                                                                    │
                                                              A2UI Renderer 渲染

② Tool 模式（动态 UI）
Client ──tools/call──► MCP Server ──► 生成 A2UI JSON ──► 包装为 EmbeddedResource ──► Client ◄──CallToolResult
                                                                                         │
                                                                                   A2UI Renderer 渲染
```

### 2.3 Tool 定义与响应

```python
@app.list_tools()
async def list_tools() -> list[types.Tool]:
    return [
        types.Tool(
            name="get_recipe_a2ui",
            description="Generate a dynamic recipe card as A2UI",
            inputSchema={
                "type": "object",
                "properties": {
                    "cookingStyle": {"type": "string"},
                    "protein": {"type": "string"},
                },
            },
        )
    ]

@app.call_tool()
async def handle_call_tool(name: str, arguments: dict) -> types.CallToolResult:
    if name == "get_recipe_a2ui":
        custom_recipe_json = build_a2ui_payload(arguments)
        return types.CallToolResult(content=[
            types.EmbeddedResource(
                type="resource",
                resource=types.TextResourceContents(
                    uri="a2ui://recipe-card",
                    mimeType="application/a2ui+json",
                    text=json.dumps(custom_recipe_json),
                )
            )
        ])
```

> **最佳实践**：始终在 `CallToolResult` 中包含 `TextContent` 作为降级方案，供不支持 A2UI 的 Client 显示文本。

### 2.4 Surface 管理

Server 通过 `surfaceId` 管理多个 A2UI Surface 的状态和生命周期：

```json
{
  "type": "surface",
  "surfaceId": "recipe-card",
  "messages": [
    { "type": "dataModelUpdate", "dataModel": { ... } },
    { "type": "updateComponents", "components": [ ... ] }
  ]
}
```

### 2.5 客户端能力协商

MCP 是状态化会话协议，推荐在 `initialize` 阶段协商 A2UI 能力：

```json
{
  "method": "initialize",
  "params": {
    "protocolVersion": "2025-11-25",
    "clientInfo": { "name": "a2ui-enabled-client", "version": "1.0.0" },
    "capabilities": {
      "a2ui": {
        "clientCapabilities": {
          "v0.9": {
            "supportedCatalogIds": ["https://a2ui.org/specification/v0_9/catalogs/basic/catalog.json"]
          }
        }
      }
    }
  }
}
```

对于无状态 Server，可在每次 `tools/call` 的 `_meta` 字段中携带：

```json
{
  "method": "tools/call",
  "params": {
    "name": "generate_report",
    "arguments": {"date": "2026-03-01"},
    "_meta": {
      "a2ui": {
        "clientCapabilities": {
          "v0.9": { "supportedCatalogIds": [...], "inlineCatalogs": [] }
        }
      }
    }
  }
}
```

### 2.6 用户操作处理

交互组件触发 Action，Client 转换为 MCP Tool 调用：

```json
{
  "id": "confirm-button",
  "component": {
    "Button": {
      "child": "confirm-button-text",
      "action": {
        "event": {
          "name": "confirm_booking",
          "context": { "start": "/dates/start", "end": "/dates/end" }
        }
      }
    }
  }
}
```

Client 解析数据绑定后发送：

```json
{
  "method": "tools/call",
  "params": {
    "name": "action",
    "arguments": {
      "name": "confirm_booking",
      "context": { "start": "2026-03-20", "end": "2026-03-25" }
    }
  }
}
```

Server 端处理：

```python
@self.tool()
async def action(name: str, context: dict) -> types.CallToolResult:
    if name == "confirm_booking":
        return types.CallToolResult(content=[
            types.TextContent(type="text", text=f"Booking confirmed: {context['start']} to {context['end']}")
        ])
    raise ValueError(f"Unknown action: {name}")
```

### 2.7 生命周期

| 阶段 | 动作 | 说明 |
|------|------|------|
| 初始化 | `initialize` 协商 A2UI 能力 | 声明支持的 Catalog |
| 资源获取 | `resources/read` 或 `tools/call` | 获取 A2UI JSON |
| 交互 | `tools/call`（action） | 用户操作回传 |
| 错误 | `tools/call`（error） | 渲染错误上报 |
| 结束 | 会话关闭 | 清理 Surface 状态 |

### 2.8 可见性控制（Verbalization）

通过 Resource Annotations 控制 LLM 是否看到 A2UI 负载：

```python
annotations=types.Annotations(audience=["user"])
```

| Audience | 行为 |
|----------|------|
| _(空)_ | 用户和 LLM 都可见 |
| `["user"]` | 渲染给用户，LLM 上下文隐藏 |
| `["assistant"]` | LLM 可读，不渲染给用户 |

---

## §3. MCP Apps in A2UI（嵌入架构 + 安全模型）

### 3.1 双 iframe 隔离模式

```
┌──────────────────────────────────────┐
│  Host Application                    │
│  ┌────────────────────────────────┐  │
│  │  Sandbox Proxy (sandbox.html)  │  │  ← 同源，无沙箱
│  │  ┌──────────────────────────┐  │  │
│  │  │  MCP App (内层 iframe)    │  │  │  ← srcdoc，有沙箱
│  │  │  sandbox="allow-scripts   │  │  │
│  │  │  allow-forms allow-popups │  │  │
│  │  │  allow-modals"            │  │  │
│  │  │  ⛔ 无 allow-same-origin  │  │  │
│  │  └──────────────────────────┘  │  │
│  └────────────────────────────────┘  │
└──────────────────────────────────────┘
```

### 3.2 安全原理

| 层 | 沙箱属性 | 权限 |
|----|---------|------|
| 外层（Sandbox Proxy） | **无沙箱**，同源 | 可与 Host 直接 postMessage |
| 内层（MCP App） | `allow-scripts allow-forms allow-popups allow-modals` | **无** `allow-same-origin`，无法访问 localStorage/cookies/IndexedDB |

> **为什么排除 `allow-same-origin`**：任何同时拥有 `allow-scripts` 和 `allow-same-origin` 的 iframe 都可以编程逃逸沙箱。严格排除此属性确保内层 App 运行在唯一 origin 中。

### 3.3 消息传递协议

通信通过 **JSON-RPC over postMessage** 进行：

```
MCP App ──postMessage──► Sandbox Proxy ──postMessage──► Host
    │                                                       │
    │                    ◄──────────────────────────────────┘
    │                    Tool 结果返回
    ▼
A2UI Renderer 更新 UI
```

```typescript
// MCP App 内部
const bridge = new AppBridge({name: 'editor-panel', version: '1.0.0'});
await bridge.connect();
const result = await bridge.callServerTool({name: 'fetch_controls', arguments: {}});
```

### 3.4 Catalog 注册

MCP App 组件在 A2UI Catalog 中注册为 `custom` 节点：

```typescript
export const DEMO_CATALOG = {
  McpApp: {
    type: () => import('./mcp-app').then(r => r.McpApp),
    bindings: ({properties}) => [
      inputBinding('content', () => properties['content'] || undefined),
      inputBinding('title', () => properties['title'] || undefined),
    ],
  },
} as Catalog;
```

A2UI 消息中使用：

```json
{
  "type": "custom",
  "name": "McpApp",
  "properties": {
    "content": "<h1>Hello, World!</h1>",
    "title": "My MCP App"
  }
}
```

### 3.5 安全限制

| 能力 | 可用性 | 原因 |
|------|--------|------|
| localStorage/sessionStorage/IndexedDB/Cookies | ❌ | 唯一 origin，无持久存储 |
| postMessage 通信 | ✅ | 通过 Sandbox Proxy 中继 |
| DOM 操作（内部） | ✅ | 在 iframe 内部自由 |
| 直接访问父 DOM | ❌ | 沙箱隔离 |

### 3.6 测试参数

```
http://localhost:4200/?disable_security_self_test=true
```

`disable_security_self_test=true` 绕过安全自检，用于开发调试。

---

## §4. A2UI in MCP Apps（输出模式 + DataPart 格式）

### 4.1 架构

MCP App 内部包含 A2UI Surface，自身负责渲染 A2UI 负载：

```
MCP Server ──► Client Host ──► Sandbox Proxy ──► MCP App ──► A2UI Surface
```

### 4.2 DataPart 格式

Tool 响应中的 A2UI 负载以 `application/a2ui+json` MIME 类型嵌入：

```json
{
  "content": [{
    "type": "resource",
    "resource": {
      "uri": "a2ui://counter-panel",
      "mimeType": "application/a2ui+json",
      "text": "[{\"type\":\"surface\",\"surfaceId\":\"counter\",\"messages\":[...]}]"
    }
  }]
}
```

MCP App 端提取：

```typescript
const a2uiResource = result.find(
  c => c.type === 'resource' &&
    (c.resource?.mimeType === 'application/a2ui+json' || c.resource?.mimeType === 'application/json+a2ui')
);
if (a2uiResource?.resource?.text) {
  this.processor.processMessages(JSON.parse(a2uiResource.resource.text));
}
```

### 4.3 通信流程

```
MCP Server ──① tools/call──► Client Host ──③ 转发──► Sandbox Proxy ──④ 传递──► MCP App
    ▲                           │                                                    │
    │                           ② 返回 A2UI JSON                                   ⑤ processMessages()
    └───────────────────────────┘                                                    │
                                                                               A2UI Surface
                                                                                    │
                                                                              ⑥ userAction
```

### 4.4 用户操作处理

```typescript
this.processor.events.subscribe(async event => {
  if (!event.message.userAction) return;
  const method = `ui/${event.message.userAction.name}`;
  const params = event.message.userAction.context;
  try {
    const result = await callHostMethod(method, params);
    const messages = extractA2UIMessages(result);
    if (messages) this.processor.processMessages(messages);
  } catch (error) {
    console.error(`Error handling user action[${method}]:`, error);
  }
});
```

### 4.5 MCP App 内联打包

MCP App 通常作为单个 HTML 资源提供。使用 `vite-plugin-singlefile` 将所有 JS/CSS 内联：

```bash
npm install -D vite-plugin-singlefile
```

```typescript
// vite.config.ts
import {defineConfig} from 'vite';
import {viteSingleFile} from 'vite-plugin-singlefile';
export default defineConfig({ plugins: [viteSingleFile()] });
```

### 4.6 与 A2A 传输的对比

| 特性 | MCP 传输 | A2A 传输 |
|------|---------|---------|
| 协议 | JSON-RPC over SSE/stdio | HTTP (A2A) |
| 传输方向 | 双向（状态化会话） | 请求-响应 |
| A2UI 嵌入 | `EmbeddedResource` in `CallToolResult` | 直接在响应体中 |
| 适用场景 | 工具调用 + UI 返回 | Agent 间通信 + UI 返回 |

**混合场景**：MCP Server 通过 MCP 协议接收工具调用，内部使用 A2A 协议与其他 Agent 协作获取数据，最终以 A2UI JSON 返回。

---

## §5. 集成模式选择决策树

```
需要向 MCP Client 返回富交互 UI？
├── 是 → A2UI over MCP
│   ├── UI 静态（表单/配置面板）？ → 用 MCP Resource（resources/read）
│   └── UI 动态生成（依赖输入/数据库）？ → 用 MCP Tool（tools/call + EmbeddedResource）
│
需要安全运行第三方 MCP App？
├── 是 → MCP Apps in A2UI
│   ├── 需要持久存储？ → ⚠️ 受限，App 无法使用 localStorage/cookies
│   ├── 需要与原生 A2UI 组件交互？ → 通过 postMessage + JSON-RPC 桥接
│   └── 需要状态同步？ → 通过 Agent 的 dataModelUpdate 推送
│
MCP App 内部需要 Agent 驱动的动态 UI？
├── 是 → A2UI in MCP Apps
│   ├── App 需要自包含？ → 内联打包（vite-plugin-singlefile）
│   ├── 需要处理用户交互？ → 订阅 processor.events → callHostMethod
│   └── 需要与 A2A 混合？ → MCP 调用 + A2A 代理协作
│
都不匹配 → 考虑直接使用 A2UI（无 MCP）
```

---

## §6. 最佳实践与常见陷阱

### 6.1 最佳实践

| # | 实践 | 说明 |
|---|------|------|
| 1 | **始终提供降级文本** | Tool 响应中同时包含 `TextContent` 和 `EmbeddedResource` |
| 2 | **初始化时协商能力** | 优先在 `initialize` 阶段声明 A2UI 支持 |
| 3 | **使用 A2UI Agent SDK** | `pip install a2ui-agent-sdk` 处理 Schema 管理和验证 |
| 4 | **显式 targetOrigin** | postMessage 中指定具体 origin，避免使用 `*` |
| 5 | **内联打包 MCP App** | 使用 `vite-plugin-singlefile` 生成单 HTML 文件 |
| 6 | **严格沙箱配置** | 内层 iframe 永远不加 `allow-same-origin` |
| 7 | **使用 Resource Annotations** | 控制 A2UI JSON 对 LLM 的可见性 |
| 8 | **统一 MIME 类型** | 始终使用 `application/a2ui+json` |

### 6.2 常见陷阱

| 陷阱 | 现象 | 解决方案 |
|------|------|---------|
| **MIME 类型不一致** | Client 无法识别 A2UI 负载 | 统一使用 `application/a2ui+json` |
| **忘记降级文本** | 不支持 A2UI 的 Client 看到空响应 | 始终添加 `TextContent` |
| **沙箱逃逸** | 内层 iframe 访问了父 DOM | 检查是否误加了 `allow-same-origin` |
| **postMessage origin 未验证** | 恶意 iframe 劫持通信 | 验证 `event.source` 和 `event.origin` |
| **内联打包遗漏** | MCP App 加载时缺少 CSS/JS | 使用 `vite-plugin-singlefile` |
| **状态不同步** | A2UI Surface 与 MCP App 状态不一致 | 通过 `dataModelUpdate` 统一推送 |
| **安全自检失败** | 开发环境双 iframe 隔离检查失败 | 添加 `?disable_security_self_test=true` |
| **Catalog 未注册** | `custom` 节点无法渲染 | 确保组件已在 Catalog 中注册 |

### 6.3 快速参考

| 模式 | Server 端 | Client 端 |
|------|-----------|-----------|
| A2UI over MCP | `@app.tool()` 返回 `EmbeddedResource(mimeType="application/a2ui+json")` | 解析 `CallToolResult`，提取 A2UI JSON 传给 Renderer |
| MCP Apps in A2UI | 提供 MCP App 资源（单 HTML） | 注册 `McpApp` 自定义组件，双 iframe 加载 |
| A2UI in MCP Apps | Tool 返回 A2UI JSON | MCP App 内嵌 `a2ui-surface`，`processor.processMessages()` |

---

> **延伸阅读**：
> - [A2UI v1.0 Basic Catalog 参考](a2ui-catalog-reference.md) — 组件/函数速查
> - [A2UI 规范](https://a2ui.org/specification/v0.9-a2ui.md) — 完整协议参考
> - [A2UI Agent SDK](https://pypi.org/project/a2ui-agent-sdk/) — Python SDK
