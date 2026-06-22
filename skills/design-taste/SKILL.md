---
name: design-taste
description: >-
  设计品味校准框架 v4 — 全面升级版。吸收 taste-skill 原版精华（Pre-Flight Check / AI Tells 目录 / Em-Dash 禁令 / 内容密度规则 / Redesign Protocol / Motion 规范骨架 / Dark Mode Protocol），
  保留 B端制造业/画册/官网/生图/邮件模板特化。
  适配：UI/前端/页面/画册/官网/生图/样式/排版/布局/重新设计/邮件/email/template/EDM/Newsletter。
  内建容错：Pre-Flight Check → 不合格自动打回。
---

# Design Taste v4 — 设计品味校准框架

> **核心理念**：AI 输出的默认值 = 模板感、无品味。
> 但规则不是死的——每条都有**适用场景**和**突破条件**。
> 真正的品味 = 知道什么时候遵守规则，什么时候打破规则。

> **工作流**：读房间 → 调旋钮 → 选美学 → 写 Read → 派活 → 检查 → 打回或交付。

---

## 0. Brief Inference（读前确认）

**禁止拿到任务直接开干。** 先输出 Design Read。

### 0.A 读取信号

1. **载体类型** — 产品画册 / 官网首页 / 产品页 / 场景页 / 生图 / Logo / 海报 / 邮件模板 / Landing Page / 品牌手册 / B端SaaS后台 / Dashboard
2. **任务模式** — 新建（Greenfield）/ 优化保留（Redesign-Preserve）/ 推翻重来（Redesign-Overhaul）
3. **受众** — 海外B端买家 / 国内经销商 / 终端消费者 / 双受众 / 招聘方 / B端销售/市场团队
4. **品牌调性关键词** — 用户用过的词："洁白干净""专业""实拍感""自然""工业""高端""premium""极简""Linear风""Apple风"
5. **已有品牌资产** — Logo、品牌色、已生成的图片、参考图、现有网站 URL
6. **约束条件** — 中英双语 / 多语言 / 三端响应式 / 移动优先 / 打印尺寸 / 字数限制 / 邮件客户端兼容
7. **静默约束** — 合规行业（食品/医疗/金融）、无障碍优先、信任优先（B端采购委员会）、可访问性优先受众

### 0.B 输出一行 Design Read

格式：
```
「载体类型」×「受众」×「调性方向」
→ 美学家族：[选定的美学方向]
→ 技术栈：[执行手段]
```

示例：
```
B端产品画册 × 海外买家 × 洁白专业
→ 美学家族：Swiss modern sans-serif + 高对比度 + 克制配色
→ 技术栈：HTML/CSS 生成画册 PDF，Tailwind 排版

B端SaaS管理后台 × B端销售/市场团队 × 专业高效 + 引导式学习
→ 美学家族：现代B端SaaS（Linear/Vercel风格）× 克制蓝 × 清晰层级
→ 技术栈：Preact + CSS Variables + 自建组件库

OEM品牌官网 × 双受众 × 自然专业
→ 美学家族：食品工业风 + 实拍质感 + 温暖中性色
→ 技术栈：Next.js + Tailwind + Motion 动效
```

### 0.C 模棱两可时

只问**一个**问题，不要多问。例："这页画册走洁白极简还是偏自然暖色调？"

如果能从上下文推断 → 不提问，直接声明 Design Read 往下走。

### 0.D 反默认纪律

不要默认跳到以下 AI 模板。**每条都附带了突破条件——不是永远禁止。**

| AI 默认值 | 为什么差 | 什么时候可以用 |
|-----------|---------|--------------|
| AI 紫/蓝渐变 Hero | LLM 最爱的"科技感"伪装 | 品牌色本身就是紫色/蓝色时，且用户明确要求 |
| 三列等宽 feature card | 最常见 AI 痕迹，毫无节奏变化 | 简单的导航/工具页面，且用户明确要求"三列" |
| 满屏居中标题 + 抽象3D图 | Awwwards 模板感 | 品牌定位是"前卫实验性"，用户明确要求 |
| 暖米咖喱色（#F5F0EB 系）| "高级感"默认配色 | 用户明确喜欢，或品牌本身就是暖色调 |
| AI 完美生图 | 无尘、对称、饱和过度、塑料感 | 产品本身需要官方产品照（非场景图） |
| Inter + slate-900 字体 | LLM 安全牌 | 用户明确要求，或公共部门/无障碍优先场景 |
| Serif 字体当"创意感" | LLM 误认为"有设计=用衬线" | 品牌明确要求，或真正的 editorial/luxury 场景 |
| 邮件深蓝 Header + 灰底 Footer | 邮件模板 AI 默认 | 品牌色本身就是深蓝 |
| 邮件中的 em-dash 装饰 | LLM 文案痕迹 | 无——零例外 |
| 三列等宽卡片 testimonials + 圆点 | 最常见 AI 痕迹 | 用户明确要求 |
| 纯文字 + 渐变色块 Hero | 占位符，不是 Hero | Editorial manifesto 风格且用户确认 |

---

## 1. 三旋钮推理模型

Design Read 之后，设定三个旋钮。**所有**布局/色彩/动效/排版决策由这三个值驱动。

### 基础刻度

| 旋钮 | 含义 | 1 | 10 |
|------|------|----|-----|
| **DESIGN_VARIANCE** | 布局实验性 | 严格对称、传统 | 非对称、杂志感、自由 |
| **MOTION_INTENSITY** | 动效深度 | 静态（画册/打印） | 电影级（互动官网） |
| **VISUAL_DENSITY** | 信息密度 | 美术馆留白 | 驾驶舱密集数据 |

### 信号 → 旋钮值推断

| Design Read 信号 | VARIANCE | MOTION | DENSITY |
|------------------|----------|--------|---------|
| "极简/干净/平静/editorial/Linear风" | 4-5 | 2-3 | 2-3 |
| "高端消费者/Apple风/品牌/premium" | 6-7 | 4-6 | 3-4 |
| "活泼/大胆/Dribbble/实验/Awwwards" | 8-10 | 7-10 | 3-4 |
| "B端/信任优先/公共部门/严肃" | 3-4 | 2-3 | 4-6 |
| "B端SaaS后台/Dashboard" | 4-5 | 2-3 | 5-7 |
| 重新设计-保留 | 维持原值 | +1 | 维持原值 |
| 重新设计-推翻 | +2 | +2 | 维持原值 |

### 场景预设（B端制造业特化）

| 使用场景 | VARIANCE | MOTION | DENSITY |
|---------|----------|--------|---------|
| **B端产品画册（打印）** | 3-5 | 1 | 4-6 |
| **OEM 官网首页** | 5-7 | 4-6 | 3-4 |
| **产品详情页** | 4-5 | 3-4 | 4-5 |
| **场景/解决方案页** | 6-7 | 4-6 | 3-4 |
| **品牌故事/About 页** | 5-6 | 3-5 | 2-3 |
| **Logo/品牌标识** | 3-5 | 1 | 1-2 |
| **产品生图（Hero/场景）** | 3-4 | 1 | 2-3 |
| **连锁餐饮痛点图** | 7-8 | 1 | 5-6 |
| **案例页/Case Study** | 5-6 | 3-5 | 4-5 |
| **B端SaaS后台** | 4-5 | 2-3 | 5-7 |
| **Dashboard 概览页** | 3-4 | 1-2 | 6-8 |
| **冷邮件模板** | 1-2 | 1 | 2-3 |
| **营销邮件模板** | 2-3 | 1 | 3-4 |
| **事务邮件（订单/报价）** | 1-2 | 1 | 4-5 |
| **Onboarding 邮件序列** | 2-3 | 1 | 3-4 |

### 旋钮值驱动设计决策

#### DESIGN_VARIANCE 档位

| 档位 | 布局特征 | 突破条件 |
|------|---------|---------|
| **1-3 可预测** | 严格 CSS Grid 12列等分、居中对齐、统一间距 | 用户明确要求"传统""专业""稳定感" |
| **4-7 偏移** | 非对称分栏、错位布局、图片不等比、左对齐标题 | 大多数 B端画册/官网的默认档位 |
| **8-10 非对称** | Masonry 瀑布流、极端留白、自由排版、杂志感 | 用户明确要求"创意""大胆""实验性" |
| **⚠️ 移动端覆盖** | 4-10 的非对称布局在 < 768px **必须**退化为严格单列 | 无条件强制——这不是可选项 |

#### MOTION_INTENSITY 档位

| 档位 | 动效特征 | 突破条件 |
|------|---------|---------|
| **1-3 静态** | 无自动动画，仅 CSS `:hover` / `:active` 状态 | 画册/打印材料、邮件模板 |
| **4-7 流畅** | `transition 0.3s`、滚动入场、hover 微交互 | 官网、产品页——默认档位 |
| **8-10 编排** | GSAP ScrollTrigger、视差、水平劫持滚动 | 用户明确要求"电影级""互动叙事" |
| **⚠️ 声明 = 实现** | 设定 >4 但页面是静态的 → 输出失败 | 反之，做不了动效就把旋钮降到 ≤3 |
| **⚠️ 必须有动机** | 每个动画必须一句话说清传达什么（层级/叙事/反馈/状态） | "看起来酷"不是理由 |

#### VISUAL_DENSITY 档位

| 档位 | 信息密度 | 突破条件 |
|------|---------|---------|
| **1-3 美术馆** | 大量留白（`py-32`~`py-48`）、每 section 一个核心信息 | 品牌官网 Hero、About 页 |
| **4-7 日常** | 标准间距（`py-16`~`py-24`）、标题+副标题+CTA | 大多数 B端页面的默认 |
| **8-10 驾驶舱** | 紧凑排列、细线分隔、等宽数字、无卡片容器 | 产品规格表、对比矩阵、dashboard |

---

## 2. Brief → 美学映射

Design Read 之后，根据场景选择美学方向和技术栈。

### 2.A 画册/印刷品

| 场景 | 美学方向 | 关键词 |
|------|---------|--------|
| B端产品画册 | Swiss modern | 无衬线、结构化网格、克制配色、数据可视化 |
| 品牌手册 | Editorial | 衬线标题、大量留白、大图、故事线 |
| 产品规格卡 | Technical | 等宽数字、严格对齐、规格表优先 |
| 宣传海报 | Impact | 单一视觉焦点、极简文案、品牌色块 |

### 2.B 官网/Web

