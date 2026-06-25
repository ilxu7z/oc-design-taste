---
name: design-taste
version: "9.0"
upstream: "https://github.com/ilxu7z/oc-design-taste"
synced: "2026-06-25T11:00:00+08:00"
description: >-
  设计品味校准框架 v9 · 鮱澄特化版 — 模块化架构 + A2UI 全量知识融合 + impeccable 融合增强 + GSAP 引擎深度融合。
  核心引擎：推理旋钮 + 纪律校准 + Domain 路由 + Register 判断 + AI Slop 检测。
  按需加载领域文件（domains/）、美学预设（profiles/）、组件库（libraries/）、知识层（knowledge/）。
  适配：UI/前端/页面/画册/官网/生图/样式/排版/布局/重新设计/邮件/email/template/EDM/Dashboard/SaaS/动效/animation/品牌/VI/Logo/配色。
---
# Design Taste v9 — 设计品味校准框架 · 鮱澄特化版
> **核心理念**：AI 输出的默认值 = 模板感、无品味。
> 但规则不是死的——每条都有**适用场景**和**突破条件**。
> 真正的品味 = 知道什么时候遵守规则，什么时候打破规则。
> **v9 架构**：本文件 = **推理引擎**。规则按需从 domain/profile/library/knowledge 文件加载，不塞全量。
> v9 增量：v8 impeccable 精华 + GSAP 引擎深度融合（三旋钮映射/决策树/反模式/插件映射/ScrollTrigger 8 反模式/性能铁律/Framework 集成）。
> 工作流：读信号 → 判断 Register → 选 Color Strategy → 调旋钮 → 路由 Domain → 写 Design Read → 按需加载 → 执行 → Pre-Flight → 交付。
---
## 0. Brief Inference（读前确认）
**⛔ 禁止拿到任务直接开干。** 先输出 Design Read。
### 0.A 读取信号
1. **载体类型** — 产品画册 / 官网首页 / 产品页 / 场景页 / 生图 / Logo / 海报 / 邮件模板 / Landing Page / 品牌手册 / B端SaaS后台 / Dashboard / 移动端 App
2. **任务模式** — 新建（Greenfield）/ 优化保留（Redesign-Preserve）/ 推翻重来（Redesign-Overhaul）
3. **受众** — 海外B端买家 / 国内经销商 / 终端消费者 / 双受众 / 招聘方 / B端销售/市场团队 / 开发者
4. **品牌调性关键词** — 用户用过的词："洁白干净""专业""实拍感""自然""工业""高端""premium""极简""Linear风""Apple风"
5. **已有品牌资产** — Logo、品牌色、已生成的图片、参考图、现有网站 URL
6. **约束条件** — 中英双语 / 多语言 / 三端响应式 / 移动优先 / 打印尺寸 / 字数限制 / 邮件客户端兼容
7. **静默约束** — 合规行业（食品/医疗/金融）、无障碍优先、信任优先（B端采购委员会）
### 0.A.1 Register 判断
读取信号后，先判断项目寄存器类型，影响后续所有决策默认值。
| 寄存器 | 判断标准 | 设计即产品？ | 设计服务于产品？ |
|--------|---------|-------------|----------------|
| **Brand** | 官网首页、Landing Page、品牌手册、画册、生图、Campaign 页、作品集 | ✅ 设计本身是交付物 | ❌ |
| **Product** | B端SaaS后台、Dashboard、App UI、工具面板、数据表格 | ❌ | ✅ 用户在执行任务 |
| **混合模式** | 官网中有产品展示区（Hero 用 Brand，内容区用 Product） | 部分 | 部分 |
**Brand 寄存器默认约束：**
- 标题用 `clamp()` 流体字号
- 字阶比 ≥1.25
- 非对称布局默认
- 每个项目必须执行字体选择流程（浏览真实字库，拒绝反射列表中的字体）
- Color Strategy 可达到 Committed / Full palette / Drenched
**Product 寄存器默认约束：**
- 固定 rem 字号（非流体）
- 字阶比 1.125-1.2
- 单字体族
- Restrained 配色默认
- 动效 150-250ms，不编排页面加载序列
**混合模式约束：**
- Hero/品牌区域用 Brand 规则
- 内容/工具区域用 Product 规则
- 字体可切换（Brand 区用展示字体，Product 区用无衬线）
### 0.A.2 Color Strategy 四步模型
选择配色策略前，先确定承诺度。来自 impeccable 的承诺轴模型：
| 策略 | 描述 | 适用场景 |
|------|------|---------|
| **Restrained（克制）** | 染色中性色 + 一个 accent ≤10% 面积 | Product 默认；品牌极简主义 |
| **Committed（承诺）** | 一个饱和色占据 30-60% 表面 | Brand 默认；身份驱动页面 |
| **Full palette（全调色板）** | 3-4 个命名角色，每个刻意使用 | 品牌 Campaign；产品数据可视化 |
| **Drenched（浸染）** | 表面本身就是颜色 | 品牌 Hero 页、Campaign 页 |
**命名真实参考再选策略。** 不命名参考的配色会退化为默认中性色。
### 0.B 输出一行 Design Read
格式：
```
「载体类型」×「受众」×「调性方向」
→ 美学家族：[选定的美学方向]
→ 技术栈：[执行手段]
→ Domain：[加载哪个 domain 文件]
→ Register：[Brand / Product / 混合]
→ Color Strategy：[Restrained / Committed / Full palette / Drenched]
```
示例：
```
B端产品画册 × 海外买家 × 洁白专业
→ 美学家族：Swiss modern sans-serif + 高对比度 + 克制配色
→ 技术栈：HTML/CSS 生成画册 PDF，Tailwind 排版
→ Domain：b2b-print
→ Register：Brand
→ Color Strategy：Restrained
OEM品牌官网 × 双受众 × 自然专业
→ 美学家族：食品工业风 + 实拍质感 + 温暖中性色
→ 技术栈：Next.js + Tailwind + Motion 动效
→ Domain：web-design
→ Register：混合（Hero Brand / 内容 Product）
→ Color Strategy：Committed
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
| em-dash 装饰文案 | LLM 文案痕迹 | **零例外——永远禁止** |
| 三列等宽卡片 testimonials + 圆点 | 最常见 AI 痕迹 | 用户明确要求 |
| 深度嵌套 div（4+ 层）| Agent UI 生成时 LLM 递归惯性 | 邻接表思维，语义组件 ≤3 层 |
| 组件内硬编码内容 | 数据/结构不分离 | props 传入或数据文件分离 |
| 工具结果直接 dump JSON | 懒人展示 | 格式化为可视 UI 卡片 |
| 自创通用组件名（InfoBox 等）| Agent 不走白名单 | 只用标准组件清单 |
---
## 1. 三旋钮推理模型
Design Read 之后，设定三个旋钮。**所有**布局/色彩/动效/排版决策由这三个值驱动。
### 默认基线
```
DESIGN_VARIANCE: 8（默认非对称，打破 AI 居中偏差）
MOTION_INTENSITY: 6（有微动效，但不电影级）
VISUAL_DENSITY: 4（标准密度，不拥挤不空旷）
```
**始终从基线开始，然后根据信号调整。** 不要凭空设定。
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
### 1.1 寄存器参数约束
旋钮设定后，根据 §0.A.1 的 Register 判断施加额外约束：
**Brand 寄存器：**
- 标题用 `clamp()` 流体字号，不固定 rem
- 字阶比 ≥1.25（小于此读作"未承诺"）
- 非对称布局默认（VARIANCE 基线从 6 起跳）
- 每个项目必须执行字体选择流程（浏览真实字库，拒绝反射列表中的字体）
- Color Strategy 可达到 Committed / Full palette / Drenched
**Product 寄存器：**
- 固定 rem 字号，不用 `clamp()`
- 字阶比 1.125-1.2
- 单字体族（无 display/body 配对）
- Restrained 配色默认
- 动效 150-250ms，不编排页面加载序列
**混合模式：**
- Hero 区域用 Brand 规则（流体字号、非对称、展示字体）
- 内容/工具区域用 Product 规则（固定 rem、单字体族、Restrained 配色）
### 场景预设（B端制造业特化）
| 使用场景 | VARIANCE | MOTION | DENSITY | → Domain |
|---------|----------|--------|---------|----------|
| **B端产品画册（打印）** | 3-5 | 1 | 4-6 | b2b-print |
| **OEM 官网首页** | 5-7 | 4-6 | 3-4 | web-design |
| **产品详情页** | 4-5 | 3-4 | 4-5 | web-design |
| **场景/解决方案页** | 6-7 | 4-6 | 3-4 | web-design |
| **品牌故事/About 页** | 5-6 | 3-5 | 2-3 | web-design |
| **Logo/品牌标识** | 3-5 | 1 | 1-2 | image-generation |
| **产品生图（Hero/场景）** | 3-4 | 1 | 2-3 | image-generation |
| **连锁餐饮痛点图** | 7-8 | 1 | 5-6 | image-generation |
| **品牌套件** | 3-5 | 1 | 2-3 | image-generation |
| **案例页/Case Study** | 5-6 | 3-5 | 4-5 | web-design |
| **B端SaaS后台** | 4-5 | 6-8 | 7-10 | dashboard |
| **Dashboard 概览页** | 3-4 | 6-8 | 7-10 | dashboard |
| **冷邮件模板** | 1-2 | 1 | 2-3 | email |
| **营销邮件模板** | 2-3 | 1 | 3-4 | email |
| **事务邮件（订单/报价）** | 1-2 | 1 | 4-5 | email |
| **Onboarding 邮件序列** | 2-3 | 1 | 3-4 | email |
| **移动端 Landing Page** | 5-7 | 4-6 | 3-5 | imagegen-frontend |
| **移动端 App UI** | 4-6 | 6-8 | 4-6 | imagegen-frontend |
| **前端设计生图** | 5-8 | 1 | 3-4 | imagegen-frontend |
| **Agent 生成 UI（Chat 卡片）** | 3-4 | 2-3 | 5-7 | agent-ui |
| **Agent Copilot 面板** | 3-4 | 3-4 | 5-7 | agent-ui |
| **Agent 工具结果可视化** | 4-5 | 3-4 | 6-8 | agent-ui |
| **Agent 生成完整页面** | 5-7 | 4-6 | 3-5 | agent-ui |
| **旧项目改造** | 维持原值 | +2 | 维持原值 | redesign |
### 旋钮值驱动设计决策
#### DESIGN_VARIANCE 档位
| 档位 | 布局特征 | 突破条件 |
|------|---------|---------|
| **1-3 可预测** | 严格 CSS Grid 12列等分、居中对齐、统一间距 | 用户明确要求"传统""专业""稳定感" |
| **4-7 偏移** | 非对称分栏、错位布局、图片不等比、左对齐标题 | 大多数 B端画册/官网的默认档位 |
| **8-10 非对称** | Masonry 瀑布流、极端留白、自由排版、杂志感 | 用户明确要求"创意""大胆""实验性" |
| **⚠️ 移动端覆盖** | 4-10 的非对称布局在 < 768px **必须**退化为严格单列 | 无条件强制 |
#### MOTION_INTENSITY 档位
| 档位 | 动效特征 | 突破条件 |
|------|---------|---------|
| **1-3 静态** | 无自动动画，仅 CSS `:hover` / `:active` 状态 | 画册/打印材料、邮件模板 |
| **4-7 流畅** | `transition 0.3s`、滚动入场、hover 微交互 | 官网、产品页——默认档位 |
| **8-10 编排** | GSAP ScrollTrigger scrub + pin + Timeline、视差、水平劫持滚动、SplitText/DrawSVG/MorphSVG | 用户明确要求"电影级""互动叙事" |
| **⚠️ 声明 = 实现** | 设定 >4 但页面是静态的 → 输出失败 | 反之，做不了动效就把旋钮降到 ≤3 |
| **⚠️ 必须有动机** | 每个动画必须一句话说清传达什么（层级/叙事/反馈/状态） | "看起来酷"不是理由 |
#### VISUAL_DENSITY 档位
| 档位 | 信息密度 | 突破条件 |
|------|---------|---------|
| **1-3 美术馆** | 大量留白（`py-32`~`py-48`）、每 section 一个核心信息 | 品牌官网 Hero、About 页 |
| **4-7 日常** | 标准间距（`py-16`~`py-24`）、标题+副标题+CTA | 大多数 B端页面的默认 |
| **8-10 驾驶舱** | 紧凑排列、细线分隔、等宽数字、无卡片容器 | 产品规格表、对比矩阵、dashboard |
---
## 1.5 AI Slop 动态检测（从 impeccable 移植）
§5 是静态痕迹目录。本节是**动态推理补充**——在 Design Read 阶段运行，提前拦截 AI 惯性。
### 一阶 Reflex Check
如果仅从 category 就能猜出 theme/palette → 重做 color strategy。
**示例：** "Fintech 官网" → 自动想到深蓝 + 金色 → 这是 AI 惯性。重做：写一句物理场景描述（谁、在哪、什么光、什么心情），从场景推导配色。
### 二阶 Reflex Check
如果从 category + anti-references 就能猜出美学家族 → 重做 scene sentence。
**示例：** "AI 工具官网，不是 SaaS 奶油色 → editorial-typographic" → 仍然惯性。再深一层：拒绝 editorial-magazine 美学（display serif + italic + drop caps + broadsheet grid），找真正差异化的方向。
### Reflex-reject 审美观饱和列表
以下美学家族已饱和。除非品牌定位明确要求（且不是"看起来高级"的借口），否则拒绝：
- **Editorial-typographic**：Display serif（常斜体）+ 小号 mono 标签 + 分隔线 + 单色克制。Klim 影响，杂志封面做派。到 2026 年每个 Stripe 相邻和 Notion 相邻品牌都落在此处。
- **Brutalist-utility**：纯黑/白 + 系统字体 + 极粗边框 + 无修饰。曾是反叛，现是模板。
- **Acid-maximalism**：霓虹色 + 扭曲字体 + 网格破坏。曾是实验，现是 Dribbble 默认。
**Reflex-reject 字体列表**（从 brand.md 移植，用于 Brand 寄存器字体选择流程）：
Fraunces · Newsreader · Lora · Crimson · Crimson Pro · Crimson Text · Playfair Display · Cormorant · Cormorant Garamond · Syne · IBM Plex Mono · IBM Plex Sans · IBM Plex Serif · Space Mono · Space Grotesk · Inter · DM Sans · DM Serif Display · DM Serif Text · Outfit · Plus Jakarta Sans · Instrument Sans · Instrument Serif
> 以上字体是训练数据默认值，造成字体单一文化。Brand 寄存器必须拒绝它们，浏览真实字库（Google Fonts、Pangram Pangram、Future Fonts、ABC Dinamo、Klim、Velvetyne）找到品牌作为物理对象的字体。
---
## 2. Domain 路由表
**Design Read 输出后，根据 Domain 字段加载对应文件。** 只加载需要的，不加载全部。
加载命令：`读取 {path}`
| Domain 字段 | 文件路径 | 触发信号 |
|-------------|---------|---------|
| `web-design` | `domains/web-design.md` | 官网、Landing Page、产品页、品牌故事、案例页 |
| `b2b-print` | `domains/b2b-print.md` | B端画册、品牌手册、规格卡、海报、PDF |
| `email` | `domains/email.md` | 邮件（冷/营销/事务/Onboarding） |
| `image-generation` | `domains/image-generation.md` | 生图（Hero/场景/痛点/品牌套件） |
| `imagegen-frontend` | `domains/imagegen-frontend.md` | 前端设计生图、Mobile UI 生图、图转码 |
| `redesign` | `domains/redesign.md` | 旧项目改造/Redesign |
| `dashboard` | `domains/dashboard.md` | Dashboard、B端SaaS 后台、数据展示 |
| `agent-ui` | `domains/agent-ui.md` | AI Agent 生成 UI、Chat 富卡片、工具结果可视化、Copilot 面板 |
### 美学预设加载
当需要特定美学方向时，加载对应 profile：
| Profile | 文件路径 | 适用场景 |
|---------|---------|---------|
| `editorial-luxury` | `profiles/editorial-luxury.md` | 编辑/奢侈品/高级感 |
| `dark-developer` | `profiles/dark-developer.md` | 暗色/开发者工具/DevTool |
| `industrial-brutalist` | `profiles/industrial-brutalist.md` | 工业粗野主义 |
| `clean-minimalist` | `profiles/clean-minimalist.md` | 极简/Notion/Linear 风 |
| `soft-premium` | `profiles/soft-premium.md` | 柔软高级感 |
| `brandkit` | `profiles/brandkit.md` | 品牌套件完整生成 |
| `stitch` | `profiles/stitch.md` | Google Stitch 适配 |
### 组件库/知识层按需加载
| 需要什么 | 读取什么 |
|---------|---------|
| **知识层导航索引（先读我）** | `knowledge/INDEX.md` |
| 高端组件模式参考 | `libraries/component-arsenal.md` |
| 动效代码骨架 | `libraries/motion-patterns.md` |
| GSAP 引擎深度融合（三旋钮映射/决策树/反模式/插件映射） | `knowledge/gsap-animation-engine.md` |
| 布局模式参考 | `libraries/layout-patterns.md` |
| 中文字体配对/排版细节 | `knowledge/font-pairings.md` |
| 色彩禁令/替代方案/品牌色策略 | `knowledge/color-science.md` |
| 设计系统速查/安装命令 | `knowledge/design-systems.md` |
| 理解 AI 懒惰行为根因 | `knowledge/ai-laziness.md` |
| Color Strategy 四步详细参数（色面积/OKLCH/暗色模式/Token层次） | `knowledge/color-science.md` §11 |
| 从代码反向提取设计 Token/组件/模式 | `knowledge/design-token-extraction.md` |
| 结构化设计批评（Nielsen 启发式/认知负荷/角色走查） | `knowledge/design-critique.md` |
| DESIGN.md 项目级设计上下文系统（格式/Token/场景描述法） | `knowledge/design-context.md` |
| 声明式 UI 理论（A2UI v1.0 协议/邻接表/安全模型/数据流） | `knowledge/declarative-ui.md` |
| A2UI v1.0 组件/函数/属性速查 + Catalog Schema严格规则 + 自定义Catalog指南 | `knowledge/a2ui-catalog-reference.md` |
| A2UI Agent SDK 指南（Prompt工程/验证/流式解析/传输集成） | `knowledge/a2ui-agent-sdk.md` |
| A2UI × MCP 三种集成模式（over MCP / in MCP Apps / in A2UI） | `knowledge/a2ui-mcp-integration.md` |
| A2UI 主题系统（CSS Variables/Semantic Hints/版本迁移） | `knowledge/a2ui-theming.md` |
### 操作模式（非 Domain，按需触发）
| 操作 | 知识文件 | 触发信号 |
|------|---------|---------|
| **Critique（设计批评）** | `knowledge/design-critique.md` | 用户说"帮我看看这个设计"/"审查一下"/子Agent产出验收 |
| **Extract（Token提取）** | `knowledge/design-token-extraction.md` | 从现有代码反向提取设计系统 |
| **Design Context（上下文持久化）** | `knowledge/design-context.md` | 新项目启动/设计系统确立/重新设计前 |
---
## 3. 默认架构约定
当 Design Read 没有选择特定设计系统时，使用以下默认值。
### 3.A 技术栈
| 项目类型 | 默认栈 |
|---------|--------|
| Web 项目 | Next.js + Tailwind v4 + Motion（`motion/react`） |
| 静态页面 | Tailwind v4 + 原生 CSS |
| 邮件模板 | table-based HTML + inline CSS（邮件客户端兼容） |
| 画册/PDF | HTML/CSS → PDF（Puppeteer/Playwright） |
| B端SaaS后台 | Preact/React + CSS Variables + 自建组件库 |
### 3.B RSC 安全规则（Next.js）
**⚠️ 从原版 taste-skill 补入，v5 缺失的关键工程指导。**
- Global state（Zustand、Context、Motion）**只在 Client Components 中工作**
- 如果 Domain 文件包含动效/交互规则，对应 UI 组件**必须**提取为独立叶子组件，顶部标记 `'use client'`
- Server Components **只能**渲染静态布局
- Providers（Zustand、Theme 等）包裹在 `'use client'` wrapper 中，嵌在 layout.tsx 的 children 外层
### 3.C 状态管理
| 场景 | 方案 |
|------|------|
| 局部 UI 状态 | `useState` / `useReducer` |
| 深层 prop drilling | Zustand / Jotai / React Context |
| 鼠标/滚动连续值 | Motion `useMotionValue` + `useTransform`（**禁止 useState**） |
**❌ 禁止：** `useState` 追踪鼠标位置、滚动进度、物理交互——每帧 re-render 导致性能崩溃。
### 3.D 图标库优先级
| 优先级 | 库 | 备注 |
|--------|-----|------|
| 1 | `@phosphor-icons/react` | 默认首选 |
| 2 | `hugeicons-react` | 备选 |
| 3 | `@radix-ui/react-icons` | 轻量 |
| 4 | `@tabler/icons-react` | 备选 |
| ❌ 谨慎 | `lucide-react` | 仅用户明确要求或项目已有 |
**铁律：** 一个项目只用一种图标库，统一 `strokeWidth`。**禁止手写 SVG 图标路径。**
### 3.E Emoji 政策
默认禁止在代码和可见文本中使用 emoji。用图标库替代。
**突破条件：** 用户明确要求活泼/社交/聊天风格，且使用克制。
### 3.F 响应式与布局机制
- 标准断点：`sm 640` / `md 768` / `lg 1024` / `xl 1280` / `2xl 1536`
- 页面容器：`max-w-[1400px] mx-auto` 或 `max-w-7xl`
- **❌ 禁止 `h-screen`** → `min-h-[100dvh]`（防 iOS Safari 跳变）
- **❌ 禁止 flex 百分比数学** → CSS Grid
- **⚠️ 移动端**：所有多列布局在 < 768px **必须**退化为单列
### 3.G 依赖验证（强制）
引入任何第三方库前，先检查 `package.json`。缺少则先输出安装命令。**永远不要假设库已存在。**
### 3.H Tailwind 版本守卫
- **v3 项目**：不要用 v4 语法（如 `@import "tailwindcss"`）
- **v4 项目**：PostCSS 用 `@tailwindcss/postcss` 或 Vite 插件，**不要**用 `tailwindcss` 插件
- 先检查 `package.json` 确认版本
---
## 4. 核心设计纪律
以下规则**始终生效**，不依赖 Domain 文件加载。这是最低底线。
### 4.A 排版纪律
- **Sans-Serif 默认。** "有设计=用衬线" 是 AI 最大的排版幻觉
- **标题不尖叫。** 用字重和颜色建立层级，不靠巨大字号
- **中文行宽 ≤40em，两端对齐 `text-align: justify`**
- **Em-Dash 永远禁止。** 零例外
- **正文 max-width 65ch（英文）/ ≤40em（中文）**
- **数字用等宽字体**（`font-variant-numeric: tabular-nums`）
- **Hero 标题字号上限 ≤6rem（~96px）**——超过此值页面在喊叫而非设计（impeccable 参数，比原 5rem 更精确）
- **Display tracking floor ≥ -0.04em**——再紧字母就粘连了
- **`text-wrap: balance` 用于 h1-h3**，使每行长度均匀；**`text-wrap: pretty`** 用于长散文减少孤行
- **字体配对规则：** 相似字体不配对（两个几何无衬线、两个人文无衬线）。在对比轴上配对（serif + sans / geometric + humanist）或单家族多字重
### 4.B 色彩纪律
- **最多 1 个 accent 色，饱和度 < 80%**
- **AI 紫/蓝渐变永远禁止**（除非品牌色本身如此 + 用户确认）
- **禁止纯黑 `#000000`** → 用 Off-Black / Zinc-950 / Charcoal
- **不混冷暖灰** —— 一页之内只用一种灰调
- **阴影 tint to background hue** —— 不用纯黑透明阴影
- **新项目推荐 OKLCH 色彩空间**（但 DESIGN.md 用 hex sRGB——兼容 Stitch linter）
- **Anti-cream 禁令：** OKLCH L 0.84-0.97, C<0.06, hue 40-100 的暖白默认值是 AI 2026 惯性。不要将"温暖"翻译为近白暖色背景。选：(a) 饱和品牌色作为主体色 (b) 色度 0 的真正 off-white (c) 明显属于品牌的深色中间调中性色
- **Tinted neutrals chroma 范围：** 0.005-0.015，向品牌色 hue 方向，不默认向暖色倾斜
- **对比度强制：** 正文 ≥4.5:1、大文本（≥18px 或粗体 ≥14px）≥3:1、placeholder ≥4.5:1
- **主题选择物理场景法：** 写一句物理场景描述（谁、在哪、什么光、什么心情）。如果句子不强迫答案，说明不够具体，加细节直到答案明确
- **详细色彩禁令和替代方案** → 加载 `knowledge/color-science.md`
### 4.C 布局纪律
- **VARIANCE > 4 时，居中 Hero 永远禁止**
- **三列等宽卡片永远禁止**（除非用户明确要求）
- **Zigzag 上限**：连续不超过 2 组，第 3 组换布局
- **导航单行**：不超过 1 行水平导航
- **卡片仅用于层级**：当 elevation 不传达层级时，用 `border-t` / `divide-y` / 留白替代
- **Bento 格子数**：2-5 格，不超过 6 格
- **Page Theme Lock**：一页之内只用一种背景调
- **Flex vs Grid 规则：** 1D 用 Flex，2D 用 Grid，不默认 Grid 当 `flex-wrap` 更简单
- **响应式无断点 Grid：** `repeat(auto-fit, minmax(280px, 1fr))`
- **z-index 语义层级：** dropdown → sticky → modal-backdrop → modal → toast → tooltip。禁止任意值 999/9999
- **Cards 是懒惰答案：** 仅当真正是最佳交互时使用。嵌套卡片永远错误
### 4.D 视觉资产纪律
- **资产优先级：** 品牌实际图片 > 生图工具 > `picsum.photos/seed/{keyword}/{w}/{h}` > 明确标注占位
- **⚠️ 生图特有规则** → 加载 `domains/image-generation.md`
- **禁止 Unsplash 随机链接**
- **禁止 Broken Image** → 每张图片都用 `picsum` seed 或真实 URL
- **面孔/地名真实性**：不用 fake 人名、fake 地名
- **Logo Wall**：5 个以上 logo 才做，否则省略
### 4.E 文案自审
- **❌ 禁止 AI 陈词：** Elevate、Seamless、Unleash、Next-Gen、Game-changer、Delve、Tapestry
- **❌ 禁止假数字：** 99.99%、50%、$100.00 → 用有机数据：47.2%、$99.00、+1 (312) 847-1928
- **❌ 禁止通用名：** John Doe、Jane Smith、Acme Corp、Nexus、SmartFlow
- **❌ 禁止占位文本：** Lorem Ipsum、TO DO、Add content here
- **❌ 禁止全大写标题：** 用 sentence case
- **❌ 禁止感叹号成功消息：** "Saved!" 不是 "Saved successfully! 🎉"
- **用主动语态，不用被动语态**
### 4.F Agent UI 安全纪律
> Agent 直接生成 UI 代码时的额外安全约束。完整规范见 `domains/agent-ui.md` §5。
| 规则 | 说明 |
|------|------|
| **❌ 永远禁止 `dangerouslySetInnerHTML`** | XSS 注入风险 |
| **❌ 永远禁止 `eval()` / `innerHTML`** | 代码注入 |
| **❌ 永远禁止 inline event handler 字符串** | 用 JSX onClick |
| **❌ 永远禁止动态拼接 src URL** | 图片/脚本来源必须可信 |
| **❌ 永远禁止外部 script 引入** | 供应链攻击 |
| **✅ div 嵌套 ≤ 3 层** | 超过则语义化提取组件 |
| **✅ 数据与结构分离** | 硬编码内容必须提取为 props/data |
| **✅ 组件白名单思维** | 只用标准组件，不发明新组件 |
| **✅ 邻接表思维** | 复杂 UI 先列清单再逐个生成 |
### 4.G 交互状态纪律（升级为八状态）
| 状态 | 要求 |
|------|------|
| **Default** | 基础样式 |
| **Hover** | 背景色/缩放/位移微变，禁止无 hover 反馈的按钮 |
| **Focus** | 可见的 focus ring，用 `:focus-visible`，禁止 `outline: none` 无替代 |
| **Active** | `scale(0.98)` 或 `translateY(1px)`，模拟物理按压感 |
| **Disabled** | 降低透明度，无指针事件 |
| **Loading** | 骨架屏匹配布局尺寸，禁止通用圆形 spinner |
| **Error** | 清晰的内联错误信息，禁止 `window.alert()` |
| **Success** | 绿色勾选/确认，禁止感叹号狂欢 |
**Focus Ring 正确做法：** `button:focus { outline: none; }` + `button:focus-visible { outline: 2px solid var(--color-accent); outline-offset: 2px; }`
**Popover API 优先于自定义 dropdown：** `<button popovertarget="menu">打开</button><div id="menu" popover>` — 原生 light-dismiss、正确 stacking、无障碍
**CSS Anchor Positioning（Chrome 125+）：** 用 `position-anchor` + `@position-try` 实现无 JS 定位翻转
**Portal/Teleport：** React `createPortal` / Vue `<Teleport to="body">` — 避免 overflow 裁剪
**Undo 优于 Confirm：** 先移除→显示 undo toast→toast 过期后真删除。Destructive actions 用 Undo > Confirm 原则。确认对话框仅用于真正不可逆操作（账号删除）、高成本操作或批量操作。
**其他交互纪律：**
- Label 在 input 上方，不在内部
- CTA 不换行，intent 明确，对比度充足
- 死链接：禁止 `href="#"`，要么链接到真实地址，要么视觉禁用
- 骨架屏 > 通用 spinner（预览内容形状，感觉更快）
- 乐观更新：低风险操作（点赞、关注）立即显示成功，失败回滚
### 4.H Motion 深度规范（从 impeccable animate.md 移植 + GSAP 融合）
#### MOTION_INTENSITY → 引擎选择
| MOTION 档位 | 引擎 | 说明 |
|-------------|------|------|
| 1-3 | CSS `transition` | hover/focus/active，无需 JS |
| 4-5 | Motion（`motion/react`） | spring physics、whileInView、layout |
| 6-7 | GSAP（轻量） | ScrollTrigger toggleActions / batch() |
| 8-10 | GSAP（全量） | ScrollTrigger scrub + pin + Timeline 编排 |

