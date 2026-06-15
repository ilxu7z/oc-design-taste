---
name: design-taste
description: >-
  设计品味校准框架 v3。三旋钮推理 + Context-Aware 痕迹目录 + 机械交付检查 + 重设计协议 + 邮件模板特化。
  适配B端制造业/画册/官网/生图/排版/邮件模板等视觉类任务。
  触发：设计/UI/前端/页面/画册/图片/官网/生图/样式/排版/布局/重新设计/邮件/email/template/EDM/Newsletter。
  内建容错：交付前二进制检查 → 不合格自动打回。
---

# Design Taste v3 — 设计品味校准框架

> **核心理念**：AI 输出的默认值 = 模板感、无品味。
> 但规则不是死的——每条都有**适用场景**和**突破条件**。
> 真正的品味 = 知道什么时候遵守规则，什么时候打破规则。

> **工作流**：读房间 → 调旋钮 → 选美学 → 写 Read → 派活 → 检查 → 打回或交付。

---

## 0. Brief Inference（读前确认）

**禁止拿到任务直接开干。** 先输出 Design Read。

### 0.A 读取信号

1. **载体类型** — 产品画册 / 官网首页 / 产品页 / 场景页 / 生图 / Logo / 海报 / 邮件模板 / Landing Page / 品牌手册
2. **任务模式** — 新建（Greenfield）/ 优化保留（Redesign-Preserve）/ 推翻重来（Redesign-Overhaul）
3. **受众** — 海外B端买家 / 国内经销商 / 终端消费者 / 双受众 / 招聘方
4. **品牌调性关键词** — 用户用过的词："洁白干净""专业""实拍感""自然""工业""高端""premium""极简"
5. **已有品牌资产** — Logo、品牌色、已生成的图片、参考图、现有网站 URL
6. **约束条件** — 中英双语 / 多语言 / 三端响应式 / 移动优先 / 打印尺寸 / 字数限制 / 邮件客户端兼容
7. **静默约束** — 合规行业（食品/医疗/金融）、无障碍优先、信任优先（B端采购委员会）

### 0.B 输出三行 Design Read

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

OEM品牌官网 × 双受众 × 自然专业
→ 美学家族：食品工业风 + 实拍质感 + 温暖中性色
→ 技术栈：Next.js + Tailwind + Motion 动效

B端冷邮件模板 × 海外B端买家 × 品牌信任 + 高转化
→ 美学家族：品牌极简 + 高对比CTA + 克制配色
→ 技术栈：table-based HTML email（邮件客户端兼容）
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
| "极简/干净/平静/editorial" | 4-5 | 2-3 | 2-3 |
| "高端消费者/Apple风/品牌" | 6-7 | 4-6 | 3-4 |
| "活泼/大胆/Dribbble/实验" | 8-10 | 7-10 | 3-4 |
| "B端/信任优先/公共部门" | 3-4 | 2-3 | 4-6 |
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

**铁律：一个项目只用一种设计系统。** 不混搭 Material + shadcn。

### 2.E 邮件模板

| 场景 | 美学方向 | 技术栈 |
|------|---------|--------|
| B端冷邮件 | 品牌极简 + 高转化 | table-based HTML + inline CSS |
| 营销邮件 | 品牌叙事 + 视觉驱动 | table-based HTML + inline CSS |
| 事务邮件（订单/报价） | 结构化 + 信任感 | table-based HTML + inline CSS |
| Onboarding 序列 | 品牌叙事 + 渐进式 | table-based HTML + inline CSS |

---

## 3. Default Architecture（默认架构约定）

当 Design Read 没有选择特定设计系统时，使用以下默认值。

### 3.A 技术栈

| 项目类型 | 默认栈 |
|---------|--------|
| Web 项目 | Next.js + Tailwind v4 + Motion（`motion/react`） |
| 静态页面 | Tailwind v4 + 原生 CSS |
| 邮件模板 | table-based HTML + inline CSS（邮件客户端兼容） |
| 画册/PDF | HTML/CSS → PDF（Puppeteer/Playwright） |

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

