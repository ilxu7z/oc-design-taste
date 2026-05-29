---
name: design-taste
description: >-
  设计品味校准框架。三旋钮推理模型 + AI痕迹目录 + 机械交付检查清单。
  适配B端产品画册/官网/生图/排版等视觉类任务。
  触发：设计/UI/前端/页面/画册/图片/官网/生图/样式/排版/布局/重新设计。
  内建容错：交付前二进制检查 → 不合格自动打回。
---

# Design Taste — 设计品味校准框架

> 核心理念：AI 输出的默认值 = 模板感、无品味。这个框架的目标是让 AI 跳出默认值。
> 每次视觉类任务都走一遍：读房间 → 调旋钮 → 写 Read → 派活 → 检查 → 打回或交付。

---

## 0. Brief Inference（读前确认）

**禁止拿到任务直接开干。** 先输出一行 Design Read。

### 0.A 读取信号

1. **载体类型** — 产品画册/官网首页/产品页/场景页/生图/Logo/海报
2. **受众** — 海外B端买家/国内经销商/终端消费者/双受众
3. **品牌调性关键词** — 用户用过的词："洁白干净""专业""实拍感""自然""工业""高端"
4. **已有品牌资产** — Logo、品牌色（如 YuKoLi #2E7D32）、已生成的图片、参考图
5. **约束条件** — 中英双语/多语言、三端响应式、移动优先、打印尺寸

### 0.B 输出一行 Design Read

格式：
> **「载体类型」×「受众」×「调性方向」→ 设计系统/审美家族**

示例：
- *"B端产品画册 × 海外买家 × 洁白专业 → Swiss modern sans-serif + 高对比度 + 克制配色"*
- *"OEM品牌官网 × 双受众 × 自然专业 → 食品工业风 + 实拍质感 + 温暖中性色"*
- *"设备官网 × 经销商+buyer × 干净硬朗 → 工业极简 + 设备实拍 + 蓝灰中性"*

### 0.C 模棱两可时

只问**一个**问题，不要多问。例："这页画册走洁白极简还是偏自然暖色调？"

如果能从上下文推断 —— 不提问，直接声明 Design Read 往下走。

### 0.D 反默认纪律

不要默认跳到以下 AI 模板：
- AI 紫/蓝渐变 Hero
- 三列等宽 feature card
- 满屏居中标题 + 抽象3D图
- 暖米咖喱色（"AI warm beige"）
- 生图时 AI 完美感（无尘、对称、饱和过度）
- Inter + slate-900 字体组合

---

## 1. 三旋钮推理模型

Design Read 之后，设定三个旋钮。所有布局/色彩/动效/排版决策由这三个值驱动。

### 基础刻度

| 旋钮 | 含义 | 1 | 10 |
|------|------|----|-----|
| **DESIGN_VARIANCE** | 布局实验性 | 严格对称、传统 | 非对称、现代、杂志感 |
| **MOTION_INTENSITY** | 动效深度 | 静态（画册/打印） | 电影级（互动官网） |
| **VISUAL_DENSITY** | 信息密度 | 美术馆留白 | 驾驶舱密集数据 |

### 场景预设

| 使用场景 | VARIANCE | MOTION | DENSITY |
|---------|----------|--------|---------|
| **B端产品画册（打印）** | 3-5 | 1（静态） | 4-6 |
| **设备/制造官网首页** | 5-7 | 4-6 | 3-4 |
| **产品详情页** | 4-5 | 3-4 | 4-5 |
| **场景/解决方案页** | 6-7 | 4-6 | 3-4 |
| **品牌故事/About 页** | 5-6 | 3-5 | 2-3 |
| **Logo/品牌标识** | 3-5 | 1 | 1-2 |
| **产品生图（Hero/场景）** | 3-4 | 1 | 2-3 |
| **连锁餐饮痛点图** | 7-8 | 1 | 5-6 |
| **极简白官网（YuKoLi风）** | 4-5 | 3-4 | 2-3 |
| **重新设计-渐进** | 维持原值 | +1 | 维持原值 |
| **重新设计-推翻** | +2 | +2 | 维持原值 |

---

## 2. AI 痕迹目录（我们的版本）

以下每条 = 检测到 → 扣分。二进制判断："有这个痕迹吗？有 = 不通过。"