MOTION ≥6 时加载 `knowledge/gsap-animation-engine.md` 获取完整映射和陷阱规避。
#### 时序规则（100/300/500 规则）
| 时长 | 用途 | 示例 |
|------|------|------|
| **100-150ms** | 即时反馈 | 按钮按压、切换、颜色变化 |
| **200-300ms** | 状态变化 | 菜单打开、tooltip、hover 状态 |
| **300-500ms** | 布局变化 | 手风琴、modal、drawer |
| **500-800ms** | 入场动画 | 页面加载、Hero 揭示 |
#### Easing 曲线
推荐：`ease-out-quart` `cubic-bezier(0.25, 1, 0.5, 1)` / `ease-out-quint` / `ease-out-expo`
GSAP 映射：`"power3.out"`（≈quart）/ `"power4.out"`（≈quint）/ `"expo.out"`（≈expo）
禁止：bounce / elastic / `"none"`（交互反馈时）；`"none"`仅用于 ScrollTrigger scrub 绑定
#### Motion Materials Palette
- **Transform/opacity：** 移动、按压反馈、简单揭示
- **Blur/filter/backdrop-filter：** 焦点拉远、深度、玻璃效果
- **Clip-path/mask：** 擦除、揭示、编辑裁剪
- **Shadow/glow/color filters：** 能量、affordance、焦点
- **Grid-template-rows/FLIP：** 展开布局，不直接动画 `height`
#### 80ms 感知性能阈值
< ~80ms 感觉瞬间（）。目标此阈值用于微交互。
#### 入场 > 退场
退场用入场时长的 75%。。
#### Stagger 规则
列表项 stagger 是合理的（10 items × 50ms = 500ms cap）。整 section fade-on-scroll 是不合法的。
#### 禁止模式
- 禁止 bounce / elastic 曲线
- 禁止随意动画布局属性（`width`、`height`、`top`、`left`、margins）
- 禁止 >500ms 的反馈动画
- 禁止无动机的动画
- 禁止忽略 `prefers-reduced-motion`
#### 无障碍
`@media (prefers-reduced-motion: reduce)` 将所有动画/过渡设为 0.01ms。**降级是强制性的，非可选。**
### 4.I Absolute Bans（从 impeccable 移植）
以下模式**匹配即拒绝**。如果即将写出任何一项，用不同结构重写元素。
| # | 禁令 | 为什么 | 替代方案 |
|---|------|--------|---------|
| B01 | **Side-stripe 边框** — border-left/right >1px 作为 accent | 永远不是有意设计 | 全边框 / 背景色 / 数字图标 |
| B02 | **Gradient text** — `background-clip:text` + gradient | 装饰性，无意义 | 纯色 + 字重/字号 |
| B03 | **Glassmorphism 作为默认** — 装饰性模糊和玻璃卡片 | 除非稀有且有意义 | 不用 |
| B04 | **Hero-metric 模板** — 大数字+小标签+统计+渐变 | SaaS 陈词 | 用真实叙事结构 |
| B05 | **全 section 小眉毛** — 全大写+宽 tracking 的 "ABOUT" "PROCESS" | AI 语法（55-95% 生成都有） | 一个可以做，每个都做是 AI 语法 |
| B06 | **编号 section markers** — 01/02/03 在每个 section 上方 | 默认脚手架 | 仅当 section 真的是有序序列 |
| B07 | **文字溢出容器** — 长标题+大 clamp+窄网格 | 设计缺陷 | 测试每个断点的标题换行 |
| B08 | **Ghost-card** — 1px border + 16px+ blur shadow 同元素 | 不要两个都用 | 选一个（实线边框或 ≤8px shadow） |
| B09 | **Over-round** — border-radius 32px+ 在卡片 | 过度圆角 | 上限 12-16px（标签/按钮可用 pill） |
| B10 | **手绘 SVG 插画** — sketch/doodle/wavy 类名，feTurbulence 滤镜 | 业余感 | 用真实素材或不用 |
| B11 | **Meta-criticism 文案** — 先命名概念再加讽刺修饰 | 戏剧化 | 直接做具体声明 |
| B12 | **repeating-linear-gradient 条纹背景** — 纯装饰 | 代码生成装饰 | 不用 |
| B13 | **Monospace 作为"技术感"简写** — 品牌非技术时 | 穿戏服 | 用品牌合适的字体 |
---
## 5. AI 痕迹目录
所有设计输出必须通过此痕迹检测。每条有编号方便引用，附修复方向和突破条件。
**Context-Aware 版**：不是绝对禁止，是要求 Agent 知道为什么 AI 会这么做，以及什么时候可以有例外。
### 5.A 排版痕迹（T01-T10）
| # | 痕迹 | 为什么 AI 这么做 | 修复 | 突破条件 |
|---|------|-----------------|------|---------|
| T01 | H1 巨大（>5rem）+ 居中 | AI 把"标题"等同于"重要=大号" | 控制字号 ≤`clamp(3rem,5vw,5rem)`，用字重和颜色建层级 | Editorial manifesto 风格，用户确认 |
| T02 | 行数 >4 行的大段 H1 | 容器太窄，文字被迫换行 | 加宽容器 max-w-5xl/6xl，缩短文案到 2-3 行 | 无 |
| T03 | Inter + slate-900 全站 | 安全牌，不犯错 | 换 Geist/Outfit/Satoshi + off-black | 用户明确要求或项目已有 Inter |
| T04 | 所有标题全大写 | AI 误以为"正式=大写" | 用 sentence case 或小写 italics | 用户明确要求全大写风格 |
| T05 | 6 行正文段落 | 正文容器不够宽 | max-width 65ch（英文）/ ≤40em（中文），line-height 1.6 | 无 |
| T06 | 正文用比例字体显示数据 | AI 不区分数字排版 | 数据用 monospace + tabular-nums | 仅 1-2 个孤立数字可例外 |
| T07 | 随意使用 Serif 当"创意感" | "有设计=用衬线"幻觉 | Sans-Serif 默认，Serif 需品牌明确要求 | Editorial/luxury + 品牌确认 |
| T08 | Letter-spacing 不调 | AI 用默认 | 大标题收紧 -0.02~-0.04em，小标签加宽 0.05em | 无 |
| T09 | Em-dash 装饰文案 | AI 文案痕迹 | 永远禁止 | **零例外** |
| T10 | Hero 字号 >6rem | impeccable 参数 | 上限 ≤6rem（~96px） | 无 |
### 5.B 色彩痕迹（C01-C08）
| # | 痕迹 | 修复 | 突破条件 |
|---|------|------|---------|
| C01 | AI 紫/蓝渐变 Hero | 用品牌色或中性基底 | 品牌色是紫/蓝 + 用户确认 |
| C02 | 纯黑 #000000 | Off-Black / Zinc-950 / Charcoal | 无 |
| C03 | 饱和度 >80% 的 accent | 降到 <80%，或加灰混合 | 品牌标准色本身如此 + 确认 |
| C04 | 暖冷灰混用 | 一页之内只用一种灰调 | 无 |
| C05 | 纯黑透明阴影 | Tint to background hue | 无 |
| C06 | 多于 1 个 accent 色 | 只保留 1 个主 accent | 无 |
| C07 | 奶油/沙色背景（OKLCH 暖白 AI 惯性） | 用真正 off-white 或饱和品牌色 | 品牌本身就是暖色调 + 用户确认 |
| C08 | Gradient text | 纯色 + 字重/字号 | 无 |
### 5.C 布局痕迹（L01-L15）
| # | 痕迹 | 修复 | 突破条件 |
|---|------|------|---------|
| L01 | 三列等宽 feature card | 2 列 Zigzag / 不对称网格 / 水平滚动 | 用户明确要求 |
| L02 | 所有 section 全居中对称 | 错位、偏移、左对齐标题 | 传统 B 端信任优先场景 |
| L03 | 连续 >2 组 Zigzag | 第 3 组换布局 | 无 |
| L04 | 卡片无处不在 | 卡片仅用于层级，否则用 border-t/留白 | Dashboard 高密度 |
| L05 | `height: 100vh` | `min-height: 100dvh` | 无 |
| L06 | Flex 百分比数学 | CSS Grid | 无 |
| L07 | Bento 空洞格子 | `grid-auto-flow: dense` + 验证 span 数学 | 无 |
| L08 | 无 max-width 容器 | 加 `max-w-[1400px] mx-auto` | 全屏背景特例 |
| L09 | 移动端横向溢出 | 所有非对称在 <768px 退化单列 | 无 |
| L10 | 假产品/假公司名 | 用有机真实数据 | 无 |
| L11 | Ghost-card（border + 大 shadow 同元素） | 选一个（实线边框或 ≤8px shadow） | 无 |
| L12 | 每 section 小眉毛（全大写+宽 tracking） | 一个可以做，每个都做是 AI 语法 | 作为命名的品牌系统 |
| L13 | 编号 section markers（01/02/03） | 仅当 section 是有序序列 | 无 |
| L14 | Side-stripe accent 边框 | 全边框/背景色/数字图标 | 无 |
| L15 | 手绘 SVG 插画 | 用真实素材或不用 | 无 |
### 5.D 文案痕迹（W01-W10）
| # | 痕迹 | 修复 |
|---|------|------|
| W01 | Elevate / Seamless / Unleash / Next-Gen / Game-changer / Delve | 用具体动词 |
| W02 | 99.99% / 50% / $100.00 | 有机数据：47.2%、$99.00 |
| W03 | John Doe / Jane Smith / Acme Corp / Nexus / SmartFlow | 造 believable 名 |
| W04 | Lorem Ipsum / Add content here / TO DO | 写真实文案 |
| W05 | 全大写标题 | Sentence case |
| W06 | 感叹号成功消息 | 去掉感叹号和 emoji |
| W07 | 被动语态 | 主动语态 |
| W08 | "Oops!" 错误消息 | 直接说"连接失败，请重试" |
| W09 | 所有日期相同 | 随机化日期 |
| W10 | 同一头像多人 | 每人唯一 avatar |
---
## 6. Pre-Flight Check（交付前最终检查）
**所有设计输出交付前，必须逐项检查。** 不合格自动打回。
### 6.A 基础检查
- [ ] Design Read 已声明并执行
- [ ] Register 已判断（Brand / Product / 混合）
- [ ] Color Strategy 已选择（Restrained / Committed / Full palette / Drenched）
- [ ] 三旋钮已设定并有依据
- [ ] 对应 Domain 文件已加载
- [ ] 技术栈与项目一致
- [ ] 依赖已验证（package.json 存在）
### 6.B 排版检查
- [ ] H1 ≤3 行，字号 ≤`clamp(3rem,5vw,5rem)`（Hero ≤6rem）
- [ ] 正文 max-width 65ch / ≤40em
- [ ] 无 Em-dash
- [ ] 数字用 tabular-nums
- [ ] 中文行宽 ≤40em，两端对齐
- [ ] Display tracking ≥ -0.04em
- [ ] h1-h3 用 `text-wrap: balance`
- [ ] 字体配对在对比轴上（相似字体不配对）
### 6.C 布局检查
- [ ] VARIANCE >4 时无居中 Hero
- [ ] 无三列等宽卡片
- [ ] Zigzag 不超过 2 组
- [ ] Bento 无空洞格子（`grid-flow-dense`）
- [ ] 移动端单列退化
- [ ] `min-h-[100dvh]` 替代 `h-screen`
- [ ] Flex for 1D, Grid for 2D
- [ ] z-index 语义层级（非 999/9999）
- [ ] 无 Ghost-card（border + shadow 不同时用）
- [ ] 无 Side-stripe 边框
- [ ] 无 Over-round（卡片 border-radius ≤16px）
### 6.D 视觉资产检查
- [ ] 无 Broken Image
- [ ] 无 Unsplash 随机链接
- [ ] 生图无 AI 痕迹（完美感/面孔不匹配/空洞背景/幻觉文字/无方向光源）
- [ ] Logo Wall ≥5 个才出现
- [ ] 品牌实际图片优先
### 6.E 内容检查
- [ ] 无 AI 陈词（Elevate/Seamless/Unleash…）
- [ ] 无假数字/假名/假公司
- [ ] 无 Lorem Ipsum
- [ ] 无占位文本
- [ ] 所有按钮有真实链接
### 6.F 动效检查（MOTION >3 时）
- [ ] 有 hover 状态
- [ ] 有 active 按压反馈
- [ ] 有 transition（200-300ms）
- [ ] 动画只用 transform + opacity（或确认高级素材平滑）
- [ ] 无 `window.addEventListener('scroll')`
- [ ] Ease 曲线用 quart/quint/expo（无 bounce/elastic）
- [ ] 时序符合 100/300/500 规则
- [ ] `prefers-reduced-motion` 已实现
- [ ] 入场 > 退场（退场用 75% 时长）