#### 4.1.B 排版纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 英文行宽 ≤ 65ch | 超过导致阅读疲劳 | 窄栏引用、数据表 |
| 中文行宽 ≤ 40em | 中文阅读舒适宽度 | 表格、数据密集区 |
| `<br>` 不断标题 | "for thirty\<br\>*years.*" 式花活是 AI 痕迹 | 用户明确要求，或 editorial 大字排版 |
| 标题不加随机衬线词 | "we design **and** spatial" 中 **and** 换字体是业余 | 同一字体用 italic/bold 强调即可 |
| Italic 下延字母 clearance | 斜体含 y/g/j/p/q 时，`leading-[1.1]` 最低 + `pb-1` | 会裁切下延字母 |
| emoji 不当图标 | 不像专业设计 | 用户明确要求"活泼社交"风且只偶尔使用 |
| 显示/标题字号 | 默认 `text-4xl md:text-6xl tracking-tighter leading-none` | 内容驱动 |
| 正文字号 | 默认 `text-base text-gray-600 leading-relaxed max-w-[65ch]` | 内容驱动 |

### 4.2 Color 色彩规则

#### 4.2.A 基础纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 单一强调色 | 全页只用 1 个 accent color | 品牌本身有多色体系且用户确认 |
| 饱和度 < 80% | B端 < 60%，消费者 < 80% | 品牌色本身就是高饱和（如可口可乐红） |
| 单一灰色系 | Zinc/Slate/Stone 择一，全页一致 | 无 |
| 不用纯黑 #000 + 纯白 #FFF | 用 #111 + #FAFAFA 或品牌色系 | 纯黑用于印刷（CMYK 100%K） |
| Color Consistency Lock | 选定 accent 后，全页所有 section 一致 | 无——这是铁律 |

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

#### 4.2.C Em-Dash 全面禁令

**Em-dash（`—`）和 En-dash（`–`）在所有可见文本中完全禁止。**

这是 LLM #1 文案痕迹。AI 用 em-dash 当万能分隔符、修辞手段、设计元素。

| 禁止位置 | 替代方案 |
|---------|---------|
| 标题 | 用句号或逗号 |
| 副标题/标签/按钮 | 用换行、竖线或空格 |
| 正文 | 拆成两句话，或用逗号/括号/冒号 |
| 引用归属 | 用普通连字符 ` - ` 或换行 + 小字 |

**唯一允许的 dash：** 普通连字符 `-`（复合词、数字范围）。零 em-dash，零例外。

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
| Page Theme Lock | 全页一个主题（light/dark/auto），section 不反转 | 用户明确要求 Color Block Story |
| Shape Consistency Lock | 选一个圆角体系全页一致 | 有文档化规则时可混用 |

#### 4.3.C 内容密度

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| Section 默认形态 | 短标题(≤8词) + 短段落(≤25词) + 1个视觉 | 内容驱动型 section |
| 长列表换组件 | >5 项不用 `<ul>` + `divide-y`，用卡片网格/Tab/手风琴/横向滚动 | 数据表 |
| 表格不要每行底线 | 选其一：行底线 或 组顶部线，不要全加上 | 数据密集型对比表 |
| 引用 ≤ 3 行 | 超过就截断 | 无 |
| 引用归属：姓名+角色+(公司) | 不能只有 "- Sarah" | 无 |

#### 4.3.D 移动端退化

所有多栏布局在 < 768px **必须**声明退化为单列：
- `w-full px-4 py-8`
- 非对称分栏 → 上下堆叠
- 隐藏装饰性元素

**不是可选的。** "Tailwind 会处理" 的假设不可接受。

### 4.4 Materiality, Shadows, Cards（材质与卡片）

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 卡片仅用于层级表达 | 否则用 `border-t` / `divide-y` / 负空间分组 | 无 |
| 阴影调色 | 阴影色调匹配背景色，不用纯黑 drop shadow | 无 |
| DENSITY > 7 时禁止卡片 | 数据指标在纯布局中呼吸 | 无 |

### 4.5 Interactive UI States（交互状态）

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

### 4.6 Image & Visual Asset 视觉资产规则

#### 4.6.A 资产优先级链

