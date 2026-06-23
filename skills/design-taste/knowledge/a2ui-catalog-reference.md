---
knowledge: a2ui-catalog-reference
description: >-
  A2UI v1.0 Basic Catalog 快速参考 — 18 个基础组件 + 14 个基础函数的摘要。
  供 Agent 生成 A2UI JSON 时查阅，无需记忆完整 Schema。
  完整 Schema 见：https://a2ui.org/specification/v1_0/catalogs/basic/catalog.json
---

# A2UI v1.0 Basic Catalog 参考

> **用途**：Agent 生成 A2UI JSON 时的组件/函数速查表。
> **完整定义**：`specification/v1_0/catalogs/basic/catalog.json`

---

## 1. 基础组件（18 个）

### 1.1 布局组件

| 组件 | 用途 | 关键属性 | Agent 注意 |
|------|------|---------|-----------|
| **Row** | 水平排列子组件 | `children` (ChildList), `justify` (start/center/end/spaceBetween/…), `align` (start/center/end/stretch) | 创建网格：Row 嵌套 Column |
| **Column** | 垂直排列子组件 | `children` (ChildList), `justify`, `align` | 最常用的布局容器 |
| **List** | 可滚动列表 | `children` (ChildList), `direction` (vertical/horizontal), `align` | 用模板绑定实现动态列表 |
| **Card** | 卡片容器 | `child` (单个 ComponentId) | **只能有一个子组件**，多子需先包 Column/Row |
| **Tabs** | 标签页切换 | `tabs` [{title, child}] | 每个 tab 有标题和子组件 |

### 1.2 展示组件

| 组件 | 用途 | 关键属性 | Agent 注意 |
|------|------|---------|-----------|
| **Text** | 显示文本（支持简单 Markdown） | `text` (DynamicString), `variant` (caption/body), `weight` (flex-grow) | 最常用组件，text 必填 |
| **Image** | 显示图片 | `url` (DynamicString), `description` (alt text), `fit` (contain/cover/fill/none/scaleDown), `variant` (icon/avatar/smallFeature/mediumFeature/largeFeature/header) | url 必填 |
| **Icon** | 系统图标 | `name` (枚举 60+ 图标名 或 {path: 自定义}) | 用预定义名称，不要随意发明图标名 |
| **Video** | 视频播放器 | `url` (DynamicString), `posterUrl` | url 必填 |
| **AudioPlayer** | 音频播放器 | `url` (DynamicString), `description` | url 必填 |
| **Divider** | 分隔线 | `axis` (horizontal/vertical) | 简单分隔，不滥用 |

### 1.3 交互组件

| 组件 | 用途 | 关键属性 | Agent 注意 |
|------|------|---------|-----------|
| **Button** | 可点击按钮 | `child` (ComponentId), `variant` (default/primary/borderless), `action` (Action), `checks` (验证规则) | **child + action 必填**。primary = 主 CTA |
| **TextField** | 文本输入 | `label` (DynamicString), `value` (DynamicString), `placeholder`, `variant` (shortText/longText/number/obscured), `checks` | **label 必填**。value 绑定到 dataModel |
| **CheckBox** | 复选框 | `label` (DynamicString), `value` (DynamicBoolean) | label + value 必填 |
| **ChoicePicker** | 单选/多选 | `options` [{label, value}], `value` (DynamicStringList), `variant` (mutuallyExclusive/multipleSelection), `displayStyle` (checkbox/chips), `filterable` | options + value 必填 |
| **Slider** | 滑块选择数值 | `label`, `value` (DynamicNumber), `min` (default 0), `max`, `steps` | value + max 必填 |
| **DateTimeInput** | 日期/时间输入 | `value` (DynamicString, ISO 8601), `enableDate`, `enableTime`, `min`, `max`, `label` | value 必填。需至少启用 date 或 time |
| **Modal** | 弹窗 | `trigger` (触发组件 ID), `content` (弹窗内容组件 ID) | trigger + content 必填。trigger 通常是 Button |

---

## 2. 基础函数（14 个）

### 2.1 验证函数（5 个）

| 函数 | 用途 | 关键参数 | 返回值 |
|------|------|---------|--------|
| **required** | 检查值非空 | `value` | boolean |
| **regex** | 正则匹配 | `value`, `pattern` | boolean |
| **length** | 字符串长度约束 | `value`, `min?`, `max?` | boolean |
| **numeric** | 数值范围约束 | `value`, `min?`, `max?` | boolean |
| **email** | 邮箱格式验证 | `value` | boolean |