### 6.F2 GSAP 专项检查（MOTION ≥6 时）
- [ ] MOTION ≥6 已加载 `knowledge/gsap-animation-engine.md`
- [ ] GSAP 已注册：`gsap.registerPlugin(ScrollTrigger)` 等
- [ ] 不存在 ST01-ST08 反模式（见 gsap-animation-engine §4）
- [ ] ScrollTrigger 在顶层 Timeline/Tween 上，不在子 tween 内
- [ ] `scrub` 和 `toggleActions` 未同时使用
- [ ] `containerAnimation` 使用 `ease: "none"`
- [ ] `markers: false`（无调试标记泄漏）
- [ ] `gsap.context()` 或 `useGSAP()` + scope 清理已设置
- [ ] `autoAlpha` 替代 `opacity`（除非需要保持可点击）
- [ ] Framework 集成模式正确（React: useGSAP / Vue: onMounted+ctx.revert / Svelte: onMount return）
### 6.G 交互检查
- [ ] 八状态齐全（Default/Hover/Focus/Active/Disabled/Loading/Error/Success）
- [ ] Focus ring 用 `:focus-visible`，无 `outline: none` 无替代
- [ ] Popover API 优先于自定义 dropdown
- [ ] Undo > Confirm 用于 destructive actions
- [ ] 骨架屏匹配布局（非通用 spinner）
### 6.H Agent UI 安全检查（agent-ui Domain 时强制）
- [ ] 无 `dangerouslySetInnerHTML`
- [ ] 无 `eval()` / `innerHTML`
- [ ] 无 inline event handler 字符串
- [ ] div 嵌套 ≤ 3 层
- [ ] 组件白名单合规（无自创通用组件）
- [ ] 数据与结构分离（无硬编码内容在组件内）
- [ ] 工具结果已格式化（非原始 JSON dump）
- [ ] 所有链接 href 安全（无 `javascript:`）
- [ ] 所有图片有 alt + 尺寸占位
### 6.I 色彩检查
- [ ] OKLCH 用于新项目（DESIGN.md 用 hex sRGB）
- [ ] Anti-cream：无 OKLCH 暖白 AI 惯性背景
- [ ] Tinted neutrals chroma 0.005-0.015 向品牌色 hue
- [ ] 对比度：正文 ≥4.5:1、大文本 ≥3:1、placeholder ≥4.5:1
- [ ] 主题选择基于物理场景描述
### 6.J 性能与无障碍
- [ ] Grain/noise 只在 fixed 伪元素
- [ ] z-index 有系统化层级
- [ ] 无障碍：focus ring、alt text、语义 HTML
- [ ] `prefers-reduced-motion` 降级
### 6.L 上下文文件检查（有 DESIGN.md/PRODUCT.md 时）
- [ ] PRODUCT.md 已读取（品牌战略/反参考/受众）
- [ ] DESIGN.md 已读取（Token/组件规范/命名规则）
- [ ] DESIGN.md frontmatter token 与 prose 一致
- [ ] 不凭空编造 token 值
### 6.M 生产检查
- [ ] 无死链接（`href="#"`）
- [ ] 无 `// TODO` / `// ...` 省略注释
- [ ] 无未使用的 import
- [ ] 无硬编码像素宽度
- [ ] 无 `console.log`
---
## 7. 全量输出纪律
从 output-skill 核心规则内联。每次任务都是生产级——部分输出 = 破损输出。
### 7.A 禁止模式
**代码中：** `// ...`、`// rest of code`、`// TODO`、`/* ... */`、裸 `...` 省略
**文案中：** "Let me know if you want me to continue"、"for brevity"、"similarly for the remaining"、"and so on"
**结构性偷懒：** 输出骨架当完整实现、只写首尾跳过中间、一个示例+描述代替实际代码
### 7.B 执行流程
1. **Scope** — 数清楚要交付几个东西（文件/函数/区块），锁定数字
2. **Build** — 逐个完整生成，不写部分草稿
3. **Cross-check** — 交付前对照 Scope 数字，缺了就补
### 7.C 长输出处理
接近 token 限制时：
- 不压缩剩余内容
- 写到干净断点（函数末尾/文件末尾/节末尾）
- 结尾标注：`[暂停 — X/Y 完成。发送"继续"从下一节恢复]`
- "继续"时精确接续，不重复
---
## 8. Out of Scope（不适用的场景）
本 skill 不处理以下场景，遇到时应直接声明并建议替代方案：
1. **后端/数据库/DevOps** — 非设计领域
2. **内容策略/SEO 纯文字** — 无视觉输出
3. **动效原型工具（Framer/Lottie）** — 非 Web 实现
4. **Print 印刷文件（InDesign/Illustrator）** — 用 `domains/b2b-print.md` 的 PDF 方案
5. **3D/WebGL 项目** — 超出 scope，建议 Three.js 专家
6. **游戏 UI** — 超出 scope
---
## 9. OpenClaw 工具使用指南