### 2.A 排版痕迹

| 痕迹 | 说明 | 如何处理 |
|------|------|---------|
| ❌ Inter 字体做标题 | LLM 最爱默认字体 | 用品牌字体或至少换 Geist/Outfit/思源黑体 |
| ❌ Serif 滥用 | "有创意感就用 Serif" 是 AI 惯性 | 仅限品牌明确要求或纯 editorial 场景 |
| ❌ 三列等宽 feature card | 画册/官网最常见 AI 痕迹 | 用非对称网格、2列交错、时间轴 |
| ❌ `<br>` 切断标题做花样 | "for thirty\<br\>*years.*" 式花活 | 标题自然排版，不断词 |
| ❌ emoji 当图标 | 不像专业设计 | 用 Phosphor/Radix/Tabler 图标库 |
| ❌ 中文段落左右不齐 | AI 不检查中文排版 | 中文必须两端对齐或左对齐 + 合理断行 |
| ❌ 英文段落行宽 >75ch | 阅读疲劳 | 正文 max-width: 65ch（英文）/ 40em（中文） |

### 2.B 色彩痕迹

| 痕迹 | 说明 | 如何处理 |
|------|------|---------|
| ❌ AI 紫/蓝渐变 | LLM 最爱的渐变方案 | 用品牌色或单一中性色 |
| ❌ 暖米咖喱色（#F5F0EB 系） | "高级感"默认配色 | 除非用户明确喜欢，否则不用 |
| ❌ 纯黑 `#000000` + 纯白 `#FFFFFF` | 对比太生硬 | 用 `#111` + `#FAFAFA` 或品牌色系 |
| ❌ 同一页面出现两种灰色系 | 暖灰和冷灰混用 | 锁定一种灰系（Zinc/Slate/Stone），全页一致 |
| ❌ 高饱和配色 | AI 默认鲜艳 | 饱和度 < 80%，B端场景 < 60% |

### 2.C 生图痕迹（产品/场景图）

| 痕迹 | 说明 | 如何处理 |
|------|------|---------|
| ❌ AI 完美感 | 无尘、对称、过度饱和、塑料感 | 加"实拍 workshop feel + natural arrangement" |
| ❌ 东南亚场景用白/黑人 | 受众是东南亚，面孔必须匹配 | prompt 加"Southeast Asian faces" |
| ❌ 产品图背景空洞 | 无环境、无上下文 | ZONAL ANALYSIS 填满 Zone A/B/C/D |
| ❌ 厨房/烹饪术语出现在食品 OEM 图 | 品牌定位冲突 | ZONAL ANALYSIS Zone J 列禁忌词 |
| ❌ 画面内出现不存在的文字/标签 | AI 幻觉文字 | prompt 注明"no visible text or labels in image" |

### 2.D 文案痕迹

| 痕迹 | 说明 | 如何处理 |
|------|------|---------|
| ❌ "Elevate/Seamless/Unleash/Next-Gen" | AI 最爱的英文 marketing 词 | 用具体动词 |
| ❌ 自带横杠 `—` 做分割线 | #1 LLM 设计痕迹 | 中文用顿号或空格分隔，英文用逗号或竖线 |
| ❌ "Quietly trusted by" / "From the field" | 故作低调的 AI 文案 | 直接写 "Trusted by" / "Customers" |
| ❌ John Doe / Acme Corp | 默认假名 | 用真实感名称 |
| ❌ 99.99% / 50% 等完美数字 | 不真实 | 用 47.2%、83% 等不规整数据 |
| ❌ 擅自改品牌数据 | 破坏品牌公信力 | 品牌数据不可改（WhatsApp号、SKU数、仓库数等） |

### 2.E 画册特有痕迹

| 痕迹 | 说明 | 如何处理 |
|------|------|---------|
| ❌ 满页文字无留白 | B端画册不是杂志，但也不能填满 | 每页至少 15% 留白区域 |
| ❌ 所有页面布局雷同 | AI 偷懒每页用同一个 grid | 每 2-3 页变换一次布局节奏 |
| ❌ 表格/数据无对齐 | B端画册的专业性体现 | 数字右对齐、文字左对齐、表头居中 |
| ❌ 缺品牌一致性 | 页与页之间品牌元素断层 | 每页至少携带一个品牌锚点（Logo/色条/图形） |