### 2.2 格式化函数（4 个）

| 函数 | 用途 | 关键参数 | 返回值 |
|------|------|---------|--------|
| **formatString** | 字符串插值 `${...}` | `value` | string |
| **formatNumber** | 数字格式化 | `value`, `decimals?`, `grouping?` | string |
| **formatCurrency** | 货币格式化 | `value`, `currency` (ISO 4217), `decimals?` | string |
| **formatDate** | 日期格式化 | `value`, `format` (Unicode TR35) | string |

**formatDate 常用 pattern**：
- `'MMM dd, yyyy'` → `Jun 23, 2026`
- `'HH:mm'` → `14:30`（24小时制）
- `'h:mm a'` → `2:30 PM`
- `'EEEE, d MMMM'` → `Monday, 23 June`

### 2.3 逻辑函数（3 个）

| 函数 | 用途 | 关键参数 | 返回值 |
|------|------|---------|--------|
| **and** | 逻辑与 | `values` (boolean[])，minItems: 2 | boolean |
| **or** | 逻辑或 | `values` (boolean[])，minItems: 2 | boolean |
| **not** | 逻辑非 | `value` (DynamicBoolean) | boolean |

### 2.4 效果函数（2 个）

| 函数 | 用途 | 关键参数 | 返回值 |
|------|------|---------|--------|
| **openUrl** | 打开链接 | `url` (URI) | void |
| **pluralize** | 复数形式 | `value` (number), `zero/one/two/few/many/other` | string |

### 2.5 系统函数

| 函数 | 用途 | 约束 |
|------|------|------|
| **@index** | 列表模板中当前项索引 | 仅在 Collection Scope 中可用。`@index(offset: 1)` = 1-based |

---

## 3. 属性速记

### 3.1 所有组件共有属性（ComponentCommon）

| 属性 | 类型 | 说明 |
|------|------|------|
| `id` | ComponentId | **必填**。唯一标识符 |
| `component` | string (const) | **必填**。组件类型名 |
| `accessibilityLabel` | string | 无障碍标签 |
| `tooltip` | string | 悬停提示 |
| `visible` | DynamicBoolean | 可见性绑定 |
| `weight` | number | flex-grow 权重，仅在 Row/Column 直接子元素中有效 |

### 3.2 通用数据绑定类型

| 类型 | 接受的值 |
|------|---------|
| **DynamicString** | 字面量字符串 / `{"path": "/data/field"}` / `{"call": "funcName", "args": {...}}` |
| **DynamicNumber** | 同上 |
| **DynamicBoolean** | 同上 |
| **DynamicStringList** | 同上 |
| **DynamicValue** | 同上（用于多类型场景） |

### 3.3 子组件引用类型

| 类型 | 用法 |
|------|------|
| **ComponentId** | 单个子组件引用（如 Card.child、Button.child） |
| **ChildList** | 子组件列表，支持 `array`（固定列表）或 `object`（模板绑定） |

**ChildList 模板语法**：
```json
{
  "path": "/users",
  "componentId": "user_card_template"
}
```
表示从 DataModel 的 `/users` 数组中，为每项创建一个 `user_card_template` 组件实例。

---

## 4. Catalog 自定义指南

### 4.1 何时自定义 Catalog

| 场景 | 建议 |
|------|------|
| Chat 富卡片、工具结果 | **Basic Catalog 足够** |
| 品牌化应用（自定义品牌色/字体/组件） | **自定义 Catalog** |
| 需要特定业务组件（如 ProductCard/OrderStatus） | **自定义 Catalog** |
| 需要嵌入已有 React/SwiftUI 组件 | **Smart Wrapper** |

### 4.2 自定义 Catalog 结构

```json
{
  "catalogId": "https://mycompany.com/catalogs/v1",
  "instructions": "品牌设计指导，给 LLM 读的 Markdown",
  "components": {
    "ProductCard": { /* JSON Schema 定义 */ },
    "BrandButton": { /* 继承 Basic Catalog Button + 自定义样式 */ }
  },
  "functions": {
    "validatePhoneNumber": { /* 自定义验证函数 */ }
  },
  "surfaceProperties": { /* 自定义视觉属性 */ }
}
```