本 skill 在 OpenClaw 环境中运行时，使用以下工具映射：

| 任务 | 工具 | 说明 |
|------|------|------|
| 加载知识文件 | `read` | 按需读取 domains/libraries/knowledge/profiles 中的 .md 文件 |
| 生成代码/HTML | `write` | 写入设计产出的代码文件 |
| 生成图片 | `image` 或 `exec` | 调用生图 API（Kuai/SiliconFlow 等） |
| 分析参考图 | `image` | 用视觉模型分析参考图片的设计特征 |
| 检查已有设计 | `read` | 读取项目中的现有 CSS/HTML/组件文件 |
| 运行构建/测试 | `exec` | 验证设计产出（如 `npx tailwindcss` 构建） |
| 搜索设计参考 | `web_search` | 搜索设计趋势、配色方案、排版参考 |

### 子 Agent 协作模式

当设计任务涉及多领域（文案+代码+设计），按以下优先级决策：

1. **纯设计任务**（单文件/≤200行）→ 自己执行，不派发
2. **设计+代码**（多文件/复杂实现）→ 派 `sessions_spawn(agentId="sheji")` 或 `sessions_spawn(agentId="fengzhu")`
3. **三省六部流程**（用户明确要求或决策门 #6-#9 触发）→ 走 Edict Dashboard pipeline