---

## 3. Pre-Flight 交付检查清单

**二进制判断：每项只有 ✅ 或 ❌，没有"差不多"。**

### 通用检查（所有视觉类任务）
- [ ] 输出了 Design Read（section 0.B 格式）
- [ ] 三个旋钮已设定且与场景预设一致
- [ ] 无 AI 紫/蓝渐变
- [ ] 无三列等宽 feature card
- [ ] 无 emoji 当图标
- [ ] 无 AI 完美感（如果是生图）
- [ ] 色彩饱和度符合旋钮设定（B端 < 60%）
- [ ] 字体不是 Inter（除非明确要）
- [ ] 全页灰系统一（Zinc/Slate/Stone 择一）

### 生图专项（产品图/场景图/封面图）
- [ ] ZONAL ANALYSIS 全部 Zone 有内容
- [ ] 面孔匹配目标受众地域
- [ ] 品牌色已融入（包装/标志/环境元素）
- [ ] 无非真实文字/标签
- [ ] 无禁忌词（如 OEM 食品图无厨房/烹饪词）
- [ ] 光源参数已标注（方向/色温）
- [ ] 景深参数已标注（f/值）

### 画册专项
- [ ] 每页至少 15% 留白
- [ ] 数据表格对齐正确
- [ ] 每页携带品牌锚点
- [ ] 相邻 3 页布局不雷同
- [ ] 打印尺寸/出血位正确

### 官网专项
- [ ] 三端（PC/平板/手机）均通过检查
- [ ] 品牌数据不可改（WhatsApp/邮箱/SKU/仓库/发货时效）
- [ ] `min-h-[100dvh]` 非 `h-screen`（Hero 防 iOS 跳变）
- [ ] 图片有 width/height 防 CLS
- [ ] 表单可访问（label 可见、错误靠近字段）
- [ ] 点击区 ≥ 44×44px（移动端）

---

## 4. 子 Agent 任务注入模板

派发子 Agent 时，把以下块嵌入任务指令末尾：

```markdown
## ⚠️ Design Constraints (NON-NEGOTIABLE)

### Visual Rules
- NO AI-purple gradients. Use brand colors only.
- NO 3-column equal feature cards. Use asymmetric grid or zig-zag.
- NO emoji as icons. Use Phosphor/Radix/Tabler icons.
- NO Inter font by default. Use [brand font] or Geist.
- NO AI-perfect imagery. Products must look real, not sterile.
- Lock ONE gray family (Zinc/Slate/Stone) for the entire page.

### Typography
- Body text max-width: 65ch (EN) / 40em (ZH)
- NO `<br>` word breaks in headlines
- NO em-dash (—) anywhere in visible text

### Image Generation (if applicable)
- Southeast Asian faces for SEA-targeted content
- NO visible text/labels in generated images
- Natural workshop feel, not AI-perfect
- Brand color [#brand_hex] integrated into packaging/signage/environment

### Data Integrity
- DO NOT alter brand data: [list: WhatsApp, email, SKU count, warehouse count, shipping SLA]
```

---

## 5. 与其他方法论的关系

| 本框架 | 其他方法论 | 触发顺序 |
|--------|-----------|---------|
| Section 0/1: 三旋钮推理 | — | 最先执行 |
| Section 2.C/3: 生图检查 | `zonal-analysis-prompt-engineering.md` | Section 0/1 之后 → ZONAL ANALYSIS 写 prompt → Section 3 检查 |
| Section 2.D/3: 代码反模式 | `llm-coding-anti-patterns.md` | 代码产出后交叉检查 |
| Section 3: 交付前检查 | `ui-ux-design-intelligence.md` | 两者互补（本框架偏"品味"，UI/UX 偏"规范"） |

---

## 6. 循环进化协议

每次视觉类任务完成后：
1. 发现新的 AI 痕迹 → 追加到 Section 2
2. 发现场景预设三旋钮不准确 → 更新 Section 1 预设表
3. 发现检查清单遗漏 → 补充到 Section 3
4. 更新日志追加到本文件末尾

---

## 更新日志

| 日期 | 变更 |
|------|------|
| 2026-05-29 | v1 创建，基于 Taste-Skill 方法论 + 三旋钮模型 + 自建 AI 痕迹目录 |