| 优先级 | 来源 | 适用场景 |
|--------|------|----------|
| **1. 品牌实际图片** | 用户提供的 URL/文件 | 最佳——永远优先用真实素材 |
| **2. 生图工具** | GLM-5.1 prompt → 生图模型 | Hero、场景图、产品特写 |
| **3. Picsum-seed** | `picsum.photos/seed/{描述}/{w}/{h}` | 占位图，seed 必须描述内容 |
| **4. 明确标注占位** | `<!-- TODO: hero photo 1600x1200 -->` | 前三者都不可用时 |

**❌ 永远不做**：用 `<div>` 矩形模拟截图、手绘 SVG 图标当装饰、纯文字页面称"极简"。

#### 4.6.B Logo Wall 纪律

- Logo = logo only，不加行业标签（不要 `Stripe + payments`）
- 用真实 SVG logo（Simple Icons CDN / devicon / 品牌实际 logo）
- 造品牌名 → 造 SVG 标志（单字母圆形/双字母组合），不要用纯文本
- 确保 logo 在 light/dark 两种模式下都可见

#### 4.6.C 生图特有规则

| 痕迹 | 说明 | 处理 |
|------|------|------|
| ❌ AI 完美感 | 无尘、对称、过度饱和、塑料感 | prompt 加 "workshop feel, natural arrangement" |
| ❌ 面孔不匹配 | 东南亚内容用白/黑人面孔 | prompt 加 "Southeast Asian faces" |
| ❌ 空洞背景 | 无环境上下文 | ZONAL ANALYSIS 填满 Zone A/B/C/D |
| ❌ 幻觉文字 | 画面内出现不存在的中英文 | prompt 注明 "no visible text or labels" |
| ❌ 光源无方向 | 产品图无主光源信息 | 标注光源方向/色温/景深 |
| ❌ 品牌色缺失 | 生图不带品牌色融入 | prompt 标注品牌色 hex |

#### 4.6.D 面孔 & 地名真实性

- 不用 John Doe / Sarah Chan / Jack Su → 用真实感名称
- 不用 Acme / Nexus / SmartFlow → 造出符合行业语境的品牌名
- 不用 99.99% / 50% 等完美数字 → 用 47.2%、83% 等不规整数据
- 不用 "Elevate/Seamless/Unleash/Next-Gen/Revolutionize" → 用具体动词

### 4.7 文案自审（强制）

交付前逐条重读每个可见字符串，标记并重写：

| 问题类型 | 示例 | 修复 |
|---------|------|------|
| 语法破碎 | "free on its past" | 重写为自然语句 |
| 指代不清 | "we plan to stay that way" | 明确指代 |
| AI 幻觉文案 | 强行文艺、假工匠感标签 | 替换为平实功能句 |
| 假精确数字 | 92%、4.1×、48k | 要么来自真实数据，要么标注为 mock |
| 多语气混用 | 技术 mono + 营销 punch 混在同一页 | 统一为一种语气 |

### 4.8 Page Theme Lock（页面主题锁定）

- 全页一个主题（light/dark/auto），section 不反转
- 例外：用户明确要求 Color Block Story，且是刻意编排（全页一次主题切换，带强过渡）
- 默认：在页面级别选择 light/dark/auto（`prefers-color-scheme`），锁定
- 使用设计系统内置主题时，在 `layout.tsx` 或页面根节点设置一次

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

关键点：`start: "top top"`、`pin: true`、`end: "+=$ {distance}"`（滚动长度 = 水平滑动距离）、`scrub: 1`。

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

> **核心区别**：v1 是二进制禁令表。v3 每条都标注了**为什么禁**和**什么时候可以突破**。
> 机械检测到 → 查表 → 有突破条件 → 判断是否适用 → 不适用则修复。