### 4.3 Smart Wrapper

A2UI 支持将已有的原生组件（React、SwiftUI 等）包装为 A2UI 兼容组件。安全边界完全由开发者控制：

- Agent 只能传递数据参数
- 实现代码在 Client 侧
- 可设置 iframe 沙箱隔离

### 4.4 与 Design Taste 三旋钮的交互

| 旋钮 | A2UI 中的影响 |
|------|--------------|
| **DESIGN_VARIANCE** | 影响 Row/Column 的 `justify`/`align` 组合、Card 排列方式 |
| **MOTION_INTENSITY** | A2UI 协议本身不处理动效（由渲染器实现），但可影响 Surface 选择 |
| **VISUAL_DENSITY** | 影响 Text 的 `variant`（caption vs body）、Image 的 `variant`、Card 嵌套深度 |

---

## 5. 完整 60+ 图标名称速查

AccountCircle, Add, ArrowBack, ArrowForward, AttachFile, CalendarToday, Call, Camera, Check, Close, Delete, Download, Edit, Event, Error, FastForward, Favorite, FavoriteOff, Folder, Help, Home, Info, LocationOn, Lock, LockOpen, Mail, Menu, MoreVert, MoreHoriz, NotificationsOff, Notifications, Pause, Payment, Person, Phone, Photo, Play, Print, Refresh, Rewind, Search, Send, Settings, Share, ShoppingCart, SkipNext, SkipPrevious, Star, StarHalf, StarOff, Stop, Upload, Visibility, VisibilityOff, VolumeDown, VolumeMute, VolumeOff, VolumeUp, Warning

> 也可用 `{"path": "M12 2L2 7..."}` 传入自定义 SVG path。

---

## §6. Catalog Schema 严格规则