| 场景 | 美学方向 | 技术栈推荐 |
|------|---------|-----------|
| 制造业B端官网 | 工业极简 | Tailwind + 静态站点 / Next.js |
| OEM 品牌官网 | 食品工业风 | Next.js + Tailwind + Motion |
| 消费品品牌官网 | Premium Consumer | Next.js + Tailwind + Motion + 生图 |
| 集团/企业官网 | 信任优先 | Tailwind + 最少动效 |
| B端SaaS后台 | 现代B端SaaS | Preact/React + CSS Variables + 自建组件库 |

### 2.C 生图

| 场景 | 美学方向 | 风格关键词 |
|------|---------|-----------|
| 产品 Hero 图 | 商业摄影 | studio lighting、浅景深、实拍质感 |
| 场景应用图 | 生活方式 | 自然光线、真实环境、有温度 |
| 痛点概念图 | 概念视觉 | 强对比、夸张表现、视觉叙事 |

### 2.D 设计系统选型（Web 项目）

| Brief 信号 | 选什么 | 为什么 |
|-----------|--------|--------|
| 自己的 Tailwind 项目（YuKoLi 等） | Tailwind v4 + 自建组件 | 已有体系，不引入第三方 DS |
| "干净/极简/Linear 风" | Tailwind + Geist / Outfit 字体 | 轻量，完全自主控制 |
| "信任优先/严肃 B端" | Tailwind + 紧凑间距 + 少动效 | 不需要重型设计系统 |
| "Material 风格" | Material Web 3 | 仅在用户明确要求时 |
| "公共部门/政府" | 参考 GOV.UK 布局原则 | 仅需原则，不安装库 |
| "Microsoft/企业SaaS" | Fluent UI React | 官方 Fluent，无障碍完成 |
| "IBM 风格 B端" | Carbon React | 官方 Carbon，成熟数据密度模式 |
| "Atlassian 风格" | Atlaskit | 官方 Atlaskit |
| "GitHub 风格" | Primer CSS | 官方 Primer |
| "现代 SaaS 自建组件" | shadcn/ui | 代码归你，易定制；从不发默认状态 |

**铁律：一个项目只用一种设计系统。** 不混搭 Material + shadcn。

### 2.E 邮件模板

| 场景 | 美学方向 | 技术栈 |
|------|---------|--------|
| B端冷邮件 | 品牌极简 + 高转化 | table-based HTML + inline CSS |
| 营销邮件 | 品牌叙事 + 视觉驱动 | table-based HTML + inline CSS |
| 事务邮件（订单/报价） | 结构化 + 信任感 | table-based HTML + inline CSS |
| Onboarding 序列 | 品牌叙事 + 渐进式 | table-based HTML + inline CSS |


## 3. Default Architecture（默认架构约定）

当 Design Read 没有选择特定设计系统时，使用以下默认值。

### 3.A 技术栈

| 项目类型 | 默认栈 |
|---------|--------|
| Web 项目 | Next.js + Tailwind v4 + Motion（`motion/react`） |
| 静态页面 | Tailwind v4 + 原生 CSS |
| 邮件模板 | table-based HTML + inline CSS（邮件客户端兼容） |
| 画册/PDF | HTML/CSS → PDF（Puppeteer/Playwright） |
| B端SaaS后台 | Preact/React + CSS Variables + 自建组件库 |

**字体加载：** 始终用 `next/font`（Next.js）或 `@font-face` + `font-display: swap`。生产环境禁止用 `<link>` 加载 Google Fonts。

### 3.B 状态管理

| 场景 | 方案 |
|------|------|
| 局部 UI 状态 | `useState` / `useReducer` |
| 深层 prop drilling | Zustand / Jotai / React Context |
| 鼠标/滚动连续值 | Motion `useMotionValue` + `useTransform`（禁止 `useState`） |

**❌ 禁止：** `useState` 追踪鼠标位置、滚动进度、物理交互——每帧 re-render。

### 3.C 图标库

| 优先级 | 库 | 备注 |
|--------|-----|------|
| 1 | `@phosphor-icons/react` | 默认首选 |
| 2 | `hugeicons-react` | 备选 |
| 3 | `@radix-ui/react-icons` | 轻量 |
| 4 | `@tabler/icons-react` | 备选 |
| ❌ 谨慎 | `lucide-react` | 仅用户明确要求或项目已有 |

**铁律：** 一个项目只用一种图标库。不混搭。**禁止手写 SVG 图标路径。**

### 3.D Emoji 政策

默认禁止在代码和可见文本中使用 emoji。用图标库替代。

**突破条件：** 用户明确要求活泼/社交/聊天风格，且使用克制。

### 3.E 响应式与布局机制

- 标准断点：`sm 640` / `md 768` / `lg 1024` / `xl 1280` / `2xl 1536`
- 页面容器：`max-w-[1400px] mx-auto` 或 `max-w-7xl`
- **❌ 禁止 `h-screen`** → 用 `min-h-[100dvh]`（防 iOS Safari 地址栏跳变）
- **❌ 禁止 flex 百分比数学**（`w-[calc(33%-1rem)]`）→ 用 CSS Grid（`grid grid-cols-1 md:grid-cols-3 gap-6`）

### 3.F 依赖验证（强制）

引入任何第三方库前，先检查 `package.json`。缺少则先输出安装命令。**永远不要假设库已存在。**

---

## 4. Design Engineering Directives（设计工程指令）

LLM 默认输出模板。主动覆盖这些偏差。

### 4.1 Typography 排版规则

#### 4.1.A 字体选择

**默认用无衬线（Sans-Serif）。** "有设计感就用衬线" 是 AI 最大的排版幻觉之一。

| 场景 | 推荐 | 避免 | 突破条件 |
|------|------|------|---------|
| B端画册/官网标题 | Geist / Outfit / 思源黑体 | Inter（默认牌） | 品牌已有 Inter 或用户明确要求 |
| 正文 | 同标题字体或其正文字重变体 | 换另一套字体 | 明确的编辑排版需求 |
| 数字/数据 | 等宽字体（JetBrains Mono / IBM Plex Mono） | 比例字体显示数据 | 仅 1-2 个数字可用比例字体 |
| 衬线（慎用） | PP Editorial / Cormorant / EB Garamond | Fraunces / Instrument Serif（AI最爱） | **仅当**品牌明确要求或真正的 editorial/luxury |

#### 4.1.C Absolute Zero 字体禁令（增强）

以下字体在非品牌指定的情况下**硬禁止**。这是从高端 agency 设计规范移植的 Absolute Zero 指令。

**硬禁止字体（除非品牌指定）：**
- Inter, Roboto, Arial, Open Sans, Helvetica
- 假设 premium 字体可用：Geist, Clash Display, PP Editorial New, Plus Jakarta Sans, Outfit, Satoshi, Cabinet Grotesk

**硬禁止图标库（除非品牌指定）：**
- Lucide（标准粗描边）、FontAwesome、Material Icons
- 仅允许：Phosphor Light/Thin、Remix Line、HugeIcons、Radix Icons、Tabler

**硬禁止边框与阴影：**
- 通用 1px 纯灰边框
- 生硬深色 drop shadow（`shadow-md`、`rgba(0,0,0,0.3)`）
- 用有色阴影替代：阴影色调匹配背景色

**硬禁止布局：**
- 边缘到边缘的 sticky navbar 粘在顶部
- 对称的三列 Bootstrap 风格网格（无巨量留白间隙）

**硬禁止动效：**
- 标准 `linear` 或 `ease-in-out` 过渡
- 无插值的即时状态变化
- 所有过渡必须用自定义 cubic-bezier（如 `cubic-bezier(0.32,0.72,0,1)`）

**字体配对知识：**
- Geist + Geist Mono
- Outfit + IBM Plex Mono
- 思源黑体 + 思源宋体（中文 editorial）
- Satoshi + JetBrains Mono
- Cabinet Grotesk + Inter Tight

**Serif 纪律（非常谨慎）：**
- Serif 仅当以下之一明确成立时才可用：
  - 品牌明确指定了衬线字体
  - 美学方向是 editorial / luxury / publication / heritage
- **❌ 禁止的默认衬线：** Fraunces、Instrument Serif（AI 最爱）
- **强调规则：** 标题中要强调某个词时，用同一字体的 italic/bold，**不要**在无衬线标题中插入随机衬线词
- **轮换规则：** 如果上一个项目用了衬线，这个项目必须用无衬线。不要连续两个项目用同一款衬线

#### 4.1.B 排版纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 英文行宽 ≤ 65ch | 超过导致阅读疲劳 | 窄栏引用、数据表 |
| 中文行宽 ≤ 40em | 中文阅读舒适宽度 | 表格、数据密集区 |
| `<br>` 不断标题 | "for thirty<br>*years.*" 式花活是 AI 痕迹 | 用户明确要求，或 editorial 大字排版 |
| 标题不加随机衬线词 | "we design **and** spatial" 中 **and** 换字体是业余 | 同一字体用 italic/bold 强调即可 |
| Italic 下延字母 clearance | 斜体含 y/g/j/p/q 时，`leading-[1.1]` 最低 + `pb-1` | 会裁切下延字母 |
| emoji 不当图标 | 不像专业设计 | 用户明确要求"活泼社交"风且只偶尔使用 |
| 显示/标题字号 | 默认 `text-4xl md:text-6xl tracking-tighter leading-none` | 内容驱动 |
| 正文字号 | 默认 `text-base text-gray-600 leading-relaxed max-w-[65ch]` | 内容驱动 |
| 孤词修复 | 标题最后一行只剩一个词 → `text-wrap: balance` 或 `text-wrap: pretty` | 无 |
| 数字用等宽 | 数据密集区域用 `font-variant-numeric: tabular-nums` | 仅 1-2 个数字 |
| 全大写副标题节制 | 全大写标签太多 → 用小写斜体、首字母大写或小型大写 | 品牌风格要求 |

### 4.1.D 高端设计手法（Premium Design Techniques）

以下是从高端 agency 规范移植的进阶设计手法。非默认——仅当 Design Read 需要 premium/agency 级输出时才 reach for。

#### Double-Bezel 嵌套架构（Doppelrand）

卡片/容器/图片不应平铺在背景上。它们应像物理硬件一样嵌套：

**外层 Shell：**
- 微妙背景（`bg-black/5` 或 `bg-white/5`）
- 发丝外边框（`ring-1 ring-black/5` 或 `border border-white/10`）
- 特定 padding（`p-1.5` 或 `p-2`）
- 大外圆角（`rounded-[2rem]`）

**内层 Core：**
- 独立背景色
- 内高光（`shadow-[inset_0_1px_1px_rgba(255,255,255,0.15)]`）
- 数学计算的内圆角（`rounded-[calc(2rem-0.375rem)]`）确保同心

**突破条件：** 用户明确要求极简/低视觉层次，或 DENSITY ≤ 2

#### Button-in-Button 按钮图标模式