### 7.A 排版痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 | 突破条件 |
|---|------|-------------|---------|----------|
| T01 | Inter 字体做标题 | LLM 安全牌 | 换 Geist/Outfit/品牌字体 | 品牌本身用 Inter 或用户明确要求 |
| T02 | Serif 滥用 | AI 误认为"创意=衬线" | 默认 Sans，Serif 仅 editorial/luxury | 品牌明确要求衬线 |
| T03 | 三列等宽 feature card | 最常见 AI 痕迹 | 非对称网格/2列交错/时间轴/Bento | 用户明确要求"三列" |
| T04 | `<br>` 切断标题做花样 | "for thirty\<br\>*years.*" | 标题自然排版 | Editorial 大字排版且用户确认 |
| T05 | emoji 当图标 | 不像专业设计 | 用图标库（Phosphor/Radix/Tabler） | 用户要求活泼社交风 |
| T06 | 中文段落左右不齐 | AI 不检查中文排版 | 两端对齐或左对齐+合理断行 | 无 |
| T07 | 英文行宽 > 75ch | 阅读疲劳 | max-width: 65ch | 窄栏引用 |
| T08 | 标题中插入随机衬线词 | "we design **and** spatial" 用衬线强调 | 同字体 italic/bold | 无 |
| T09 | Italic 下延字母被裁切 | `y g j p q` 在 tight leading 中 | `leading-[1.1]` + `pb-1` | 无 |