> 本节内容融合自 [A2UI v1.0 协议规范](https://github.com/a2ui-project/a2ui) 的 Schema Rules and Conventions、Validator Compliance、UAX#31 命名规则。

### §6.1 七条 Schema Rules and Conventions

所有 v1.0 Catalog 定义 **MUST** 遵守以下七条严格约束，确保 Schema 可被自动翻译为 LLM 友好的 DSL 格式、映射到类型安全的 Client SDK、并在多平台间可靠绑定。

| # | 规则 | 描述 | 违规后果 |
|---|------|------|---------|
| 1 | **严格 top-level / `$defs` 边界** | 组件和函数 Schema 必须声明在 `components` / `functions` 顶层。外部引用的定义（`surfaceProperties`、`anyComponent`、`anyFunction`）必须放在 `$defs` 中 | Validator 无法解析 Catalog |
| 2 | **禁止自定义 `$defs`** | `$defs` 只允许三个键：`anyComponent`、`anyFunction`、`surfaceProperties`。所有辅助属性必须内联（inline）到组件 properties 中 | 验证器拒绝非标准 `$defs` |
| 3 | **限制 `$ref` 目标** | 本地 `$ref` 只能引用 `#/components/XXX` 或 `#/functions/XXX`。外部 `$ref` 只能引用 `common_types.json` 中的 9 种标准类型（ComponentId、ChildList、DynamicString、DynamicNumber、DynamicBoolean、DynamicStringList、DynamicValue、CheckRule、ComponentCommon、Checkable、Action） | Schema 编译失败 |
| 4 | **Component Discriminator** | 每个组件必须有一个 `component` 属性，其 `const` 值等于它在 `components` 中的 key。例如 `components.Text` 必须有 `"component": {"const": "Text"}` | 路由分发（discriminator）失效 |
| 5 | **allOf 结构规范** | 所有组件必须使用 `allOf` 组合：① `$ref` 引用 `ComponentCommon`；② 本地对象定义该组件的特有属性 | 缺少 `ComponentCommon` 时无障碍/可见性属性丢失 |
| 6 | **Function 接口模式** | 每个函数必须有 `call` 属性（const = 函数名）、可选的 `args`、以及元数据字段 `returnType`（string/number/boolean/array/object/any/void）和 `callableFrom`（clientOnly/remoteOnly/clientOrRemote） | 函数无法被自动路由 |
| 7 | **严格 top-level keys** | `catalog.json` 只允许以下顶层键：`$schema`、`$id`、`title`、`description`、`catalogId`、`instructions`、`components`、`functions`、`$defs` | 额外 key 被验证器忽略或拒绝 |

**示例：符合规则的组件定义**

```jsonc
{
  "components": {
    "Text": {
      "type": "object",
      "allOf": [                          // Rule 5: allOf 结构
        {"$ref": "common_types.json#/$defs/ComponentCommon"},
        {
          "type": "object",
          "properties": {
            "component": {"const": "Text"},  // Rule 4: Discriminator
            "text": {"$ref": "common_types.json#/$defs/DynamicString"}
          },
          "required": ["component", "text"]
        }
      ],
      "unevaluatedProperties": false
    }
  },
  "$defs": {                              // Rule 2: 只有三个允许的键
    "anyComponent": { /* ... */ },
    "anyFunction": { /* ... */ },
    "surfaceProperties": { /* ... */ }
  }
}
```

---

### §6.2 Validator 合规规则

Catalog 定义必须满足以下验证器约束，确保 UI 树可被自动检查完整性：

| 规则 | 要求 | 说明 |
|------|------|------|
| **ComponentId 类型强制** | 子组件引用属性必须使用 `$ref: "common_types.json#/$defs/ComponentId"`，不能用 `"type": "string"` | Validator 通过 `$ref` 识别结构链接；用 raw string 会被当作静态文本跳过检查 |
| **ChildList 类型强制** | 子组件列表属性必须使用 `$ref: "common_types.json#/$defs/ChildList"` | 同上 |
| **拓扑完整性检查** | 所有组件必须从 root 可达，不能有孤儿组件 | 不可达组件不会渲染，浪费带宽 |
| **循环引用检测** | 组件不能直接或间接引用自身作为子组件 | 导致无限递归渲染 |
| **递归深度限制** | 组件树递归深度受渲染器限制（通常 ≤ 64 层） | 深度嵌套会导致栈溢出 |

> **最佳实践**：Agent 生成 UI 后，应通过 `A2uiValidator`（Python SDK）或等效工具自动检查上述规则。

---

### §6.3 UAX#31 命名规则

所有 Catalog 实体标识符——**组件名、函数名、参数/属性名**——必须遵守 [Unicode Standard Annex #31](https://www.unicode.org/reports/tr31/) 变量命名规则。

#### 三条规则

| # | 规则 | 说明 |
|---|------|------|
| 1 | **首字符** | 必须以 `XID_Start` 或下划线 `_`（U+005F）开头 |
| 2 | **后续字符** | 后续字符必须属于 `XID_Continue` |
| 3 | **禁止字符** | 不能包含空格、`Pattern_Syntax`、`Pattern_White_Space`；不能以数字（`Nd`）开头 |

#### 正则表达式

```regex
^[\p{XID_Start}_][\p{XID_Continue}]*$
```

#### 示例

| 合法 | 非法 | 原因 |
|------|------|------|
| `UserProfileCard` | `User Card` | 含空格（Pattern_White_Space） |
| `submit_form` | `1stItem` | 以数字开头（Nd） |
| `item_id_1` | `submit-form` | 连字符（Pattern_Syntax） |
| `_internal_state` | `user#name` | `#` 号（Pattern_Syntax） |
| `ProductCard123` | `calc$val` | `$` 号（Pattern_Syntax） |

> **注意**：这条规则适用于 v1.0 及以上版本。v0.8/v0.9 没有强制 UAX#31，但建议也遵守以保持向前兼容。

---

### §6.4 自定义 Catalog 定义指南

#### catalogId 命名规范

| 要素 | 规范 |
|------|------|
| **格式** | URI 格式，如 `https://mycompany.com/catalogs/v1` |
| **用途** | 全局唯一标识符，用于协商 |
| **不下载** | URI 仅作标识，不表示运行时下载 |
| **版本化** | 建议在 URI 中包含版本号（如 `/v1/`、`/v2/`） |

#### 组件扩展模式

```jsonc
{
  "catalogId": "https://mycompany.com/catalogs/v1",
  "instructions": "品牌设计指导，给 LLM 读的 Markdown",
  "components": {
    "ProductCard": {
      "allOf": [
        {"$ref": "https://a2ui.org/specification/v1_0/common_types.json#/$defs/ComponentCommon"},
        {
          "type": "object",
          "properties": {
            "component": {"const": "ProductCard"},
            "productName": {"$ref": "common_types.json#/$defs/DynamicString"},
            "price": {"$ref": "common_types.json#/$defs/DynamicString"},
            "image": {"$ref": "common_types.json#/$defs/DynamicString"},
            "action": {"$ref": "common_types.json#/$defs/Action"}
          },
          "required": ["component", "productName"]
        }
      ]
    }
  },
  "$defs": {
    "anyComponent": {
      "oneOf": [{"$ref": "#/components/ProductCard"}],
      "discriminator": {"propertyName": "component"}
    },
    "anyFunction": { /* ... */ },
    "surfaceProperties": { /* ... */ }
  }
}
```

#### Smart Wrapper 模式

将已有原生组件（React、SwiftUI、Flutter）包装为 A2UI 兼容组件：

| 特性 | 说明 |
|------|------|
| **安全边界** | Agent 只能传递数据参数，实现代码在 Client 侧 |
| **Schema 定义** | 在 catalog 中定义组件 Schema，Client 实现 renderer |
| **隔离** | 可设置 iframe 沙箱隔离（Web）或独立 ViewController（Native） |

---

### §6.5 Catalog 协商协议

#### 客户端能力声明（ClientCapabilities）

客户端在 **每条消息的 metadata** 中携带 `a2uiClientCapabilities`：

```json
{
  "metadata": {
    "a2uiClientCapabilities": {
      "supportedCatalogIds": [
        "https://a2ui.org/specification/v1_0/catalogs/basic/catalog.json",
        "https://mycompany.com/catalogs/v1"
      ]
    }
  }
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `supportedCatalogIds` | string[] | **必填**。客户端支持的所有 Catalog ID，按偏好排序 |
| `inlineCatalogs` | object[] | **可选**。运行时内联 Catalog 定义（仅当服务端声明 `acceptsInlineCatalogs: true` 时可用） |

#### 服务端适配策略

| 步骤 | 动作 |
|------|------|
| 1 | Agent 收到 ClientCapabilities，匹配 `supportedCatalogIds` 中的最佳 Catalog |
| 2 | 在 `createSurface` 中设置 `catalogId` 为该 Catalog |
| 3 | 每个 Surface 可独立选择 Catalog（多 Agent 场景下灵活） |
| 4 | 若无匹配 Catalog，Agent 不应发送 UI（fallback 到纯文本） |

#### 版本迁移策略

| 阶段 | 客户端 `supportedCatalogIds` | Agent 行为 |
|------|---------------------------|-----------|
| 过渡期 | `[".../v2/", ".../v1/"]` | 优先选 v2，v1 作为 fallback |
| 完全迁移 | `[".../v2/"]` | 仅使用 v2 |
| 回滚 | `[".../v1/"]` | 仅使用 v1 |

---

### §6.6 合规检查清单

Agent 生成自定义 Catalog 后，逐项检查以下清单：

| # | 检查项 | 参考 |
|---|--------|------|
| ☐ | catalogId 是 URI 格式且包含版本号 | §6.4 |
| ☐ | 所有组件名、函数名、属性名符合 UAX#31 | §6.3 |
| ☐ | 组件使用 `allOf` 结构（ComponentCommon + 本地属性） | §6.1 Rule 5 |
| ☐ | 每个组件有 `component` const 属性 | §6.1 Rule 4 |
| ☐ | `$ref` 只引用允许的目标 | §6.1 Rule 3 |
| ☐ | `$defs` 只有 `anyComponent` / `anyFunction` / `surfaceProperties` | §6.1 Rule 2 |
| ☐ | 子组件引用使用 `ComponentId` 类型（非 raw string） | §6.2 |
| ☐ | 子组件列表使用 `ChildList` 类型 | §6.2 |
| ☐ | 函数有 `returnType` 和 `callableFrom` 元数据 | §6.1 Rule 6 |
| ☐ | 无循环引用（组件不引用自身作为子组件） | §6.2 |
| ☐ | 所有组件从 root 可达 | §6.2 |
| ☐ | 无额外 top-level keys | §6.1 Rule 7 |
| ☐ | `surfaceProperties` 定义在 `$defs` 中（如适用） | §6.1 Rule 1 |
| ☐ | 若使用内联 Catalog，确保服务端声明了 `acceptsInlineCatalogs` | §6.5 |

> 提示：可用 `A2uiValidator`（Python SDK）自动检查上述大部分规则。