CTA 按钮的箭头图标从不裸放在文字旁。它嵌套在自己的圆形容器中：
- `w-8 h-8 rounded-full bg-black/5 dark:bg-white/10 flex items-center justify-center`
- 与按钮右内边距齐平
- hover 时图标容器对角线位移（`group-hover:translate-x-1 group-hover:-translate-y-[1px]`）

**突破条件：** 按钮无图标、或 DENSITY ≥ 7 紧凑布局

#### Fluid Island 导航

导航作为浮动玻璃 pill 悬浮在页面顶部：
- `mt-6 mx-auto w-max rounded-full backdrop-blur-2xl`
- 汉堡图标在点击时流畅变形为 X（`rotate-45` + `-rotate-45` 绝对定位）
- 菜单展开为全屏遮罩（`backdrop-blur-3xl bg-black/80`）
- 导航链接 staggered 出现（`translate-y-12 opacity-0` → `translate-y-0 opacity-100`，`delay-100/150/200`）

**突破条件：** 传统企业/B端页面、或用户明确要求标准导航

#### Magnetic Button 磁力按钮物理

按钮 hover 时不只是变色：
- 整体轻微缩小（`active:scale-[0.98]`）模拟物理按压
- 内嵌图标对角线位移（`group-hover:translate-x-1 group-hover:-translate-y-[1px]`）
- 内嵌图标轻微放大（`scale-105`）

**突破条件：** 打印/邮件模板、或 MOTION ≤ 2

#### Spring Physics 弹簧物理动效

所有过渡必须模拟真实世界的质量和弹簧物理：
- 默认：`transition-all duration-700 ease-[cubic-bezier(0.32,0.72,0,1)]`
- 标准 `linear` 和 `ease-in-out` 硬禁止
- 滚动入场：`translate-y-16 blur-md opacity-0` → `translate-y-0 blur-0 opacity-100`，800ms+

**突破条件：** 打印/邮件模板、或 MOTION ≤ 2

#### Variance Engine 创意多样性引擎

每次输出前静默选择一种组合，确保每次不同：

**Vibe & Texture（选 1）：**
1. **Ethereal Glass（SaaS/AI/科技）** — OLED 黑（`#050505`）、径向网格渐变、Vantablack 卡片 + `backdrop-blur-2xl`、纯白/10 发丝线
2. **Editorial Luxury（生活方式/地产/Agency）** — 暖奶油（`#FDFBF7`）、鼠尾绿、浓缩咖啡色、可变衬线大字、CSS 噪点覆盖
3. **Soft Structuralism（消费品/健康/作品集）** — 银灰/全白背景、大胆 Grotesk 大字、浮动组件 + 极度柔和漫射阴影

**Layout（选 1）：**
1. **Asymmetrical Bento** — Masonry CSS Grid 变尺寸卡片（`col-span-8 row-span-2` 旁 `col-span-4`）
2. **Z-Axis Cascade** — 卡片物理堆叠、轻微重叠、`-2deg`/`3deg` 旋转打破数字网格
3. **Editorial Split** — 左半大字排版（`w-1/2`）、右半可滚动图片/卡片

**移动端覆盖：** 所有非对称布局在 < 768px 必须退化为单列（`w-full`、`px-4`、`py-8`）。移除旋转和负边距重叠。

**突破条件：** 用户明确要求特定布局、或 Brief 极度明确

### 4.2 Color 色彩规则

#### 4.2.A 基础纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 单一强调色 | 全页只用 1 个 accent color | 品牌本身有多色体系且用户确认 |
| 饱和度 < 80% | B端 < 60%，消费者 < 80% | 品牌色本身就是高饱和（如可口可乐红） |
| 单一灰色系 | Zinc/Slate/Stone 择一，全页一致 | 无 |
| 不用纯黑 #000 + 纯白 #FFF | 用 #111 + #FAFAFA 或品牌色系 | 纯黑用于印刷（CMYK 100%K） |
| Color Consistency Lock | 选定 accent 后，全页所有 section 一致 | 无——这是铁律 |
| 阴影调色 | 阴影色调匹配背景色，不用纯黑 drop shadow | 无 |
| 光源方向一致 | 全页阴影暗示同一光源方向 | 无 |

#### 4.2.B ⚠️ Premium Consumer 色板禁令

**这是 AI 第二大色板惯性。** 高端消费品（厨具/保健品/奢侈品/手工艺/DTC家居），AI 默认输出：

- 背景：`#f5f1ea`、`#f7f5f1`、`#fbf8f1`、`#ece6db`（暖米/奶油/粉笔/骨色）
- 强调：`#b08947`、`#b6553a`、`#9a2436`（黄铜/陶土/牛血红）
- 文字：`#1a1714`、`#1a1814`（浓缩咖啡近黑）

**禁令：** 除非品牌本身是暖色调/复古工艺定位，否则不要默认 reach for 这个色板。

**替代方案（轮换使用，不要连续两个项目用同一个）：**
- 冷奢：银灰 + 铬色 + 烟熏（特斯拉/AW 风格）
- 森林：深绿 + 骨白 + 琥珀点缀（Patagonia 风格）
- 蓝铜：钴蓝 + 奶油单一中性色（无黄铜）
- 陶土石板：暖锈红 + 冷灰（无黄铜）
- 黑褐：纯近黑 + 暖褐，高对比，无米色
- 纯单色 + 单一饱和点缀：近白 + 近黑 + 一个亮色（电蓝/翠绿/热粉）

#### 4.2.C ⚠️ 紫色/蓝色 AI 渐变禁令

"AI 紫/蓝发光"审美默认禁止。不要自动用紫色按钮发光、随机霓虹渐变。用中性基色（Zinc/Slate/Stone）+ 高对比单一强调色（翠绿、电蓝、深玫红、焦橙等）。

**突破条件：** 品牌或 Brief 明确要求紫色/紫罗兰色。但执行要刻意：一致调色板、协调中性色、克制渐变。

#### 4.2.D Em-Dash 全面禁令

**Em-dash（`—`）和 En-dash（`–`）在所有可见文本中完全禁止。**

这是 LLM #1 文案痕迹。AI 用 em-dash 当万能分隔符、修辞手段、设计元素。

| 禁止位置 | 替代方案 |
|---------|---------|
| 标题 | 用句号或逗号 |
| 副标题/标签/按钮/图片说明/导航 | 用换行、竖线或空格 |
| 正文 | 拆成两句话，或用逗号/括号/冒号 |
| 引用归属 | 用普通连字符 ` - ` 或换行 + 小字 |

**唯一允许的 dash：** 普通连字符 `-`（复合词、数字范围）。零 em-dash，零例外。


### 4.2.E AIDA 页面结构（从 gpt-tasteskill 移植）

每个页面必须遵循 AIDA 框架——这是从高端营销页面验证的结构：

| 阶段 | 目的 | 典型 Section |
|------|------|-------------|
| **Attention** | 吸引注意力 | Hero（电影级、宽屏、干净） |
| **Interest** | 建立兴趣 | Feature/Bento（高密度、完美网格、交互组件） |
| **Desire** | 激发欲望 | GSAP Scroll/Media（固定 section、水平滚动、文字揭示） |
| **Action** | 引导行动 | Footer/Pricing（高对比 CTA、干净链接） |

**间距规则：** 每个主要 section 之间加巨量垂直 padding（`py-32 md:py-48`）。Section 应像不同的电影章节。

**突破条件：** 单页/Landing Page 可适当压缩，但 AIDA 顺序不变。

### 4.3 Layout 布局硬规则

#### 4.3.A Hero 规范

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 文字元素 ≤ 4 个 | 眉毛标签(0-1) + 标题 + 副文本 + CTA | 无 |
| 标题 ≤ 2 行（桌面） | 超过 = 字号太大或文案太长 | 无——先减小字号，后精简文案 |
| 副文本 ≤ 20 词 / ≤ 4 行 | 超过说明价值主张不清晰 | 无 |
| Hero top padding ≤ `pt-24` | 更大 = 内容浮在视口中部，像 bug | 无——要更多空间就增大字号或图片 |
| CTA 不换行（桌面） | 主 CTA 最多 3 个词 | 无 |
| Logo wall 在 Hero 下方 | Hero 只放价值主张 + CTA | 无 |
| Hero 必须有视觉元素 | 纯文字 + 渐变色块 = 占位符，不是 Hero | Editorial manifesto 风格，用户明确要求 |
| Hero 字号规划 | 标题 >6 词时不要从 `text-7xl` 开始，默认 `text-4xl md:text-5xl lg:text-6xl` | 标题 3-5 词时可用 `text-6xl md:text-7xl` |
| Hero 中禁止： | 标签行在 CTA 下方、信任微条、定价预告、功能列表、社交证明头像行 | 无——移到 Hero 下方的专属 section |

#### 4.3.B Section 级纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| Eyebrow 约束 | 每 3 个 section 最多 1 个 eyebrow。Hero 算 1 个 | 无——这是最常见的 AI 痕迹 |
| Section Layout 不重复 | 8 个 section 至少 4 种不同 layout family | 无——"每个 section 用同一套布局"是 AI 惯性 |
| Zigzag 交替上限 | 图片+文字交替排列连续最多 2 段，第 3 段必须换布局 | 无 |
| Split Header 禁令 | "左大标题 + 右小段落"浮动布局禁止 | 右侧有真实交互元素时（非纯文本） |
| 导航单行 | 桌面端导航必须单行，高度 ≤ 80px | 无 |
| Bento 格子数 = 内容数 | N 个内容项 = N 个格子，中间不留空格 | 无——空格是规划失误 |
| Bento 背景多样性 | 至少 2-3 格有图片/渐变/有色背景，不全白底纯文本 | 无 |
| Gapless Bento（增强） | Bento Grid 必须用 `grid-flow-dense` + 数学验证 col-span/row-span 完美互锁。无空单元格 | 无——这是最常见的 AI 布局失败 |
| Page Theme Lock | 全页一个主题（light/dark/auto），section 不反转 | 用户明确要求 Color Block Story |
| Shape Consistency Lock | 选一个圆角体系全页一致 | 有文档化规则时可混用 |
| 卡片仅用于层级表达 | 否则用 `border-t` / `divide-y` / 负空间分组 | 无 |
| DENSITY > 7 时禁止卡片 | 数据指标在纯布局中呼吸 | 无 |

