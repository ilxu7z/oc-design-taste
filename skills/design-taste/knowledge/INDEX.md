---
knowledge: index
description: 知识层快速导航索引。Agent 先读此文件（~500 tokens），再按需加载目标文件。
load_priority: always_first
token_estimate: ~600 tokens
---

# Knowledge Index — 知识层导航

> 先读我。再按场景加载目标文件。

## 按场景加载

| 场景 | 加载文件 | 预估 tokens |
|------|---------|------------|
| 需要理解 AI 常见偷懒模式 | `ai-laziness.md` | ~2,000 |
| 需要色彩科学深度参考 | `color-science.md` | ~2,200 |
| 需要字体配对方案 | `font-pairings.md` | ~1,000 |
| 需要设计系统构建指导 | `design-systems.md` | ~1,000 |
| 需要设计评审方法论 | `design-critique.md` | ~1,200 |
| 需要提取设计 Token | `design-token-extraction.md` | ~600 |
| 需要设计上下文理解 | `design-context.md` | ~1,400 |
| MOTION ≥ 6 需要 GSAP 深度指导 | `gsap-animation-engine.md` | ~2,500 |
| 需要声明式 UI 规范 | `declarative-ui.md` | ~2,600 |
| 需要 A2UI 协议集成 [前瞻] | `a2ui-mcp-integration.md` | ~2,400 |
| 需要 A2UI 组件目录 [前瞻] | `a2ui-catalog-reference.md` | ~2,100 |
| 需要 A2UI 主题系统 [前瞻] | `a2ui-theming.md` | ~1,700 |
| 需要 A2UI Agent SDK [前瞻] | `a2ui-agent-sdk.md` | ~2,700 |
| 需要核心设计纪律详细规则 | `core-disciplines.md` | ~3,000 |

## 按领域加载

| 领域 | 加载文件 | 预估 tokens |
|------|---------|------------|
| Web 设计 | `../domains/web-design.md` | ~2,500 |
| B端印刷品 | `../domains/b2b-print.md` | ~1,700 |
| 邮件模板 | `../domains/email.md` | ~1,300 |
| 图片生成 | `../domains/image-generation.md` | ~4,300 |
| 前端生图 | `../domains/imagegen-frontend.md` | ~5,100 |
| Dashboard | `../domains/dashboard.md` | ~4,600 |
| 旧项目改造 | `../domains/redesign.md` | ~2,000 |
| Agent UI | `../domains/agent-ui.md` | ~2,700 |

## 按组件/模式加载

| 需求 | 加载文件 | 预估 tokens |
|------|---------|------------|
| 需要设计模式词汇表 | `../libraries/component-arsenal.md` | ~2,500 |
| 需要布局模式参考 | `../libraries/layout-patterns.md` | ~2,300 |
| 需要动效代码骨架 | `../libraries/motion-patterns.md` | ~4,100 |

## 按美学预设加载

| 风格 | 加载文件 | 预估 tokens |
|------|---------|------------|
| 品牌套件生成 | `../profiles/brandkit.md` | ~4,000 |
| 编辑奢华风 | `../profiles/editorial-luxury.md` | ~1,100 |
| 柔和高级感 | `../profiles/soft-premium.md` | ~500 |
| 洁净极简 | `../profiles/clean-minimalist.md` | ~500 |
| 暗色开发者 | `../profiles/dark-developer.md` | ~1,800 |
| 工业粗野 | `../profiles/industrial-brutalist.md` | ~500 |
| Stitch 风格 | `../profiles/stitch.md` | ~1,200 |

## 加载策略

1. **先读本索引**（~600 tokens），确定需要哪些文件
2. **按需加载**，不一次性全读
3. **MOTION ≥ 6 时**必须加载 `gsap-animation-engine.md`
4. **[前瞻] 标记的文件**基于未在 OpenClaw 中原生支持的协议，仅作前瞻参考
