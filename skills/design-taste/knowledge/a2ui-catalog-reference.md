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
