---
knowledge: a2ui-theming
description: >-
  A2UI 主题系统完整指南 — 从 v0.9 theme 到 v1.0 surfaceProperties 的迁移、
  CSS Variables 系统、Per-component Override、Semantic Hints、Agent 最佳实践。
  融合自 a2ui-project/a2ui theming.md + reference。
---

# A2UI 主题系统指南

> 融合自 [a2ui-project/a2ui](https://github.com/a2ui-project/a2ui) theming.md + reference

---

## §1. 概述：Agent 描述 what，Renderer 决定 how

A2UI 的主题哲学是 **Renderer-Controlled Styling**：

| 角色 | 职责 | 说明 |
|------|------|------|
| **Agent（服务端）** | 描述 UI 结构和语义 | 告诉客户端「这是一个标题」、「这是一个主按钮」 |
| **Renderer（客户端）** | 决定视觉呈现 | 选择颜色、字体、间距、动效 |
| **Catalog** | 定义主题契约 | 在 `$defs/surfaceProperties` 或 `theme` 中声明可配置属性 |

这种解耦带来的好处：

- **平台无关**：同一套 A2UI 消息在 Web、iOS、Android 上各自动用原生主题
- **品牌一致性**：Renderer 负责品牌视觉，Agent 不越界
- **渐进增强**：Agent 可以完全不关心主题，Renderer 用默认值渲染

---

## §2. v0.9 Theme 属性

在 v0.9 协议中，主题通过 `createSurface` 的 `theme` 对象传递：

```json
{
  "version": "v0.9",
  "createSurface": {
    "surfaceId": "user_profile_card",
    "catalogId": "https://a2ui.org/specification/v0_9/catalogs/basic/catalog.json",
    "theme": {
      "primaryColor": "#00BFFF"
    }
  }
}
```

### v0.9 theme 属性表

| 属性 | 类型 | 说明 |
|------|------|------|
| **primaryColor** | String | 主品牌色（十六进制），用于高亮元素（主按钮、活动边框等）。Renderer 可自动生成浅色变体 |
| **iconUrl** | URI | Agent 或工具的头像/Logo URL，用于用户界面中的身份标识 |
| **agentDisplayName** | String | Agent 或工具的显示名称，用于用户界面中的身份标识 |

### 身份标识与归属

`iconUrl` 和 `agentDisplayName` 用于在多 Agent 系统中标识哪个子 Agent 或工具负责当前 Surface：

- **Orchestrator** 负责设置或验证这些字段
- 防止恶意 Agent 冒充可信服务
- 在转发 `createSurface` 前，Orchestrator 应覆盖这些字段为已验证的身份

> ⚠️ **注意**：v0.9 的 `theme` 对象在 Basic Catalog 组件中**并未实际连接**。Basic Catalog 组件不读取 `theme` 属性。这意味着 v0.9 的 `primaryColor` 是一个声明性信号，实际渲染效果取决于 Renderer 是否支持。

---

## §3. v1.0 Surface Properties

v1.0 将 `theme` 替换为更通用的 `surfaceProperties`，移除了硬编码的品牌颜色，将视觉样式完全委托给目标框架的原生主题。

```json
{
  "version": "v1.0",
  "createSurface": {
    "surfaceId": "user_profile_card",
    "catalogId": "https://a2ui.org/specification/v1_0/catalogs/basic/catalog.json",
    "surfaceProperties": {
      "agentDisplayName": "Weather Bot"
    }
  }
}
```

### v1.0 surfaceProperties 属性表

| 属性 | 类型 | 说明 |
|------|------|------|
| **agentDisplayName** | String | 文本标识，显示在 Surface 旁边（如 "Weather Bot"） |
| **iconUrl** | URI | 图像 URL（Logo 或头像），标识 Agent 或工具 |

### v0.9 vs v1.0 对比

| 方面 | v0.9 `theme` | v1.0 `surfaceProperties` |
|------|-------------|--------------------------|
| 品牌颜色 | 有 `primaryColor` | **无** — 由 Renderer 控制 |
| 身份标识 | `iconUrl` + `agentDisplayName` | 同上（位置从 `theme` 移到 `surfaceProperties`） |
| 扩展性 | 固定字段 | 由 Catalog 的 `$defs/surfaceProperties` Schema 定义，可扩展 |
| Schema 位置 | 无严格定义 | 在 `catalog.json#/$defs/surfaceProperties` 中声明 |

---

## §4. CSS Variables 主题系统（Web）

Web 平台的 Basic Catalog Renderer 使用 CSS Variables 实现主题化。组件注入一个低特异性的样式表（`:where(:root)`），宿主应用可轻松覆盖。

### 全局 CSS 变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `--a2ui-color-primary` | `#0057b3` | 主色（按钮、链接、活动边框） |
| `--a2ui-color-primary-hover` | `#004999` | 主色悬停态 |
| `--a2ui-color-primary-active` | `#003d80` | 主色按下态 |
| `--a2ui-color-primary-subtle` | `#e8f0fe` | 主色浅色背景 |
| `--a2ui-color-text` | `#1a1a1a` | 正文文本色 |
| `--a2ui-color-text-secondary` | `#5f6368` | 次要文本色 |
| `--a2ui-color-text-inverse` | `#ffffff` | 反色文本（主色背景上） |
| `--a2ui-color-surface` | `#ffffff` | 表面背景色 |
| `--a2ui-color-surface-secondary` | `#f8f9fa` | 次要表面背景色 |
| `--a2ui-color-border` | `#dadce0` | 边框色 |
| `--a2ui-color-error` | `#d93025` | 错误色 |
| `--a2ui-color-success` | `#188038` | 成功色 |
| `--a2ui-color-warning` | `#f9ab00` | 警告色 |
| `--a2ui-card-background` | `--a2ui-color-surface` | Card 背景色 |
| `--a2ui-card-border` | `--a2ui-color-border` | Card 边框色 |
| `--a2ui-card-shadow` | `0 1px 3px rgba(0,0,0,0.12)` | Card 阴影 |
| `--a2ui-font-family-title` | 继承 | 标题字体 |
| `--a2ui-font-family-monospace` | 继承 | 等宽字体 |

### 覆盖示例

```css
:root {
  --a2ui-color-primary: #ff5722;
  --a2ui-color-primary-hover: #e64a19;
  --a2ui-card-background: #fff3e0;
  --a2ui-font-family-title: "Playfair Display", serif;
}
```

### 暗色模式

| 方式 | 方法 |
|------|------|
| **自动** | 基于系统 `prefers-color-scheme` 自动切换 |
| **强制** | 在祖先元素上添加 class `a2ui-light` 或 `a2ui-dark` |
| **编程控制** | 通过 JS 切换祖先元素的 class |

暗色模式下，Renderer 自动翻转以下变量：

- `--a2ui-color-surface` → 深色
- `--a2ui-color-text` → 浅色
- `--a2ui-color-border` → 深色边框

---

## §5. Per-component Override

每个 Basic Catalog 组件暴露自定义 CSS 变量，用于精细化调整：

| 组件 | 可覆盖变量 | 说明 |
|------|-----------|------|
| **Card** | `--a2ui-card-background`、`--a2ui-card-border`、`--a2ui-card-shadow` | 卡片背景、边框、阴影 |
| **Button** | `--a2ui-button-background`、`--a2ui-button-text`、`--a2ui-button-radius` | 按钮背景、文本色、圆角 |
| **TextField** | `--a2ui-input-background`、`--a2ui-input-border`、`--a2ui-input-radius` | 输入框背景、边框、圆角 |
| **Modal** | `--a2ui-modal-backdrop`、`--a2ui-modal-background` | 遮罩层、弹窗背景 |
| **Tabs** | `--a2ui-tab-active-color`、`--a2ui-tab-hover-color` | 标签页激活色、悬停色 |
| **Divider** | `--a2ui-divider-color` | 分隔线颜色 |

> **注意**：Per-component Override 是 Renderer 的实现细节，Agent 不应直接设置 CSS 变量。Agent 应使用 Semantic Hints（§6）来描述意图。

---

## §6. Semantic Hints

Agent 通过 `variant`（v1.0）或 `usageHint`（v0.8）提供语义提示，指导 Renderer 的视觉决策。

### Text 组件的 Semantic Hints

| 值 | 用途 | 典型渲染 |
|------|------|---------|
| `h1` | 页面主标题 | 大号粗体 |
| `h2` | 区块标题 | 中号粗体 |
| `h3` | 子区块标题 | 较小粗体 |
| `h4` | 分组标题 | 小号粗体 |
| `h5` | 最小标题 | 极小粗体 |
| `body` | 正文文本 | 默认字号 |
| `caption` | 辅助说明文字 | 小号灰色 |

### Image 组件的 Semantic Hints

| 值 | 用途 |
|------|------|
| `icon` | 小图标（16-24px） |
| `avatar` | 用户头像（40-48px） |
| `smallFeature` | 小配图 |
| `mediumFeature` | 中配图 |
| `largeFeature` | 大配图 |
| `header` | 横幅/头部大图 |

### 正确用法

```json
// ✅ Agent 说「这是正文」，Renderer 决定字号和颜色
{
  "id": "description",
  "component": "Text",
  "text": "This is product description.",
  "variant": "body"
}

// ❌ Agent 不应指定视觉属性
{
  "id": "description",
  "component": "Text",
  "text": "This is product description.",
  "fontSize": 16,
  "color": "#333333"
}
```

---

## §7. 版本迁移指南（theme → surfaceProperties）

### 从 v0.9 迁移到 v1.0

| 步骤 | 操作 | 说明 |
|------|------|------|
| 1 | 将 `createSurface` 中的 `theme` 改为 `surfaceProperties` | 字段名变更 |
| 2 | 移除 `primaryColor` | v1.0 不再支持 Agent 指定品牌色 |
| 3 | 保留 `iconUrl` 和 `agentDisplayName` | 移到 `surfaceProperties` 下 |
| 4 | 品牌色由 Renderer 通过 CSS Variables 或原生主题控制 | 宿主应用覆盖 `--a2ui-color-primary` |

### 迁移示例

```json
// v0.9
{
  "createSurface": {
    "theme": {
      "primaryColor": "#00BFFF",
      "agentDisplayName": "Weather Bot"
    }
  }
}

// v1.0
{
  "createSurface": {
    "surfaceProperties": {
      "agentDisplayName": "Weather Bot"
    }
  }
}
```

### 为什么移除 primaryColor？

v1.0 引入了 **Decoupled Branding** 理念：

| 旧模式（v0.9） | 新模式（v1.0） |
|---------------|---------------|
| Agent 说「用蓝色」 | Agent 说「这是主按钮」 |
| Renderer 听 Agent 的 | Renderer 用自己的品牌色 |
| 品牌色硬编码在 Agent 逻辑中 | 品牌色在 Renderer 层统一管理 |
| 多 Agent 场景颜色不一致 | 全应用品牌一致性 |

---

## §8. Agent 最佳实践

### 8.1 使用 Semantic Hints，不要指定视觉属性

```json
// ✅ 推荐
{"component": "Text", "text": "Welcome", "variant": "h1"}

// ❌ 不推荐
{"component": "Text", "text": "Welcome", "fontSize": 24, "color": "#000"}
```

### 8.2 利用 surfaceProperties 做身份标识

在多 Agent 场景中，始终设置 `agentDisplayName` 和 `iconUrl`：

```json
{
  "surfaceProperties": {
    "agentDisplayName": "Stock Analyzer",
    "iconUrl": "https://myapp.com/icons/stock.png"
  }
}
```

### 8.3 不要假设 Renderer 支持 theme

- v0.9 的 `theme.primaryColor` 在 Basic Catalog 中**未连接**到组件
- 如果需要在 Agent 侧控制品牌色，应在自定义 Catalog 的 `surfaceProperties` 中定义，并在 Renderer 中实现

### 8.4 利用暗色模式

- Agent 不需要指定暗色模式
- Renderer 自动根据系统偏好切换
- 若需强制，宿主应用使用 `a2ui-dark` / `a2ui-light` class

### 8.5 自定义 Catalog 中的主题

```jsonc
{
  "catalogId": "https://mycompany.com/catalogs/v1",
  "$defs": {
    "surfaceProperties": {
      "type": "object",
      "properties": {
        "agentDisplayName": {"type": "string"},
        "iconUrl": {"type": "string", "format": "uri"},
        "brandColor": {"type": "string"}  // 自定义主题属性
      }
    }
  }
}
```

### 8.6 与 Design Taste 三旋钮的交互

| 旋钮 | 主题影响 |
|------|---------|
| **DESIGN_VARIANCE** | 影响 variant 选择（h1 vs h2、icon vs avatar） |
| **MOTION_INTENSITY** | A2UI 协议不处理动效，但 Renderer 可根据 Semantic Hints 调整过渡动画 |
| **VISUAL_DENSITY** | 影响 variant 选择（body vs caption）、Card 阴影强度 |

---

## 参考

- [A2UI Theming Guide](https://github.com/a2ui-project/a2ui/blob/main/docs/guides/theming.md)
- [A2UI Component Reference](https://github.com/a2ui-project/a2ui/blob/main/docs/reference/components.md)
- [A2UI Web Renderer Default Styles](https://github.com/a2ui-project/a2ui/blob/main/renderers/web_core/src/v0_9/basic_catalog/styles/default.ts)