#### 4.3.C 内容密度

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| Section 默认形态 | 短标题(≤8词) + 短段落(≤25词) + 1个视觉 | 内容驱动型 section |
| 长列表换组件 | >5 项不用 `<ul>` + `divide-y`，用卡片网格/Tab/手风琴/横向滚动 | 数据表 |
| 表格不要每行底线 | 选其一：行底线 或 组顶部线，不要全加上 | 数据密集型对比表 |
| 引用 ≤ 3 行 | 超过就截断 | 无 |
| 引用归属：姓名+角色+(公司) | 不能只有 "- Sarah" | 无 |
| 引用用真实引号 `""` | 不用 ASCII 直引号 `"` | 无 |
| 规格表替代方案 | 2列卡片网格 / 横向滚动 pills / 分组块 / 精选+折叠 | 用户明确要求传统表格 |

#### 4.3.D 移动端退化

所有多栏布局在 < 768px **必须**声明退化为单列：
- `w-full px-4 py-8`
- 非对称分栏 → 上下堆叠
- 隐藏装饰性元素
- Bento 中所有 `col-span` 重置为 `col-span-1`

**不是可选的。** "Tailwind 会处理" 的假设不可接受。

#### 4.3.E 布局多样性强制（从 gpt-tasteskill 移植）

LLM 默认总是选第一个布局选项。为防止此偏差，每次布局前执行：

1. **模拟 Python 随机选择** — 用用户 prompt 的字符数作为 seed，模拟 `random.choice()` 选择：
   - 1 种 Hero 架构（从 Section 9 Hero 范式中选）
   - 1 种排版组合（Satoshi/Cabinet Grotesk/Outfit/Geist — 禁止 Inter）
   - 2-3 种不同组件架构（Bento/Sticky-Stack/Split-Screen/Editorial）
   - 1-2 种动效范式（Scroll-Reveal/Sticky-Stack/Horizontal-Pan）
2. **禁止连续两次输出相同组合** — 记录上次选择的组合，下次必须不同
3. **移动端覆盖** — 所有非对称布局在 < 768px 退化为单列

**突破条件：** 用户明确要求特定布局。

### 4.4 Interactive UI States（交互状态）

LLM 默认只输出"静态成功态"。必须实现完整周期：

| 状态 | 要求 |
|------|------|
| **Loading** | 骨架屏匹配最终布局形状。避免通用圆形 spinner |
| **Empty** | 美观构图，指示如何填充 |
| **Error** | 清晰、内联（表单）或上下文（toast 仅临时） |
| **触觉反馈** | `:active` 时用 `-translate-y-[1px]` 或 `scale-[0.98]` |
| **按钮对比度** | WCAG AA 最小 4.5:1（正文）/ 3:1（大文本 18px+） |
| **CTA 不换行** | 桌面端按钮文字必须单行。超过 3 词则缩短 |
| **CTA intent 不重复** | 同一 intent 的 CTA 全页用同一个标签 |
| **表单对比度** | placeholder、focus ring、helper text、error text 都通过 WCAG AA |
| **Label 在 input 上方** | 禁止 placeholder 当 label |
| **Focus ring** | 键盘导航可见焦点指示器 |
| **死链接** | 按钮不链到 `#`，要么链到真实目标，要么视觉禁用 |

### 4.5 Image & Visual Asset 视觉资产规则

#### 4.5.A 资产优先级链

| 优先级 | 来源 | 适用场景 |
|--------|------|----------|
| **1. 品牌实际图片** | 用户提供的 URL/文件 | 最佳——永远优先用真实素材 |
| **2. 生图工具** | GLM-5.1 prompt → 生图模型 | Hero、场景图、产品特写 |
| **3. Picsum-seed** | `picsum.photos/seed/{描述}/{w}/{h}` | 占位图，seed 必须描述内容 |
| **4. 明确标注占位** | `<!-- TODO: hero photo 1600x1200 -->` | 前三者都不可用时 |

**❌ 永远不做**：用 `<div>` 矩形模拟截图、手绘 SVG 图标当装饰、纯文字页面称"极简"。

#### 4.5.B Logo Wall 纪律

- Logo = logo only，不加行业标签（不要 `Stripe + payments`）
- 用真实 SVG logo（Simple Icons CDN / devicon / 品牌实际 logo）
- 造品牌名 → 造 SVG 标志（单字母圆形/双字母组合），不要用纯文本
- 确保 logo 在 light/dark 两种模式下都可见
- Logo wall 在 Hero 下方，不在 Hero 内部

#### 4.5.C 生图特有规则

| 痕迹 | 说明 | 处理 |
|------|------|------|
| ❌ AI 完美感 | 无尘、对称、过度饱和、塑料感 | prompt 加 "workshop feel, natural arrangement" |
| ❌ 面孔不匹配 | 东南亚内容用白/黑人面孔 | prompt 加 "Southeast Asian faces" |
| ❌ 空洞背景 | 无环境上下文 | ZONAL ANALYSIS 填满 Zone A/B/C/D |
| ❌ 幻觉文字 | 画面内出现不存在的中英文 | prompt 注明 "no visible text or labels" |
| ❌ 光源无方向 | 产品图无主光源信息 | 标注光源方向/色温/景深 |
| ❌ 品牌色缺失 | 生图不带品牌色融入 | prompt 标注品牌色 hex |

#### 4.5.D 面孔 & 地名真实性

- 不用 John Doe / Sarah Chan / Jack Su → 用真实感名称
- 不用 Acme / Nexus / SmartFlow → 造出符合行业语境的品牌名
- 不用 99.99% / 50% 等完美数字 → 用 47.2%、83% 等不规整数据
- 不用 "Elevate/Seamless/Unleash/Next-Gen/Revolutionize" → 用具体动词
- 所有博客文章日期不同，不全是同一天
- 不同用户用不同头像，不用同一张图

### 4.6 文案自审（强制）

交付前逐条重读每个可见字符串，标记并重写：

| 问题类型 | 示例 | 修复 |
|---------|------|------|
| 语法破碎 | "free on its past" | 重写为自然语句 |
| 指代不清 | "we plan to stay that way" | 明确指代 |
| AI 幻觉文案 | 强行文艺、假工匠感标签 | 替换为平实功能句 |
| 假精确数字 | 92%、4.1×、48k | 要么来自真实数据，要么标注为 mock |
| 多语气混用 | 技术 mono + 营销 punch 混在同一页 | 统一为一种语气 |
| 感叹号滥用 | "操作成功！" | 去掉感叹号，自信但不吵 |
| 感叹号滥用 | "操作成功！" | 去掉感叹号，自信但不吵 |
| "Oops!" 错误信息 | "出错了！" | 直接："连接失败，请重试" |
| 被动语态 | "修改已保存" | 主动语态："保存成功" |
| 所有标题大写 | "联系我们" | 首字母大写即可 |
| 假谦虚行业引用 | "We respect the French ones" | 直接引用或跳过 |

### 4.7 Page Theme Lock（页面主题锁定）

- 全页一个主题（light/dark/auto），section 不反转
- 例外：用户明确要求 Color Block Story，且是刻意编排（全页一次主题切换，带强过渡）
- 默认：在页面级别选择 light/dark/auto（`prefers-color-scheme`），锁定
- 使用设计系统内置主题时，在 `layout.tsx` 或页面根节点设置一次
- 不用纯 `#000000` 和纯 `#ffffff`，用 off-black 和 off-white


---

## 5. Context-Aware Proactivity（上下文感知动效）

这些是工具，不是默认值。仅当 Design Read 需要时才使用。

### 5.A 动效纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 动效必须有动机 | 每个动画一句话说清传达什么（层级/叙事/反馈/状态） | "看起来酷"不是理由 |
| 声明 = 实现 | 设定 MOTION > 4 但页面是静态的 → 输出失败 | 做不了动效就把旋钮降到 ≤3 |
| Marquee 最多 1 个/页 | 水平滚动文字条全页最多一个 | 无 |
| 禁止 `window.addEventListener('scroll')` | 每帧触发、卡顿 | 用 Motion `useScroll()` / ScrollTrigger / IntersectionObserver |
| 禁止 `useState` 追踪连续值 | 每帧 re-render | 用 `useMotionValue` + `useTransform` |
| 硬件加速 | 只动画 `transform` 和 `opacity` | 无 |
| Reduced Motion | MOTION > 3 时必须 honor `prefers-reduced-motion` | 无——不可协商 |
| 禁止 GSAP/Three.js 与 Motion 混用 | 争抢同一帧 | 一个组件树只用一种动画库 |

### 5.B GSAP Sticky-Stack 规范代码骨架

```tsx
"use client";
import { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useReducedMotion } from "motion/react";

gsap.registerPlugin(ScrollTrigger);

export function StickyStack({ cards }: { cards: React.ReactNode[] }) {
  const ref = useRef<HTMLDivElement>(null);
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce || !ref.current) return;
    const ctx = gsap.context(() => {
      const cardEls = gsap.utils.toArray<HTMLElement>(".stack-card");
      cardEls.forEach((card, i) => {
        if (i === cardEls.length - 1) return;
        ScrollTrigger.create({
          trigger: card,
          start: "top top",
          endTrigger: cardEls[cardEls.length - 1],
          end: "top top",
          pin: true,
          pinSpacing: false,
        });
        gsap.to(card, {
          scale: 0.92,
          opacity: 0.55,
          ease: "none",
          scrollTrigger: {
            trigger: cardEls[i + 1],
            start: "top bottom",
            end: "top top",
            scrub: true,
          },
        });
      });
    }, ref);
    return () => ctx.revert();
  }, [reduce]);

  return (
    <div ref={ref} className="relative">
      {cards.map((card, i) => (
        <div key={i} className="stack-card sticky top-0 min-h-[100dvh] flex items-center justify-center">
          {card}
        </div>
      ))}
    </div>
  );
}
```

关键点：`start: "top top"`、`pin: true`、每张卡（最后一张除外）都被 pin，前一张卡的 scale/opacity 由下一张卡的 scroll trigger 驱动。

### 5.C GSAP Horizontal-Pan 规范代码骨架

```tsx
"use client";
import { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useReducedMotion } from "motion/react";

gsap.registerPlugin(ScrollTrigger);

export function HorizontalPan({ children }: { children: React.ReactNode }) {
  const wrap = useRef<HTMLDivElement>(null);
  const track = useRef<HTMLDivElement>(null);
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce || !wrap.current || !track.current) return;
    const ctx = gsap.context(() => {
      const distance = track.current!.scrollWidth - window.innerWidth;
      gsap.to(track.current, {
        x: -distance,
        ease: "none",
        scrollTrigger: {
          trigger: wrap.current,
          start: "top top",
          end: () => `+=${distance}`,
          pin: true,
          scrub: 1,
          invalidateOnRefresh: true,
        },
      });
    }, wrap);
    return () => ctx.revert();
  }, [reduce]);

  return (
    <section ref={wrap} className="relative overflow-hidden">
      <div ref={track} className="flex h-[100dvh] items-center">
        {children}
      </div>
    </section>
  );
}
```

