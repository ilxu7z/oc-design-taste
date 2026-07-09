# Design Taste — 设计品味校准框架

> 基于 Taste-Skill 方法论深度吸收，适配 B 端制造业/画册/官网场景的 AI 设计品味 skill。
>
> **v9.4** — 推理引擎 + 模块化知识体系，按需加载，不塞全量。

## 核心能力

- **三旋钮推理模型** — VARIANCE / MOTION / DENSITY，3 个参数驱动所有设计决策
- **Register 判断系统** — Brand / Product / 混合模式，自动区分「设计即产品」与「设计服务于产品」
- **Color Strategy 四步模型** — Restrained / Committed / Full palette / Drenched，按品牌承诺度匹配配色策略
- **AI 痕迹目录** — 5 大类 30+ 条 AI 常见视觉痕迹（AI Slop），二进制检查 + 突破条件
- **Pre-Flight 交付检查清单** — 通用/生图/画册/官网/Dashboard 多套专项检查
- **7 种美学预设** — 编辑奢华 / 柔和高级感 / 洁净极简 / 暗色开发者 / 工业粗野 / Stitch / 品牌套件生成
- **8 个领域特化** — Web 设计 / B端印刷品 / 邮件模板 / 图片生成 / 前端生图 / Dashboard / 旧项目改造 / Agent UI
- **GSAP 动画引擎深度集成** — MOTION ≥ 6 时自动触发，含 ScrollTrigger 反模式、插件映射、性能铁律
- **视觉自进化引擎 v2** — 任务闭环 → 差距蒸馏 → 规则固化，三层进化不互相阻塞

## 项目结构

```
skills/design-taste/
├── SKILL.md                        ← 推理引擎（核心文件，~1,500 行）
├── EVOLUTION.md                    ← 视觉自进化引擎 v2（三层进化协议）
├── domains/                        ← 领域特化规则（8 个领域）
│   ├── web-design.md               ← 官网/Landing Page/产品页
│   ├── b2b-print.md                ← B端画册/品牌手册/海报/PDF
│   ├── email.md                    ← 营销/事务/通知邮件模板
│   ├── image-generation.md         ← 产品图/场景图/痛点图
│   ├── imagegen-frontend.md        ← 前端驱动的图片生成
│   ├── dashboard.md                ← B端SaaS/Dashboard/数据可视化
│   ├── redesign.md                 ← 旧项目重新设计策略
│   └── agent-ui.md                 ← AI Agent 生成 UI/Copilot 面板
├── libraries/                      ← 组件/模式/动效库
│   ├── component-arsenal.md        ← 设计模式词汇表（250+ 参考模式）
│   ├── layout-patterns.md          ← 布局模式参考（非对称/瀑布/网格等）
│   └── motion-patterns.md          ← 动效代码骨架（CSS/Motion/GSAP）
├── profiles/                       ← 美学预设（7 种风格）
│   ├── brandkit.md                 ← 品牌套件生成（Logo/色彩/字体/视觉模式）
│   ├── editorial-luxury.md         ← 编辑奢华风
│   ├── soft-premium.md             ← 柔和高级感
│   ├── clean-minimalist.md         ← 洁净极简
│   ├── dark-developer.md           ← 暗色开发者
│   ├── industrial-brutalist.md     ← 工业粗野
│   └── stitch.md                   ← Stitch 风格
├── knowledge/                      ← 知识层深度参考（按需加载）
│   ├── INDEX.md                    ← 知识导航索引（先读我）
│   ├── ai-laziness.md              ← AI 常见偷懒模式（2,000 tokens）
│   ├── color-science.md            ← 色彩科学深度参考
│   ├── font-pairings.md            ← 字体配对方案参考
│   ├── design-systems.md           ← 设计系统构建指导
│   ├── design-critique.md          ← 设计评审方法论
│   ├── design-token-extraction.md  ← 设计 Token 提取
│   ├── design-context.md           ← 设计上下文理解
│   ├── gsap-animation-engine.md    ← GSAP 动画引擎深度指导
│   ├── declarative-ui.md           ← 声明式 UI 规范
│   ├── page-architecture.md        ← 页面架构指导
│   ├── premium-visual-techniques.md ← 高级视觉技法
│   └── a2ui-*.md                   ← A2UI 协议前瞻参考（4 文件）
└── scripts/
    └── sync.sh                     ← 仓库同步脚本
```

## 使用

```bash
# 主仓库（开发源）
npx skills add https://github.com/ilxu7z/oc-design-taste --skill "design-taste"

# 镜像仓库（同步副本）
npx skills add https://github.com/leappower/Skill-design-taste --skill "design-taste"
```

## 工作流

```
读信号 → 判断 Register → 选 Color Strategy → 调旋钮 → 路由 Domain → 写 Design Read → 按需加载 → 执行 → Pre-Flight → 交付
```

**⛔ 禁止拿到任务直接开干。** 必须先输出 Design Read（一行推断摘要），再进入领域文件加载和执行。

## 设计原则

- **AI 输出的默认值 ≠ 有品味的设计**。规则不是死的——每条都有适用场景和突破条件。
- **真正的品味 = 知道什么时候遵守规则，什么时候打破规则。**
- **模块化架构**：SKILL.md = 推理引擎（静态基线），EVOLUTION.md = 进化协议（动态引擎），其余文件按需加载。

## 来源

- 原始灵感：[Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill)
- 深度吸收 + 制造业 B 端场景适配 + GSAP 动画引擎集成
- 与自有方法论联动：ZONAL ANALYSIS（详见 SKILL.md §5）
- 仓库：[ilxu7z/oc-design-taste](https://github.com/ilxu7z/oc-design-taste)（开发源）←→ [leappower/Skill-design-taste](https://github.com/leappower/Skill-design-taste)（镜像同步）