### Token 预算感知

本 skill 文件按需加载，预估 token 消耗：
- SKILL.md（推理引擎）：~3,500 tokens
- 单个 domain 文件：~1,300-5,100 tokens
- 单个 knowledge 文件：~600-3,000 tokens
- 单个 library 文件：~2,300-4,100 tokens
- 单个 profile 文件：~500-4,000 tokens

**加载策略**：先读 `knowledge/INDEX.md`（~600 tokens）确定需要哪些文件，再按需加载。
---
## 10. 版本与进化
- **当前版本：** v9 · 鮱澄特化版 · impeccable 融合增强 + GSAP 引擎深度融合
- **架构：** 核心引擎（本文件）+ domains/ + profiles/ + libraries/ + knowledge/
- **自进化引擎：** `EVOLUTION.md` — 视觉自进化 v2，每次交付后复盘并更新
- **备份：** v7 保存在 `SKILL.md.v5`（v7 原文已融合为 v8，v5 是最后一个完整备份）
### v9.0 版本日志（2026-06-25）
- 版本号统一 v9：合并 v8.1 + v8.2 全部增量
- 新增 `knowledge/gsap-animation-engine.md`：10 章节 GSAP 深度融合（Motion 决策树、三旋钮精确映射、Easing 品味映射、ScrollTrigger 8 反模式、插件效果映射、性能铁律、Framework 集成、matchMedia + reduced-motion、autoAlpha 规则、水平滚动陷阱）
- `libraries/motion-patterns.md` +224 行：5 个 GSAP 高级模式（SplitText/DrawSVG/Flip/quickTo/ScrollTrigger.batch）
- §4.H 新增 MOTION → 引擎选择表（CSS / Motion / GSAP 精确路由）
- §4.H Easing 曲线新增 GSAP ease name 映射（power3/4.out、expo.out）
- §6 Pre-Flight 新增 §6.F2 GSAP 专项检查（10 项）
- 初始化 CHANGELOG.md