关键点：`start: "top top"`、`pin: true`、`end: "+=${distance}"`（滚动长度 = 水平滑动距离）、`scrub: 1`。

### 5.D Scroll-Reveal Stagger 规范代码骨架（轻量替代）

```tsx
"use client";
import { motion, useReducedMotion } from "motion/react";

export function RevealStagger({ items }: { items: string[] }) {
  const reduce = useReducedMotion();
  return (
    <ul className="grid gap-6">
      {items.map((item, i) => (
        <motion.li
          key={item}
          initial={reduce ? false : { opacity: 0, y: 24 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, amount: 0.3 }}
          transition={{
            duration: 0.6,
            delay: i * 0.06,
            ease: [0.16, 1, 0.3, 1],
          }}
        >
          {item}
        </motion.li>
      ))}
    </ul>
  );
}
```

### 5.E 禁止的动效模式

- **`window.addEventListener("scroll", ...)`** — 硬禁止。每帧触发、卡顿。用 Motion `useScroll()` / ScrollTrigger / IntersectionObserver / CSS scroll-driven animations
- **自定义 `window.scrollY` 计算 + React state** — 同上，每帧 re-render
- **`requestAnimationFrame` 循环操作 React state** — 用 motion values
- **Layout Transitions** — 用 Motion `layout` / `layoutId`，不包裹静态内容
- **Staggered Orchestration** — 用 `staggerChildren`（Motion）或 CSS `animation-delay: calc(var(--index) * 100ms)`

### 5.F Motion-Engine Bento（微动效卡片原型）

当生成现代 SaaS Dashboard 或 Feature Section 时，可用此 Bento 2.0 架构。它超越静态卡片，依赖 perpetual physics 实现 premium 动效。

#### 5.F.A 设计哲学
- **美学**：高端、极简、功能优先
- **色板**：背景 `#f9fafb`，卡片纯白 `#ffffff`，1px 边框 `border-slate-200/50`
- **表面**：`rounded-[2.5rem]` 主容器，扩散阴影 `shadow-[0_20px_40px_-15px_rgba(0,0,0,0.05)]`
- **排版**：Geist / Satoshi / Cabinet Grotesk，标题 `tracking-tight`
- **标签**：标题和描述在卡片**外部下方**，保持画廊式干净展示
- **内边距**：`p-8` 或 `p-10`

#### 5.F.B 动画引擎规格（Perpetual Motion）
所有卡片必须包含**永久微交互**，用 Framer Motion 原则：
- **Spring Physics**：`type: "spring", stiffness: 100, damping: 20`，无 linear easing
- **Layout Transitions**：`layout` 和 `layoutId` 实现平滑重排/缩放/共享元素过渡
- **Infinite Loops**：每张卡片有一个无限循环的

#### 5.F.C 5 种卡片原型（微动效规格）
在构建 Bento Grid 时实现以下微动效：

1. **The Intelligent List** — 垂直列表项无限自动排序循环。用 `layoutId` 让项平滑交换位置，模拟 AI 实时优先级排序
2. **The Command Input** — 搜索/AI 栏带多步打字机效果。循环展示复杂提示词，含闪烁光标和 shimmer 渐变加载状态
3. **The Live Status** — 调度界面带"呼吸"状态指示器。含弹出通知徽章，带 Overshoot spring 效果，停留 3 秒后消失
4. **The Wide Data Stream** — 水平"无限轮播"数据卡片或指标。无缝循环（`x: ["0%", "-100%"]`），速度轻松不费力
5. **The Contextual UI (Focus Mode)** — 文档视图，文字块交错高亮动画，随后浮动操作工具栏"飘入"带微图标

**性能关键：** 任何 perpetual motion 或 infinite loop 必须 memoized（React.memo）并完全隔离在独立的微型 Client Component 中。绝不在父布局中触发 re-render。

**突破条件：** 打印/邮件模板、或 MOTION ≤ 2

---

## 6. Performance & Accessibility Guardrails（性能与无障碍护栏）

### 6.A 硬件加速
- 只动画 `transform` 和 `opacity`。禁止动画 `top`、`left`、`width`、`height`
- `will-change: transform` 仅用于实际会动画的元素

### 6.B Reduced Motion（强制）
- MOTION > 3 时必须 honor `prefers-reduced-motion`。不可协商
- Motion: 用 `useReducedMotion()` 退化为静态
- CSS: 用 `@media (prefers-reduced-motion: no-preference)` 或 `@media (prefers-reduced-motion: reduce)` 禁用
- 无限循环、视差、scroll-hijack、磁力物理必须退化为静态/即时

### 6.C Dark Mode（消费者面向页面强制）
- 从开始就设计两种模式。禁止只输出 light-only 或 dark-only
- 用 Tailwind `dark:` variant 或 CSS variables。一个项目选一种策略
- 尊重 `prefers-color-scheme: dark`。默认系统偏好，除非品牌坚持一种模式
- 两种模式都通过 WCAG AA（正文 AAA）
- 不用纯 `#000000` 和纯 `#ffffff`，用 off-black 和 off-white

### 6.D Core Web Vitals 目标
- **LCP** < 2.5s。Hero 图片必须 `next/image priority` 或 preload
- **INP** < 200ms。繁重工作脱离主线程
- **CLS** < 0.1。图片、字体、嵌入预留空间
- 交付前运行 Lighthouse

### 6.E DOM 成本
- 噪点/颗粒滤镜仅用于 fixed、`pointer-events-none` 伪元素。禁止在滚动容器上使用
- Motion 不小。Three.js 很大。折叠屏以上的内容懒加载

### 6.F Z-Index 约束
禁止随意 `z-50` / `z-10`。z-index 仅用于系统层级上下文（sticky nav、modal、overlay、grain）。在项目常量文件中记录 z-index 层级。

---

## 7. AI 痕迹目录（Context-Aware 版）

> **核心区别**：v1 是二进制禁令表。v4 每条都标注了**为什么禁**和**什么时候可以突破**。
> 机械检测到 → 查表 → 有突破条件 → 判断是否适用 → 不适用则修复。

### 7.A 排版痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 | 突破条件 |
|---|------|-------------|---------|----------|
| T01 | Inter 字体做标题 | LLM 安全牌 | 换 Geist/Outfit/品牌字体 | 品牌本身用 Inter 或用户明确要求 |
| T02 | Serif 滥用 | AI 误认为"创意=衬线" | 默认 Sans，Serif 仅 editorial/luxury | 品牌明确要求衬线 |
| T03 | 三列等宽 feature card | 最常见 AI 痕迹 | 非对称网格/2列交错/时间轴/Bento | 用户明确要求"三列" |
| T04 | `<br>` 切断标题做花样 | "for thirty<br>*years.*" | 标题自然排版 | Editorial 大字排版且用户确认 |
| T05 | emoji 当图标 | 不像专业设计 | 用图标库（Phosphor/Radix/Tabler） | 用户要求活泼社交风 |
| T06 | 中文段落左右不齐 | AI 不检查中文排版 | 两端对齐或左对齐+合理断行 | 无 |
| T07 | 英文行宽 > 75ch | 阅读疲劳 | max-width: 65ch | 窄栏引用 |
| T08 | 标题中插入随机衬线词 | "we design **and** spatial" 用衬线强调 | 同字体 italic/bold | 无 |
| T09 | Italic 下延字母被裁切 | `y g j p q` 在 tight leading 中 | `leading-[1.1]` + `pb-1` | 无 |

### 7.B 色彩痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 | 突破条件 |
|---|------|-------------|---------|----------|
| C01 | AI 紫/蓝渐变 Hero | LLM 最爱"科技感"伪装 | 中性基色 + 单一强调色 | 品牌色是紫/蓝且用户确认 |
| C02 | 暖米咖喱色板 | "高级感"默认色 | 用冷奢/森林/蓝铜等替代方案 | 品牌本身暖色调/复古工艺 |
| C03 | 纯黑 #000 背景 | 偷懒 | off-black (#0a0a0a / #111) | 印刷（CMYK 100%K） |
| C04 | 多色混用 | 无色彩体系 | 单一强调色 + 一致灰色系 | 品牌多色体系且用户确认 |
| C05 | 纯黑 drop shadow | 默认值 | 阴影调色匹配背景 | 无 |
| C06 | 随机 dark section 在 light 页面 | 复制粘贴事故 | 全页一个主题 | 用户要求 Color Block Story |

### 7.C 布局痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 | 突破条件 |
|---|------|-------------|---------|----------|
| L01 | 三列等宽卡片 | 最常见 AI 布局 | 非对称/Bento/2列交错 | 用户明确要求 |
| L02 | 居中 Hero + 抽象3D | Awwwards 模板 | 非对称/分屏/左对齐 | 品牌前卫实验性 |
| L03 | 每个 section 都有 eyebrow | AI 默认节奏 | 每 3 个 section 最多 1 个 | 无 |
| L04 | Zigzag 无限交替 | 懒人布局 | 最多 2 段，第 3 段换布局 | 无 |
| L05 | `h-screen` 全屏 | 移动端 bug | `min-h-[100dvh]` | 无 |
| L06 | 纯文字 + 渐变色块 Hero | 占位符 | 必须有真实视觉元素 | Editorial manifesto |
| L07 | 三列等宽 testimonials + 圆点 | 最常见 AI 痕迹 | Masonry/单条旋转/嵌入社交 | 用户明确要求 |
| L08 | 3 步/4 步流程 "Step 1/2/3" | AI 默认流程 | 用动词命名步骤 | 无 |
| L09 | 表格每行 `border-b` | 懒人排版 | 分组/精选+折叠/卡片网格 | 数据密集型对比表 |
| L10 | Split Header "左大标题+右小段落" | AI 默认 section 头 | 垂直堆叠 | 右侧有真实交互元素 |

### 7.D 文案痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 | 突破条件 |
|---|------|-------------|---------|----------|
| W01 | Em-dash `—` 任意位置 | LLM #1 文案痕迹 | 句号/逗号/连字符 | 零例外 |
| W02 | "Elevate/Seamless/Unleash" | 营销废话 | 具体动词 | 无 |
| W03 | "Acme/Nexus/SmartFlow" | 假品牌名 | 造符合语境的品牌名 | 无 |
| W04 | "John Doe/Sarah Chan" | 假人名 | 真实感名称 | 无 |
| W05 | 99.99%/50%/$100.00 | 假精确数字 | 47.2%/83%/$99.00 | 来自真实数据 |
| W06 | "Quietly in use at" | 假谦虚 | "Trusted by" 或直接 logo | 无 |
| W07 | 版本标签在 Hero (V0.6/BETA) | 假发布状态 | 仅产品发布页可用 | 真实产品发布 |
| W08 | 序号 eyebrow (001/00/06) | 假结构 | 用自然语言命名 | 无 |
| W09 | 中间点 `·` 过度使用 | 万能分隔符 | 换行/竖线/列 | 每行最多 1 个 |
| W10 | 装饰性状态圆点 | 假交互 | 仅真实语义状态 | 实际服务器状态 |