### 7.B 色彩痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 | 突破条件 |
|---|------|-------------|---------|----------|
| C01 | AI 紫/蓝渐变 Hero | LLM 最爱的"科技感"伪装 | 用品牌色或单一中性色 | 品牌色本身是紫/蓝 |
| C02 | 暖米咖喱色系 (#F5F0EB) | "高级感"默认 | 换色系（冷奢/森林/蓝铜/陶土石板） | 用户明确喜欢暖色调 |
| C03 | 纯黑+纯白 (#000/#FFF) | 对比太生硬 | 用 #111 + #FAFAFA | 印刷材料（CMYK 100%K） |
| C04 | 同页两种灰色系 | 暖灰+冷灰混用 | 锁定一种灰系（Zinc/Slate/Stone） | 无 |
| C05 | 高饱和配色 | AI 默认鲜艳 | 饱和度 < 80%，B端 < 60% | 品牌色本身就是高饱和 |
| C06 | 多个 accent color | AI 喜欢给不同 section 不同颜色 | 锁定 1 个 accent，全页一致 | 品牌本身多色体系 |

### 7.C 文案痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 | 突破条件 |
|---|------|-------------|---------|----------|
| W01 | Em-dash `—` | #1 LLM 文案痕迹 | 换句号/逗号/拆句 | 无——零例外 |
| W02 | "Elevate/Seamless/Unleash" | AI 最爱营销词 | 用具体动词 | 无 |
| W03 | "Quietly trusted by" | 故作低调 | 直接写 "Trusted by" | 无 |
| W04 | "From the field / Field notes" | 故作工匠感 | 写 "Testimonials" / "Latest" | 无 |
| W05 | John Doe / Acme Corp | 默认假名 | 造真实感名称 | 无 |
| W06 | 99.99% 等完美数字 | 不真实 | 47.2%、83% 等不规整数据 | 品牌官方精确数据 |
| W07 | 擅改品牌数据 | 破坏品牌公信力 | 品牌数据不可改 | 无——铁律 |
| W08 | 版本号做装饰 | "v0.6.2-rc.1" 在 footer | 删掉 | 开发者文档 |
| W09 | Section 编号做眉毛 | "001 · Capabilities" | 用自然语言命名 section | 无 |
| W10 | 装饰性文字条 | "BRAND. MOTION. SPATIAL." 在 hero 底部 | 删掉或换成真实导航 | 无 |
| W11 | 滚动提示 | "Scroll to explore" + 鼠标滚轮图标 | 删掉 | 无——用户知道怎么滚动 |
| W12 | 城市/时间/天气条 | "LIS 14:23 · 18°C" | 删掉 | 品牌本身是全球化/地区服务 |
| W13 | 装饰性状态点 | 每个列表项前的彩色小圆点 | 删掉 | 真正表达语义状态时 |
| W14 | 微型元描述句 | 眉毛标签下的说明句 | 删掉——眉毛+标题+正文够了 | 无 |
| W15 | 通用步骤标签 | "Step 1 / Step 2 / Phase 01" | 用动词名词 "Install / Configure / Ship" | 无 |
| W16 | 图片上的药丸标签 | `<span>` 浮在照片上写 "Brand · 02" | 删掉或放图片下方 | 无 |
| W17 | 虚假照片引用 | "Field study no. 12 · Ines Caetano" | 删掉 | 真实摄影师+真实照片 |

### 7.D 布局痕迹

| # | 痕迹 | 为什么是 AI 惯性 | 修复方法 | 突破条件 |
|---|------|-------------|---------|----------|
| L01 | Hero 内 Trust Micro-Strip | Hero 里塞 logo 墙/trust 行 | Logo wall 移到 Hero 下方 | 无 |
| L02 | 左大标题+右小段落 | Split Header 浮动布局 | 垂直堆叠 | 右侧有交互元素 |
| L03 | 所有 section 用同一个 layout | AI 偷懒 | 每 2-3 section 变一次布局 | 无 |
| L04 | 连续 zigzag 交替 >2 段 | 左图右文→左文右图循环 | 第 3 段换全宽/堆叠/Bento | 无 |
| L05 | 所有 Bento 格子白底纯文本 | AI 默认 | 至少 2-3 格有图片/渐变/有色背景 | 无 |
| L06 | 手工 div 模拟产品截图 | #1 LLM 设计痕迹 | 用真实截图/生图/跳过 | 无 |
| L07 | Hero 底部装饰分割线 | crosshair/hairline 做装饰 | 删掉 | 真正组织内容时 |
| L08 | 旋转 90° 垂直文字 | Agency portfolio 模板感 | 删掉 | 明确的 agency/Awwwards 项目 |

### 7.E 画册特有痕迹

| # | 痕迹 | 为什么差 | 修复方法 | 突破条件 |
|---|------|---------|---------|----------|
| B01 | 满页文字无留白 | B端画册不是杂志但也不能填满 | 每页 ≥15% 留白 | 无 |
| B02 | 所有页面布局雷同 | AI 偷懒用同一个 grid | 每 2-3 页变换节奏 | 无 |
| B03 | 表格数据无对齐 | B端画册专业性体现 | 数字右对齐、文字左对齐、表头居中 | 无 |
| B04 | 页间品牌元素断层 | 页与页之间品牌感断裂 | 每页 ≥1 个品牌锚点（Logo/色条/图形） | 无 |
| B05 | 无出血位/裁切标记 | 打印品必备 | 补 3mm 出血位 | 数字版（PDF 屏幕阅读） |

### 7.F 代码/前端痕迹

| # | 痕迹 | 为什么差 | 修复方法 | 突破条件 |
|---|------|---------|---------|----------|
| F01 | `h-screen` 做 Hero | iOS Safari 地址栏跳变 | `min-h-[100dvh]` | 无 |
| F02 | `window.addEventListener('scroll')` | 每帧触发、卡顿 | Motion `useScroll()` / ScrollTrigger / IntersectionObserver | 无 |
| F03 | `useState` 追踪连续值（鼠标/滚动） | 每帧 re-render | `useMotionValue` + `useTransform` | 无 |
| F04 | 随意 z-index | z-50 / z-10 满天飞 | 定义 z-index 层级常量 | 无 |
| F05 | 动画无 reduced-motion fallback | 无障碍不合规 | 包裹 `prefers-reduced-motion` | 无 |
| F06 | 图片无 width/height | CLS 跳动 | 设置 width/height 或 aspect-ratio | 无 |
| F07 | 触摸目标 < 44×44px | 移动端不可用 | 最小 44×44 点击区 | 无 |
| F08 | 表单无 label | 无障碍不合规 | 每个 input 有可见 label | 无 |

### 7.G 邮件模板特有痕迹

| # | 痕迹 | 为什么差 | 修复方法 | 突破条件 |
|---|------|---------|---------|----------|
| E01 | 深蓝 Header + 灰底 Footer | 邮件模板 AI 默认 | 用品牌色系，Header 用品牌色 + 白色文字，Footer 用品牌浅色 | 品牌色本身就是深蓝 |
| E02 | Header 无品牌 Logo | 邮件无品牌识别 | 加品牌 Logo/wordmark，用品牌色 | 无 |
| E03 | CTA 按钮过小/无色 | 转化率低 | CTA 至少 44px 高度，品牌强调色，充足留白 | 无 |
| E04 | Footer 无退订链接 | 违反法规 | 加退订链接，小字标注 | 无 |
| E05 | 邮件中 em-dash 装饰 | LLM 文案痕迹 | 用句号/逗号/拆句 | 无——零例外 |
| E06 | 字体非 web-safe | 邮件客户端不渲染 | 用 Arial/Helvetica/Georgia 或 inline 嵌入 | 品牌字体可嵌入时 |
| E07 | 无移动端适配 | 移动端阅读体验差 | ≤600px 响应式，table 布局 collapse | 无 |
| E08 | Outlook 不兼容 | table 布局缺失 | 用 table-based layout，mso 条件注释 | 无 |

---

## 8. Redesign Protocol（重设计协议）

> **Misclassifying the mode 是重设计最大的失败来源。**
> 不要把渐进优化当推翻重来，也不要把推翻重来当渐进优化。

### 8.A 检测模式（第一个动作）

| 模式 | 定义 | 处理方式 |
|------|------|---------|
| **Greenfield** | 无现有站点，或用户明确要求全部推翻 | 从 Section 1 旋钮基线开始 |
| **Redesign-Preserve** | 现代化但保留品牌 | **先审计**，提取品牌 token，渐进修改 |
| **Redesign-Overhaul** | 新视觉语言 + 保留内容/IA | 视觉当 Greenfield；内容/IA 保留 |

**模棱两可时问一次：** *"应该保留现有品牌风格，还是从视觉上重新开始？"*

### 8.B 审计清单（Redesign 前**必须**做）

1. **品牌 token** — 主色/强调色/字体栈/Logo 处理/圆角
2. **信息架构** — 页面树、主导航、关键转化路径
3. **内容块** — 什么存在、什么在发挥作用、什么是填充物
4. **保留模式** — 标志性交互、可识别的 Hero、文案风格
5. **退役模式** — AI 痕迹、坏掉的布局、死链、通用图库、性能陷阱
6. **现有旋钮值** — 推断当前 DESIGN_VARIANCE / MOTION / DENSITY → 这是起点
7. **SEO 基线** — 排名页面、meta 标题、结构化数据、OG 卡片

### 8.C 保留规则（静默不通知）

| 保留项 | 原因 |
|--------|------|
| URL 结构 / 路由 slug | SEO + 用户记忆 |
| 主导航标签 | SEO + 肌肉记忆 |
| 表单字段名/顺序 | 分析追踪 + autofill |
| 品牌 Logo / wordmark | 品牌一致性 |
| 法律/同意/cookie 文案 | 合规 |

### 8.D 渐进杠杆（优先顺序）

| # | 杠杆 | 风险 | 收益 |
|---|------|------|------|
| 1 | Typography 刷新 | 低 | 高——最大视觉提升 |
| 2 | 间距 & 节奏 | 低 | 中——垂直节奏改善 |
| 3 | 色彩重新校准 | 中 | 中——去饱和、统一中性色 |
| 4 | 动效层 | 中 | 中——加旋钮对应的微交互 |
| 5 | Hero & 关键 section 重组 | 高 | 高——用 Section 4.3 词汇表 |
| 6 | 完整 block 替换 | 最高 | 最高——仅当现有 block 不可救药 |

### 8.E 决策树

- IA/内容/SEO 都 OK → **渐进优化**（杠杆 1-4），~70% 价值，~40% 风险
- 视觉债务是结构性的（坏 IA、无设计系统、移动端坏掉）→ **完整重设计** + 严格内容保留
- 品牌本身在变 → **Greenfield**

---

## 9. Pre-Flight 交付检查清单

> **二进制判断：每项只有 ✅ 或 ❌，没有"差不多"。**
> **如果任何一项 ❌ → 查 Section 7 对应条目的修复方法 → 修完再检查。**

### 9.A 通用检查（所有视觉类任务）

- [ ] 输出了 Design Read（Section 0.B 三行格式）
- [ ] 三个旋钮已设定且与推断信号一致
- [ ] 美学家族已选择（Section 2）
- [ ] 无 AI 紫/蓝渐变（或品牌色本身就是紫/蓝且用户确认）
- [ ] 无三列等宽 feature card（或用户明确要求）
- [ ] 无 emoji 当图标（或用户要求活泼风）
- [ ] 全页单 accent color，Color Consistency Lock
- [ ] 全页单灰色系（Zinc/Slate/Stone 择一）
- [ ] 饱和度符合旋钮设定（B端 < 60%）
- [ ] 字体不是 Inter（或品牌本身用 Inter / 用户明确要求）
- [ ] **零 em-dash（`—`）** 在所有可见文本中
- [ ] 8 个 section 至少 4 种不同 layout family
- [ ] Eyebrow 数量 ≤ ceil(sectionCount / 3)
- [ ] 无连续 >2 段 zigzag 交替布局
- [ ] 无 Split Header（左标题+右浮动段落）
- [ ] Shape Consistency Lock（单一圆角体系）
- [ ] Page Theme Lock（全页单一主题）

### 9.B Hero 专项

- [ ] Hero 文字元素 ≤ 4 个
- [ ] 标题 ≤ 2 行（桌面）
- [ ] 副文本 ≤ 20 词 / ≤ 4 行
- [ ] Top padding ≤ `pt-24`
- [ ] CTA 单行显示（桌面）
- [ ] Hero 有真实视觉元素（非纯文字+渐变）
- [ ] Logo wall / Trust strip 不在 Hero 内
- [ ] Hero 字号规划合理（>6 词不用 text-7xl）

### 9.C 生图专项

- [ ] ZONAL ANALYSIS 全部 Zone 有内容
- [ ] 面孔匹配目标受众地域
- [ ] 品牌色已融入（包装/标志/环境元素）
- [ ] 无幻觉文字/标签
- [ ] 无禁忌词（如 OEM 食品图无厨房/烹饪词）
- [ ] 光源参数已标注（方向/色温）
- [ ] 景深参数已标注（f/值）
- [ ] 不用 AI 完美感（加 workshop feel）

### 9.D 画册专项

- [ ] 每页 ≥ 15% 留白
- [ ] 数据表格对齐正确（数字右/文字左/表头居中）
- [ ] 每页 ≥ 1 个品牌锚点
- [ ] 相邻 3 页布局不雷同
- [ ] 打印尺寸/出血位正确（3mm）

### 9.E 官网/Web 专项

- [ ] 三端（PC/平板/手机）均通过检查
- [ ] 移动端有显式退化声明（单列、`w-full`、`px-4`）
- [ ] 品牌数据不可改（WhatsApp/邮箱/SKU/仓库/发货时效）
- [ ] `min-h-[100dvh]` 非 `h-screen`（Hero 防 iOS 跳变）
- [ ] 图片有 width/height 防 CLS
- [ ] 表单可访问（label 可见、错误靠近字段）
- [ ] 触摸目标 ≥ 44×44px（移动端）
- [ ] 导航单行 + 高度 ≤ 80px（桌面）
- [ ] 无 `window.addEventListener('scroll')`
- [ ] 动效有 `prefers-reduced-motion` fallback
- [ ] Dark mode token 已定义（如适用）
- [ ] Core Web Vitals 合理（LCP < 2.5s, INP < 200ms, CLS < 0.1）

### 9.F 邮件模板专项

- [ ] Header 有品牌 Logo/wordmark + 品牌色
- [ ] CTA 按钮 ≥ 44px 高度，品牌强调色，充足留白
- [ ] 字体为 web-safe（Arial/Helvetica/Georgia）或 inline 嵌入
- [ ] Footer 含退订链接 + 公司信息 + 品牌色底线
- [ ] 移动端响应式（≤600px 适配，table 布局 collapse）
- [ ] Outlook 兼容（table-based layout + mso 条件注释）
- [ ] 零 em-dash 在邮件文本中
- [ ] 无深蓝 Header + 灰底 Footer AI 默认（用品牌色系）

### 9.G 文案自审（交付前**必须**逐条重读）

- [ ] 每个可见字符串已重读
- [ ] 无语法破碎的短语（"free on its past"）
- [ ] 无指代不清的句子（"we plan to stay that way"）
- [ ] 无 AI 幻觉文案（强行文艺、假工匠感标签）
- [ ] 无通用步骤标签（"Step 1 / Phase 02"）
- [ ] 无装饰性照片引用（"Field study no. 12"）
- [ ] 无版本号装饰（"v0.6.2" 在 footer）
- [ ] 无滚动提示（"Scroll to explore"）
- [ ] 一个 CTA intent 不重复出现（"Contact us" + "Get in touch" = 重复）

---

## 10. 子 Agent 任务注入模板

派发子 Agent 时，把以下块嵌入任务指令末尾：

```markdown
## ⚠️ Design Constraints (NON-NEGOTIABLE)

### Process
- Output a 3-line Design Read (载体×受众×调性 / 美学家族 / 技术栈)
- Set 3 dials: DESIGN_VARIANCE / MOTION_INTENSITY / VISUAL_DENSITY
- Every layout/color/typography decision must be justified by these dials
- Run Pre-Flight checklist before delivery (Section 9)

### Visual Rules
- NO AI-purple gradients unless brand color IS purple.
- NO 3-column equal feature cards unless explicitly requested.
- NO emoji as icons. Use Phosphor/Radix/Tabler.
- NO Inter font unless brand uses it or user requested.
- NO em-dash (`—`) anywhere in visible text. Zero exceptions.
- Lock ONE accent color + ONE gray family for the entire page.

### Layout Rules
- Hero: max 4 text elements, headline ≤2 lines, subtext ≤20 words.
- Hero top padding ≤ pt-24. CTA single-line at desktop.
- Eyebrow count ≤ ceil(sectionCount / 3).
- No section layout repetition — 8 sections need ≥4 layout families.
- No >2 consecutive zigzag alternation.
- Mobile collapse explicit per section.

### Typography
- Body max-width: 65ch (EN) / 40em (ZH).
- Sans-serif default. Serif only when brand explicitly requires.
- Italic descender clearance: leading-[1.1] + pb-1 for y/g/j/p/q.

### Image Generation
- Southeast Asian faces for SEA-targeted content.
- NO visible text/labels in generated images.
- Natural workshop feel, not AI-perfect.
- Brand color [#hex] integrated into packaging/signage/environment.

### Data Integrity
- DO NOT alter brand data: [list specific items].
- Use organic numbers (47.2%, not 99.99%).
```

---

## 11. 与其他方法论的关系

| 本框架 | 其他方法论 | 触发顺序 |
|--------|-----------|---------|
| Section 0/1: 三旋钮 + Design Read | — | 最先执行 |
| Section 7.C/9: 生图检查 | `zonal-analysis-prompt-engineering.md` | 旋钮 → ZONAL ANALYSIS prompt → Section 9 检查 |
| Section 7.F/9.E: 代码反模式 | `llm-coding-anti-patterns.md` | 代码产出后交叉检查 |
| Section 9: Pre-Flight | `ui-ux-design-intelligence.md` | 互补（本框架偏"品味"，UI/UX 偏"规范"） |
| Section 8: Redesign Protocol | — | 任务是重设计时最先执行 |

---

## 12. 循环进化协议

每次视觉类任务完成后：
1. 发现新的 AI 痕迹 → 追加到 Section 7（标注 #、为什么、修复、突破条件）
2. 发现场景预设旋钮不准确 → 更新 Section 1 预设表
3. 发现 Pre-Flight 遗漏 → 补充到 Section 9
4. 发现新的突破条件 → 更新对应条目

---

## 更新日志

| 日期 | 变更 |
|------|------|
| 2026-06-15 | v3 重大升级：吸收原始 taste-skill v2 缺失章节（§3 架构约定、§4.4-4.8 材质/交互/文案/主题锁定、§5 动效规范+可执行代码骨架、§6 性能与无障碍护栏、§7.G 邮件模板痕迹目录、§9.F 邮件专项检查）。新增邮件 trigger 关键词。新增邮件模板 Design Read 示例。 |
| 2026-06-06 | v2 深度升级：Context-Aware Override 全覆盖、60+ 痕迹目录含修复路径、Typography/Layout/Color 硬规则、Redesign Protocol、Hero 规范、Brief→美学映射、Pre-Flight 60+ 条 |
| 2026-05-29 | v1 创建，基于 Taste-Skill 方法论 + 三旋钮模型 + 自建 AI 痕迹目录 |