### v8.2 增量日志（2026-06-25）
- §4.H 新增 MOTION → 引擎选择表（CSS / Motion / GSAP 精确路由）
- §4.H Easing 曲线新增 GSAP ease name 映射（power3/4.out、expo.out）
- §1 MOTION 8-10 档位补充插件能力列表（SplitText/DrawSVG/MorphSVG 等）
- §2 路由表新增 knowledge/gsap-animation-engine.md 条目
- §6 Pre-Flight 新增 GSAP 专项检查（MOTION≥6 时）
- 新增 knowledge/gsap-animation-engine.md：10 章节深度融合（Motion 决策树、三旋钮精确映射、Easing 品味映射、ScrollTrigger 8 反模式、插件效果映射、性能铁律、Framework 集成、matchMedia + reduced-motion、autoAlpha 规则、水平滚动陷阱）

### v8.1 增量日志（2026-06-24）
- 新增 knowledge/color-science.md §11：Color Strategy 四步模型详细参数（色面积百分比/策略选择流程/OKLCH实践/Alpha异味/有色背景vs纯灰/暗色模式色阶/Token层次）
- 新增 knowledge/design-token-extraction.md：从代码反向提取设计 Token 的标准化流程（Discover/Identify/Plan/Extract四步）
- 新增 knowledge/design-critique.md：结构化设计批评方法论（Nielsen 启发式评分/认知负荷评估/角色走查/P0-P3分级）
- 新增 knowledge/design-context.md：DESIGN.md 项目级设计上下文系统（YAML frontmatter + 6段markdown/PRODUCT.md概念/物理场景描述法）
- §2 Domain 路由表新增操作模式（Critique/Extract/Design Context），与 knowledge 文件关联
- Pre-Flight Check 新增：上下文文件存在性检查（PRODUCT.md/DESIGN.md）