### 7.E 生产测试痕迹（原版 taste-skill 最精华部分）

以下模式来自真实 LLM 生成页面的测试。它们是模型试图"看起来有设计"时的签名。**除非 Brief 明确要求，否则硬禁止。**

**Hero & 顶部**
- ❌ Hero 中的版本标签：`V0.6`、`v2.0`、`BETA`、`INVITE-ONLY PREVIEW`、`EARLY ACCESS`、`ALPHA`
- ❌ "Brand · No. 01" 式子眉毛："Marrow · No. 01 · The 6-quart"

**序号 & 微标签**
- ❌ 序号 eyebrow：`00 / INDEX`、`001 · Capabilities`、`06 · how it works`
- ❌ `01 / 4` 式分页标签在图片或 Bento 上
- ❌ `Scroll · 001 Capabilities` 式滚动提示
- ❌ "Index of Work, 2018 - 2026" 式范围标签

**分隔符 & 圆点**
- ❌ 中间点 `·` 过度使用。每行最多 1 个
- ❌ 装饰性彩色状态圆点在每个列表/导航/徽章上

**Em-dash & 排版花样**
- ❌ Em-dash `—` 在任何位置（零例外）
- ❌ `<br>` 切断 + 斜体标题："for thirty<br>*years.*"
- ❌ 垂直旋转文字："INDEX OF WORK" 旋转 90°
- ❌ 十字线/发丝网格线作为装饰

**假产品预览**
- ❌ `<div>` 矩形模拟产品 UI（假任务列表/假终端/假仪表盘）
- ❌ 假版本 footer："v0.6.2-rc.1"、"last sync 4s ago · main"

**营销文案痕迹**
- ❌ "Quietly in use at" / "Quietly trusted by"
- ❌ "From the field" / "Field notes" / "Currently on the bench"
- ❌ "We respect the French ones" 式假谦虚行业引用
- ❌ 天气/地点条："LIS 14:23 · 18°C"
- ❌ 微元句子在 eyebrow 下："Each of these is a feature we ship today..."
- ❌ 通用步骤标签："Stage 1 / Stage 2 / Stage 3"

**标签 & 版本戳**
- ❌ 图片上的标签叠加：`Brand · 02`、`PLATE · BRAND`
- ❌ 照片署名作为装饰："Field study no. 12 · Ines Caetano"
- ❌ 营销页 footer 版本号：`v1.4.2`、`Build 0048`
- ❌ "Reservation 412 of 800" 式实时库存计数器

**装饰文字条**
- ❌ Hero 底部装饰文字条：`BRAND. MOTION. SPATIAL.`
- ❌ 右上角浮动段落在 section 标题中

**滚动提示**
- ❌ `Scroll`、`↓ scroll`、`Scroll to explore`、`Scroll to walk through it`
- ❌ 动画鼠标滚轮图标

---

## 8. Redesign Protocol（重设计协议）

本技能处理**新建和重设计**两种模式。误分类模式是重设计输出差的最大原因。

### 8.A 检测模式（第一步）

- **Greenfield** — 无现有站点，或全面翻新获批。旋钮基线从 Section 1
- **Redesign - Preserve** — 现代化但不破坏品牌。先审计，提取品牌 Token，逐步演进
- **Redesign - Overhaul** — 在现有内容上建新视觉语言。视觉按 Greenfield 处理；保留内容和 IA

如果模棱两可，问一次：*"这次重设计是保留现有品牌，还是视觉上从头开始？"*

### 8.B 审计先于改动

提出改动前，记录当前状态：
- **品牌 Token** — 主色/强调色、字体栈、Logo 处理、圆角
- **信息架构** — 页面树、主导航、关键转化路径
- **内容块** — 什么存在、什么有效、什么是填充
- **保留模式** — 签名交互、可识别的 Hero、文案语气
- **退役模式** — AI 痕迹、破损布局、死链接、通用库存图片、性能陷阱
- **现有站点旋钮读数** — 推断当前 DESIGN_VARIANCE / MOTION_INTENSITY / VISUAL_DENSITY。这是起点，不是基线
- **SEO 基线** — 当前排名页、meta 标题、结构化数据、OG 卡片。**SEO 迁移是重设计 #1 风险**

### 8.C 保留规则

- **不改信息架构**，除非被要求。保持页面 slug、锚点 ID、主导航标签稳定（SEO + 肌肉记忆）
- **提取品牌色后再应用 Section 4.2**。已经是紫色的品牌保持紫色——应用 LILA RULE 的突破条件
- **保留文案语气**，除非要求重写。视觉现代化 ≠ 内容重写
- **尊重现有无障碍成果**。不退化 focus state、alt text、键盘导航、对比度
- **尊重现有分析事件**。不改按钮名、表单字段名、section ID

### 8.D 现代化杠杆（优先级顺序）

按顺序应用——Brief 满足即停：
1. **字体刷新** — 每单位风险的最大视觉提升
2. **间距与节奏** — 增加 section padding，修复垂直节奏
3. **色彩校准** — 降低饱和度、统一中性色、保留品牌强调色
4. **动效层** — 添加 MOTION_INTENSITY 合适的微交互到现有组件
5. **Hero 和关键 section 重组** — 用 Section 10 词汇重构顶部漏斗
6. **完整块替换** — 仅当现有块不可救药时

### 8.E 决策树：定向演进 vs 全面重设计

- IA、内容、SEO 健全 → **定向演进**（杠杆 1-4）。~70% 价值在 ~40% 风险
- 视觉债务是结构性的（IA 破损、无设计系统、移动端破损）→ **全面重设计**，严格保留内容
- 品牌本身在变化 → **Greenfield**

### 8.F 永不静默更改的内容

未经用户明确批准，永不修改：
- URL 结构 / 路由 slug
- 主导航标签
- 表单字段名或顺序（破坏分析 + 自动填充）
- 品牌 Logo 或文字标记
- 现有法律/同意/Cookie 文案

---

## 9. Reference Vocabulary（参考模式词汇）

这是词汇表，不是库。Agent 应该**知道这些模式名称**，以便在设计时引用、在 Design Read 中命名、在需要时 reach for。

### Hero 范式
- **Asymmetric Split Hero** — 文字在一侧，资产在另一侧，慷慨留白
- **Editorial Manifesto Hero** — 大字排版，无资产，几乎像海报
- **Video / Media Mask Hero** — 文字作为视频背景的蒙版
- **Kinetic-Type Hero** — 动画排版作为主要视觉
- **Curtain-Reveal Hero** — Hero 部分在滚动时像幕布一样展开
- **Scroll-Pinned Hero** — Hero 保持固定，内容在背后滚动

### 导航 & 菜单
- **Magnetic Button** — 向光标拉近
- **Dynamic Island** — 变形 pill 用于状态/提醒
- **Mega Menu Reveal** — 全屏下拉，stagger-fade 内容
- **Floating Speed Dial** — FAB 弹出弯曲的次要操作

### 布局 & 网格
- **Bento Grid** — 非对称 tile 分组（Apple Control Center）
- **Masonry Layout** — 交错网格，无固定行高
- **Split-Screen Scroll** — 两半向相反方向滑动
- **Sticky-Stack Sections** — Section 固定并堆叠在滚动上

### 卡片 & 容器
- **Parallax Tilt Card** — 3D 倾斜追踪鼠标坐标
- **Spotlight Border Card** — 边框在光标下发光
- **Glassmorphism Panel** — 磨砂玻璃带内折射
- **Morphing Modal** — 按钮展开为自己的对话框

### 滚动动画
- **Sticky Scroll Stack** — 卡片固定并物理堆叠
- **Horizontal Scroll Hijack** — 垂直滚动 → 水平平移
- **Zoom Parallax** — 中央背景图片在滚动时缩放
- **Scroll Progress Path** — SVG 线条沿滚动绘制
- **Locomotive / Sequence Scroll** — 平滑滚动 + 滚动驱动的序列动画
- **Liquid Swipe Transition** — 滑动过渡像液体一样流动
- **Dome Gallery** — 3D 穹顶画廊，滚动时旋转

### 画廊 & 媒体
- **Coverflow Carousel** — 3D 轮播带斜边
- **Drag-to-Pan Grid** — 无边界的可拖动画布
- **Accordion Image Slider** — 窄条在 hover 时展开
- **Hover Image Trail** — 鼠标留下弹出图片轨迹

### 排版 & 文字
- **Kinetic Marquee** — 无尽文字条在滚动时反转
- **Text Mask Reveal** — 大字作为透明窗口到视频
- **Text Scramble Effect** — Matrix 风格解码
- **Circular Text Path** — 文字沿旋转圆弯曲

### 微交互 & 效果
- **Particle Explosion Button** — CTA 在成功时碎裂成粒子
- **Skeleton Shimmer** — 移动光反射穿过占位符
- **Directional Hover-Aware Button** — 填充从光标确切侧进入
- **Ripple Click Effect** — 波从点击坐标扩散
- **Mesh Gradient Background** — 有机熔岩灯斑点
- **Lens Blur Depth** — 背景 UI 模糊以聚焦前景操作
- **Mac OS Dock Magnification** — 鼠标悬停时图标放大+相邻图标推开
- **Gooey Menu** — SVG 滤镜使菜单项像粘液一样融合/分离
- **Contextual Radial Menu** — 右键/点击展开环形菜单
- **Chroma Grid** — 网格项在 hover 时变色/变形
- **Holographic Foil Card** — 卡片表面有全息箔片光泽效果
- **Tinder Swipe Stack** — 卡片堆叠，拖拽滑动+物理弹回
- **Glitch Effect Image** — 数字故障效果（位移/色差/撕裂）
- **Gradient Stroke Animation** — SVG 描边沿路径流动渐变
- **Kinetic Typography Grid** — 网格中的每个字母独立动画
- **Liquid Pull-to-Refresh** — 下拉刷新变成粘性液体变形
- **Animated SVG Line Drawing** — SVG 路径从起点到终点动态绘制

### 动画库选择
- **Motion (`motion/react`)** — 默认用于 UI / Bento / 状态变化动效
- **GSAP + ScrollTrigger** — 用于全页滚动叙事和滚动劫持。隔离在专用叶子组件中，带 `useEffect` 清理
- **Three.js / WebGL** — 用于 Canvas 背景和 3D 场景。同样隔离规则
- **NEVER 混用 GSAP/Three.js 与 Motion 在同一组件树** — 它们争抢同一帧

---

## 10. 品牌套件生成（Brandkit）

> 从原版 brandkit 移植。用于品牌标识系统、Logo 概念板、品牌手册封面等视觉交付。

### 10.A 核心原则

品牌套件不是装饰。它是品牌为何存在的视觉论证。每张生成板必须回答：
1. 这个品牌代表什么？
2. 核心隐喻是什么？
3. Logo 如何表达这个隐喻？
4. 系统如何在 UI、印刷、图片、细节上扩展？
5. 为什么整体感觉是可拥有的？

### 10.B 品牌策略推断

生成前推断品牌策略：

| 类别 | 核心想法 | 可能的符号逻辑 |
|------|---------|--------------|
| 开发者工具 | 构建、速度、精确、控制 | 光标、框架、螺栓、脚手架、网格 |
| AI 助手 | 委托、智能、清晰 | 火花、轨道、信号、路径、节点 |
| 安全 | 保护、警戒、边界 | 盾牌、眼睛、印章、受保护核心 |
| 游戏/博彩 | 机会、回报、紧张、速度 | 骰子、宝石、卡片、信号、奖杯 |
| 语音 AI | 声音、节奏、命令、流动 | 波形、麦克风、球体、语音路径 |
| 合规 | 信任、秩序、规则、保护 | 印章、狗、徽章、文档、盾牌 |
| 机器人/无人机 | 飞行、控制、视觉、任务 | 翅膀、猫头鹰、准星、路径、区域 |
| 奢侈品/编辑 | 品味、材料、仪式、克制 | 字母组合、印章、纸张、压印、标记 |
| 生产力 | 专注、动量、清晰 | 路径、勾选、方块、日历、光 |

### 10.C Logo 概念方法（选 1-2）

1. **Monogram + Meaning** — 品牌首字母 + 隐喻（K + 风筝/框架/方向）
2. **Product Action** — 产品主要动作转为符号（build→框架/protect→盾牌/speak→波形）
3. **Metaphor Fusion** — 两个有意义想法融合（猫头鹰+无人机视觉、盾牌+山）
4. **Negative Space** — 用空白创造智能（隐藏箭头、保护中心、切割首字母）
5. **Construction Geometry** — 从清晰系统创建标记（圆、对角线切割、网格、框架）

### 10.D 默认 3×3 面板系统

1. **Logo Cover** — 大 Logo + 字标，极简标题，强负空间
2. **Logo Construction** — 符号分解、网格、几何或负空间逻辑
3. **Digital Application** — 浏览器 chrome、app header、终端、仪表盘片段
4. **Brand Essence** — 一句标语，大号可读排版，稀疏构图
5. **Color System** — 色板、渐变条、色盘、材质芯片
6. **Typography** — 大字型样本、字母行、主/副字体配对
7. **Physical Application** — 卡片、文件夹、徽章、海报、标签
8. **Image Direction** — 电影景观、产品裁剪、半色调海报、编辑场景
9. **System Detail** — UI 芯片、输入栏、命令行、图标行、徽章系统

### 10.E 视觉模式

| 模式 | 适用 | 视觉线索 |
|------|------|---------|
| Dark Developer | 开发者工具、编码 Agent、基础设施 | 近黑面板、等宽强调、命令行、终端窗口、青色/蓝色/珊瑚强调 |
| Dark Product | 商业工具、增长工具、销售 Agent | 黑/深红/琥珀、发光 UI 芯片、卡片系统、分段流程 |
| Dark Nature | 策略、旅行、健康、安静 premium SaaS | 深绿、石灰强调、雾景、柔和覆盖 |
| Dark Security | 安全、合规、监控 | 黑/海军蓝、盾牌形式、雷达线、威胁标签 |
| Light Editorial | 法律、隐私、合规、文档 | 暖象牙、纸张纹理、小衬线标签、印章/徽章 |
| Luxury | 美妆、时尚、酒店、premium 服务 | 象牙/石头/浓缩咖啡、衬线字标、优雅字母组合 |
| Voice | 语音 AI、聊天、助手、音频 | 深靛蓝、丁香光晕、波形、麦克风 |
| Cultural | 音乐、创意工具、活动、游戏 | 半色调、CRT 纹理、模拟印刷、大胆强调色 |

### 10.F 色板纪律

- 用一个主导色板
- 强调色必须跨面板重复
- 无随机彩虹（除非要求）
- 无通用紫蓝 AI 光晕（除非合适）
- 一个强调色可承载整个系统

### 10.G 输出标准

图像必须看起来像：
- premium 标识套件
- 高级设计师的展示板
- 品牌系统案例研究
- 视觉发布方向
- 专业 Logo 概念板

---

## 11. 邮件模板特化规则

### 10.A 技术约束
- 用 table-based HTML + inline CSS。无 `<div>` 布局、无 Flexbox、无 Grid、无 JS
- 宽度 ≤ 600px，居中
- 字体用 web-safe：`Georgia, 'Times New Roman', serif` 或 `Arial, 'Helvetica Neue', Helvetica, sans-serif`
- 背景色用 `bgcolor` 属性，不是 CSS `background`

### 10.B 设计约束
- 预渲染后截屏检查。邮件客户端渲染不一致
- 纯文本备选必须提供
- 不要用 emoji（渲染不一致）
- 不要用背景图片（Outlook 不支持）
- CTA 按钮用 VML 或全宽 table cell（`<td>` 包 `<a>` 带 `display: block`）

### 10.C B端冷邮件特化
- 标题行 ≤ 60 字符（手机端显示约 30-40 字符）
- 预览文本 ≤ 100 字符
- 正文 ≤ 150 词
- 一个 CTA，一个意图
- 个人信息化：`{{first_name}}`、`{{company_name}}`
- 退链：`{{unsubscribe_url}}`

---

## 12. 全量输出规则（Full-Output Enforcement）

> 从 output-skill 移植。确保设计交付物完整、无占位符、无骨架代码。

### 11.A 基线

每个任务都是生产级交付。部分输出 = 损坏输出。不优化简洁——优化完整。如果用户要完整文件，交付完整文件。如果用户要 5 个组件，交付 5 个组件。无例外。

### 11.B 禁止的输出模式

以下模式是硬失败。永远不要产生：

**代码块中：**
- `// ...`、`// rest of code`、`// implement here`、`// TODO`、`/* ... */`
- `// similar to above`、`// continue pattern`、`// add more as needed`
- 裸 `...` 替代省略代码
- 输出骨架代码当请求是完整实现
- 展示第一个和最后一个 section 而跳过中间
- 描述代码应该做什么而不是写出来

**散文中：**
- "Let me know if you want me to continue"
- "I can provide more details if needed"
- "for brevity"、"the rest follows the same pattern"
- "similarly for the remaining"、"and so on"（替代实际内容时）
- "I'll leave that as an exercise"

### 11.C 执行流程

1. **Scope** — 读完整请求。计数预期交付物数量（文件、函数、section、答案）。锁定数量
2. **Build** — 完整生成每个交付物。无部分草稿、无"你可以之后扩展"
3. **Cross-check** — 输出前重读原始请求。对比交付物计数与 scope 计数。缺失则补全后再回复

### 11.D 长输出处理

当回复接近 token 限制时：
- 不压缩剩余 section 来挤进去
- 不跳到结论
- 以全质量写到干净断点（函数结束、文件结束、section 结束）
- 以如下格式结束：

```
[PAUSED — X of Y complete. Send "continue" to resume from: next section name]
```

---

## 13. OUT OF SCOPE（本技能不覆盖）

- Dashboard / 密集产品 UI / 管理后台（用 Fluent / Carbon / Atlaskit / Polaris）
- 数据表（用 TanStack Table / AG Grid）
- 多步骤表单 / 向导（用表单特定模式）
- 代码编辑器（用 Monaco / CodeMirror 官方皮肤）
- 原生移动端（用 Apple HIG / Material 直接）
- 实时协作 UI（presence、cursor、OT-aware）

如果 Brief 是以上之一，**明确说出来**，指向正确工具，仅将本技能的营销页/关于页/Landing 页部分应用到适用的表面。

---

## 14. Appendices（附录）

### 附录 A：设计系统安装命令

```bash
# Fluent UI React (Microsoft)
npm install @fluentui/react-components @fluentui/react-icons

# Carbon React (IBM)
npm install @carbon/react @carbon/icons-react

# Radix UI (独立原语)
npm install @radix-ui/react-dialog @radix-ui/react-dropdown-menu @radix-ui/react-tabs

# shadcn/ui (代码归你)
npx shadcn@latest init
npx shadcn@latest add button card dialog dropdown-menu

# Primer React (GitHub)
npm install @primer/react @primer/octicons-react

# Atlaskit (Atlassian)
npm install @atlaskit/button @atlaskit/calendar @atlaskit/modal-dialog

# Polaris (Shopify)
npm install @shopify/polaris @shopify/polaris-icons

# Material Web 3
npm install @material/web

# Bootstrap 5
npm install bootstrap @popperjs/core

# GOV.UK Frontend
npm install govuk-frontend

# USWDS (U.S. Web Design System)
npm install @uswds/uswds
```

### 附录 B：规范链接

| 设计系统 | 官方文档 | GitHub |
|---------|---------|--------|
| Fluent UI | https://react.fluentui.dev | https://github.com/microsoft/fluentui |
| Carbon | https://carbondesignsystem.com | https://github.com/carbon-design-system/carbon |
| Radix UI | https://radix-ui.com/primitives | https://github.com/radix-ui/primitives |
| shadcn/ui | https://ui.shadcn.com | https://github.com/shadcn-ui/ui |
| Primer | https://primer.style/react | https://github.com/primer/react |
| Atlaskit | https://atlassian.design/components | https://bitbucket.org/atlassian/atlassian-frontend |
| Polaris | https://polaris.shopify.com | https://github.com/Shopify/polaris |
| Material Web | https://material-web.dev | https://github.com/material-components/material-web |
| Bootstrap | https://getbootstrap.com | https://github.com/twbs/bootstrap |
| GOV.UK | https://design-system.service.gov.uk | https://github.com/alphagov/govuk-frontend |
| USWDS | https://designsystem.digital.gov | https://github.com/uswds/uswds |

### 附录 C：Apple Liquid Glass CSS 近似实现