### v8 版本日志
- 新增 §0.A.1 Register 判断（Brand/Product/混合模式）
- 新增 §0.A.2 Color Strategy 四步模型（Restrained/Committed/Full palette/Drenched）
- 新增 §1.1 寄存器参数约束
- 新增 §1.5 AI Slop 动态检测（一阶/二阶 Reflex Check + Reflex-reject 列表）
- 增强 §4.A 排版纪律（Hero ≤6rem、tracking ≥-0.04em、text-wrap、字体配对规则）
- 增强 §4.B 色彩纪律（OKLCH 推荐、Anti-cream 禁令、tinted neutrals、对比度强制、物理场景法）
- 增强 §4.C 布局纪律（Flex vs Grid、auto-fit Grid、z-index 语义层级、Cards 懒惰警告）
- 升级 §4.G 交互状态为八状态（补入 Loading/Success，Focus Ring 正确做法、Popover API、CSS Anchor Positioning、Undo > Confirm）
- 新增 §4.H Motion 深度规范（100/300/500 时序、easing 曲线、Motion Materials Palette、80ms 阈值、stagger 规则、reduced-motion 强制）
- 新增 §4.I Absolute Bans（13 条禁令从 impeccable 移植）
- 扩展 §5 痕迹目录（T10、C07-C08、L11-L15）
- 增强 §6 Pre-Flight Check（Register/Color Strategy 检查、Motion 检查、交互检查、色彩检查）
- 版本号 v7 → v8