```css
/* Apple Liquid Glass — Web 近似实现 */
.liquid-glass {
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(40px) saturate(1.4);
  -webkit-backdrop-filter: blur(40px) saturate(1.4);
  border: 0.5px solid rgba(255, 255, 255, 0.15);
  border-radius: 24px;
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.2),
    0 8px 32px rgba(0, 0, 0, 0.12);
}

/* Dark mode variant */
@media (prefers-color-scheme: dark) {
  .liquid-glass {
    background: rgba(0, 0, 0, 0.3);
    border: 0.5px solid rgba(255, 255, 255, 0.06);
    box-shadow:
      inset 0 1px 0 rgba(255, 255, 255, 0.05),
      0 8px 32px rgba(0, 0, 0, 0.3);
  }
}

/* Reduced transparency fallback */
@media (prefers-reduced-transparency: reduce) {
  .liquid-glass {
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: none;
    -webkit-backdrop-filter: none;
  }
  @media (prefers-color-scheme: dark) {
    .liquid-glass {
      background: rgba(0, 0, 0, 0.85);
    }
  }
}
```

---

## 15. Block Library（设计模式代码库）

> 从原版 taste-skill Block Library 移植。定义可复用的设计模式代码块，每个 block 有标准 frontmatter 和 8 个必填章节。

### 13.A 文件位置约定

```
skills/design-taste/blocks/
├── hero/              # Hero 模式
├── feature/           # Feature section 模式
├── social-proof/      # 社交证明模式
├── pricing/           # 定价表模式
├── cta/               # CTA 模式
├── footer/            # 页脚模式
├── navigation/        # 导航模式
├── portfolio/         # 作品集模式
└── transition/        # 过渡/动画模式
```

### 13.B Block Frontmatter Schema

每个 block 文件以如下 frontmatter 开头：

```yaml
---
name: string          # 模式名称，如 "Asymmetric Split Hero"
category: string      # 分类，如 "hero"
dial_compatibility:   # 三旋钮兼容范围
  variance: [min, max]
  motion: [min, max]
  density: [min, max]
when_to_use: string   # 何时选择这个模式
not_for: string       # 何时避免
stack: string[]       # 技术栈，如 ["Tailwind", "Motion"]
---
```

### 13.C Block 必填章节

每个 block 必须包含以下 8 个章节：

1. **Visual sketch** — 视觉描述（布局、节奏、视觉层次）
2. **Props API** — 组件的 props/参数定义
3. **Code sketch** — 核心实现代码（React/Tailwind）
4. **Mobile fallback** — < 768px 的退化方案
5. **Motion variants** — 动效变体（entry/hover/exit）
6. **Dark-mode notes** — 暗色模式适配说明
7. **Anti-patterns** — 常见错误用法
8. **References** — 灵感来源/参考链接

### 13.D 使用方式

当 Design Read 确定需要某个模式时：
1. 在对应分类目录下查找匹配的 block
2. 检查 dial_compatibility 是否匹配当前旋钮值
3. 读取 block 的 Code sketch 作为实现起点
4. 按 Mobile fallback 和 Dark-mode notes 适配

**注意：** Block Library 是参考实现，不是模板。每个 block 需要根据具体 Brief 调整。

---

## 16. FINAL PRE-FLIGHT CHECK（最终交付检查）

**在输出代码前运行此矩阵。这是最后一道过滤器。**

**这不是可选的。逐项检查。任何一项失败 = 输出未完成。**

### 基础检查
- [ ] **Brief inference** 已声明（Section 0.B 一行 Design Read）？
- [ ] **旋钮值** 明确且从 Brief 推理得出，不是静默使用基线？
- [ ] **设计系统** 从 Section 2 选择（如适用），或美学方向诚实标注？
- [ ] **重设计模式** 已检测并执行审计（如适用，Section 8）？

### 排版检查
- [ ] **ZERO em-dashes（`—`）** 在页面任何位置。标题、眉毛、标签、正文、引用、归属、说明、按钮、alt 文本。零。（Section 4.2.D - 不可协商）
- [ ] **Serif 纪律**：如果用衬线，不是 Fraunces 或 Instrument Serif（或者有品牌理由）？与上一个项目不同？
- [ ] **Premium Consumer 色板检查**：如果 Brief 是高端消费品，色板不是 AI 默认暖米+黄铜+牛血红+浓缩咖啡家族？与上一个高端消费品项目不同？
- [ ] **Italic 下延字母 clearance**：每个含 `y g j p q` 的斜体词有 `leading-[1.1]` 最低 + `pb-1` 预留？
- [ ] **字体不是 Inter 默认**（除非品牌或用明确要求）？

### 布局检查
- [ ] **Page Theme Lock**：全页一个主题（light/dark/auto）。无 section 翻转（Section 4.7）？
- [ ] **Color Consistency Lock**：一个强调色全页一致（Section 4.2）？
- [ ] **Shape Consistency Lock**：一个圆角体系全页一致（Section 4.3.B）？
- [ ] **Hero 适配视口**：标题 ≤ 2 行，副文本 ≤ 20 词 AND ≤ 4 行，CTA 无需滚动可见，字号与图片一起规划？
- [ ] **Hero top padding**：最大 `pt-24` 桌面端，Hero 内容不浮在视口中部？
- [ ] **Hero 堆叠纪律**：最多 4 个文字元素（眉毛或品牌条、标题、副文本、CTA）？CTA 下方无小标签行、无信任微条？
- [ ] **EYEBROW 计数（机械）**：计算所有 section 中 `uppercase tracking` 微标签的数量。计数 ≤ ceil(sectionCount / 3)？Hero 算 1 个。
- [ ] **Split-Header 禁令**：无"左大标题 + 右小段落"浮动布局（垂直堆叠代替）？
- [ ] **Zigzag 交替上限**：无 3+ 连续 section 用同一图片+文字交替布局？
- [ ] **CTA intent 不重复**：无两个同一 intent 的 CTA（"联系我们" + "开始对话" 同时存在 = 失败）？
- [ ] **Logo wall = logo only**：无行业/品类标签在 logo 下方？
- [ ] **Bento 背景多样性**：至少 2-3 个格子有真实视觉变化（图片/渐变/有色背景），不全白底纯文字卡片？
- [ ] **"Used by / Trusted by" Logo wall** 在 Hero 下方，不在 Hero 内部，用真实 SVG logo（Simple Icons / devicon）或生成的 SVG 标志，不用纯文本？
- [ ] **导航单行** 桌面端，高度 ≤ 80px？
- [ ] **Section-Layout-重复** 检查：无两个 section 用同一布局家族（8 个 section 至少 4 种不同布局）？
- [ ] **Bento 有节奏且格子数精确**（N 项 → N 格，中间或末尾无空格）？
- [ ] **长列表用正确 UI 组件**（不是默认 `<ul>` + `divide-y` 给 > 5 项 - 见 Section 4.3.C 替代方案）？

### 视觉资产检查
- [ ] **使用真实图片**（生图工具优先，然后 Picsum-seed，然后明确占位符槽）—— 无 `<div>` 假截图、无手绘装饰 SVG、无纯文字"极简"？
- [ ] **无标签叠加在图片上**（无 `Plate · Brand`、无 `Field notes - journal`）？
- [ ] **无照片署名作为装饰**（`Field study no. 12 · Ines Caetano`）？
- [ ] **无版本 footer**（`v1.4.2`、`Build 0048`）在营销页上？
- [ ] **无微元句子**在 eyebrow 下（"Each of these is a feature we ship today..."）？
- [ ] **无装饰文字条在 Hero 底部**（`BRAND. MOTION. SPATIAL.`）？
- [ ] **无右上角浮动段落**在 section 标题中？
- [ ] **无进度条/评分条带填充背景轨道**作为对比视觉？
- [ ] **无地点/城市名/时间/天气条**，除非 Brief 是真正的全球分布或地点聚焦？
- [ ] **无滚动提示**（`Scroll`、`↓ scroll`、`Scroll to explore`）？
- [ ] **无版本标签在 Hero**（V0.6、BETA、INVITE-ONLY）除非 Brief 是发布？
- [ ] **无序号 eyebrow**（`00 / INDEX`、`001 · Capabilities`、`06 · how it works`）？
- [ ] **无装饰性圆点**（默认零，仅用于真实语义状态）？
- [ ] **无 `border-t` + `border-b` 在长列表/规格表的每一行**？

### 内容检查
- [ ] **内容密度** 合理：无 20 行数据表、无假精确规格无理由、默认 ≤ 25 词子段落？
- [ ] **引用 ≤ 3 行** 正文，归属干净（无 em-dash）？
- [ ] **文案自审**：每个可见字符串已重读，无语法破碎或 AI 幻觉短语？
- [ ] **无假人名/品牌名/数字**？

### 动效检查
- [ ] **动效有动机**：每个动画一句话可证明（层级/叙事/反馈/状态），无 GSAP-for-show？
- [ ] **Marquee 最多 1 个/页**：无两个水平 marquee 在同一页？
- [ ] **动效声明 = 动效实现**：如果 MOTION_INTENSITY > 4，页面实际有动画，不只是声明？
- [ ] **GSAP sticky-stack / horizontal-pan** 按 Section 5.B/5.C 规范骨架实现（`start: "top top"`、`pin: true`、正确 scrub）？
- [ ] **无 `window.addEventListener('scroll')`** — 用 Motion `useScroll()` / ScrollTrigger / IntersectionObserver / CSS scroll-driven animations？
- [ ] **Reduced Motion** 包裹了 MOTION > 3 的所有内容？

### 性能 & 无障碍检查
- [ ] **Dark Mode** Token 已定义并在两种模式下测试？
- [ ] **移动端退化** 明确（`w-full`、`px-4`、`max-w-7xl mx-auto`）给高 VARIANCE 布局？
- [ ] **视口稳定性**：`min-h-[100dvh]`，永不 `h-screen`？
- [ ] **`useEffect` 动画** 有严格清理函数？
- [ ] **空/加载/错误状态** 已提供？
- [ ] **卡片被省略** 在间距足够时？
- [ ] **图标** 来自允许的库（Phosphor / HugeIcons / Radix / Tabler），无手绘 SVG 路径？
- [ ] **Motion** 隔离在 client-leaf 组件中，带 `'use client'` 在顶部，memoized？
- [ ] **无 AI 痕迹** 来自 Section 7（Inter 默认、AI 紫、三列等宽、John Doe、Acme、"Quietly in use at"）？
- [ ] **Core Web Vitals** 合理可达（LCP < 2.5s、INP < 200ms、CLS < 0.1）？
- [ ] **一个设计系统** 每个项目（无 Material + shadcn 混搭）？

---

**如果任何一个复选框不能诚实勾选，页面未完成。修复后再交付。**
