---
knowledge: design-context
description: 项目级设计上下文持久化系统 — DESIGN.md 格式规范 + PRODUCT.md 概念 + Token 引用 + 物理场景描述法
---

# 项目级设计上下文系统

> 设计决策的持久化记忆。不是每次从头推断，而是从已确立的上下文出发。
> 来源：impeccable DESIGN.md/PRODUCT.md 系统，适配 oc-design-taste 模块化架构。

---

## 1. 核心概念

### 1.1 为什么需要项目级上下文

没有上下文时，每次新页面/新组件的设计决策都是独立的——AI 或设计师每次都从零开始，导致：
- 同一项目的不同页面风格不一致
- 每次都要重新推断品牌调性
- Token 值散落在代码中，无法系统化

### 1.2 两个上下文文件

| 文件 | 放置位置 | 内容 | 读者 |
|------|---------|------|------|
| **PRODUCT.md** | 项目根目录 | 品牌战略、受众、调性、反参考 | 设计决策的"为什么" |
| **DESIGN.md** | 项目根目录 / `docs/` / `.agents/context/` | 视觉设计系统（Token + 规则） | 设计决策的"怎么做" |

**两者关系**：PRODUCT.md 定义战略，DESIGN.md 执行视觉。DESIGN.md 应引用 PRODUCT.md 的反参考。

---

## 2. PRODUCT.md 规范

### 2.1 结构

```yaml
---
# 可选 YAML frontmatter，用于机器可读的元数据
---

# PRODUCT.md — [项目名] 品牌战略

## 品牌
- 一句话定位
- 品牌个性（3-5 个形容词）
- 反参考（我们不是什么——列出 2-3 个具体品牌/产品）

## 受众
- 主要受众：[描述]
- 次要受众：[描述]
- 用户场景：[1-2 个典型场景]

## 设计方向
- Register：Brand / Product / 混合
- Color Strategy：Restrained / Committed / Full Palette / Drenched
- Motion Energy：克制 / 响应式 / 编排

## 参考
- 正面参考：[2-3 个具体品牌/产品/印刷品]
- 反参考：[1-2 个"我们不想看起来像"的例子]
```

### 2.2 反参考的力量

反参考比正参考更重要。"不像 Stripe"比"像 Linear"更精确。

好的反参考：
- ✅ "不想像 SaaS Landing Page 模板（紫蓝渐变 Hero + 三列 feature card + 信任 Logo Wall）"
- ✅ "不想像 Notion（太白、太文字、缺乏个性）"
- ❌ "不要太花"（太模糊）
- ❌ "要专业"（没有对比锚点）

---

## 3. DESIGN.md 规范

### 3.1 格式

YAML frontmatter（机器可读 Token）+ Markdown body（6 个固定段落）。

```yaml
---
name: <项目标题>
description: <一句话标语>
colors:
  primary: "#b8422e"
  neutral-bg: "#faf7f2"
  # 每种提取的颜色一个条目；key = 描述性 slug
typography:
  display:
    fontFamily: "字体名, fallback, serif"
    fontSize: "clamp(2.5rem, 7vw, 4.5rem)"
    fontWeight: 300
    lineHeight: 1
    letterSpacing: "normal"
  body:
    # ...
rounded:
  sm: "4px"
  md: "8px"
spacing:
  sm: "8px"
  md: "16px"
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.neutral-bg}"
    rounded: "{rounded.sm}"
    padding: "16px 48px"
---

# 设计系统：[项目标题]

## 1. 概述

**创意北极星："[命名隐喻]"**

[2-3 段整体描述：个性、密度、美学哲学。从北极星开始向外展开。声明这个系统明确拒绝什么。]

## 2. 色彩

[一段话描述调色板特征。]

### Primary
- **[描述性名称]** (#HEX / oklch(...)): [在哪里使用，为什么。具体上下文，不只是角色。]

### Secondary（可选）

### Neutral
- **[描述性名称]** (#HEX): [文字/背景/边框/分隔线角色。]

### 命名规则（可选，强烈推荐）
**[规则名] 规则。** [简短有力的禁令或原则。]

## 3. 排版

**Display 字体**：[字体]（with [fallback]）
**Body 字体**：[字体]（with [fallback]）

### 层级
- **Display** ([weight], [size], [line-height]): [用途]
- **Headline** ([weight], [size], [line-height]): [用途]
- **Title** ([weight], [size], [line-height]): [用途]
- **Body** ([weight], [size], [line-height]): [用途]
- **Label** ([weight], [size], [letter-spacing]): [用途]

## 4. 立体感

[一段话：阴影、色调分层、还是混合？]

### 阴影词汇（如适用）

## 5. 组件

每种组件：形状、颜色分配、状态、独特行为。

### 按钮
### 卡片/容器
### 输入/字段
### 导航

## 6. 做与不做

### 做：
- [具体处方，带精确值]
- [...]

### 不做：
- [具体禁令，引用 PRODUCT.md 的反参考]
- [...]
```

### 3.2 Token 引用语法

frontmatter 中的组件 token 用 `{path.to.token}` 引用：

```yaml
components:
  button-primary:
    backgroundColor: "{colors.primary}"    # 引用 colors.primary
    rounded: "{rounded.sm}"                 # 引用 rounded.sm
```

**规则**：
- 组件可以引用原始 token
- 原始 token 之间不能互相引用
- 不要在 frontmatter 和 prose 中对同一 token 给出不同值（frontmatter 是规范来源）

### 3.3 色彩格式

| 格式 | 适用场景 | 注意 |
|------|---------|------|
| Hex sRGB | 需要严格兼容性、Stitch linter | frontmatter 默认 |
| OKLCH | 需要感知均匀性、Display P3 | prose 中标注为规范参考 |

**不要在 frontmatter 中用 OKLCH 又在 prose 中给不同值的 hex**——那会分裂来源真相。

### 3.4 命名规则的力量

给规则起名字让它可引用、可记忆：

- ✅ "10% 规则" — 主 accent 不超过页面面积的 10%
- ✅ "单一灰调规则" — 一个项目只用一种灰色系
- ✅ "北极星规则" — 每个设计决策都能追溯到创意北极星
- ❌ "使用品牌色"（不具体，不可引用）

---

## 4. 物理场景描述法

用于色彩主题选择（SKILL.md §4.B 提到），也用于整体设计方向锁定。

### 4.1 方法

写一句话的物理场景描述：
> 谁、在哪、什么光、什么心情

### 4.2 好的例子

- "傍晚的东京，混凝土建筑上的暖橙色路灯，城市的舒适孤独"
- "清晨的北欧工作室，白色台面、木制工具、窗外薄雾中的松林"
- "深圳科技园的会议室，投影幕布的冷蓝光，专业但不冰冷"

### 4.3 判断标准

如果句子不强迫答案 → 不够具体 → 加细节直到答案明确。

"温暖专业" → 不够具体
"曼谷路边咖啡馆，午后斜阳打在深绿色瓷砖上，时间缓慢" → 足够具体，色板自然浮现

### 4.4 场景 → Token 的转换

| 场景元素 | 对应 Token |
|---------|-----------|
| 光源方向/色温 | 阴影方向 + tinted neutrals 的 hue |
| 环境材质 | 表面纹理/noise/roughness |
| 情绪关键词 | Color Strategy 档位 + Motion Energy |
| 具体颜色 | 主色/辅色的候选 |

---

## 5. 与 SKILL.md 的集成

### 5.1 何时创建/更新上下文文件

| 触发 | 动作 |
|------|------|
| 新项目启动 | 创建 PRODUCT.md（种子模式：5 个问题 → 最小 scaffold） |
| 设计系统确立 | 创建 DESIGN.md（扫描模式：从代码提取 Token） |
| 重新设计前 | 备份现有 DESIGN.md，更新 PRODUCT.md |
| 品牌升级 | 更新 PRODUCT.md + DESIGN.md 同步 |

### 5.2 种子模式 vs 扫描模式

| 模式 | 触发条件 | 产出 |
|------|---------|------|
| **种子模式** | 项目无代码/无设计系统 | 最小 scaffold DESIGN.md（`<!-- SEED -->` 标记），无具体 token |
| **扫描模式** | 项目有代码/Token/组件 | 完整 DESIGN.md（frontmatter + 6 段落）+ Token 提取 |

### 5.3 AI Agent 如何使用

1. 收到设计任务时，先检查 `PRODUCT.md` 和 `DESIGN.md` 是否存在
2. 如果存在：读取它们，作为 Design Read 的输入
3. 如果不存在：建议创建（种子模式：5 个快速问题）
4. 每次设计决策都应追溯到 PRODUCT.md/DESIGN.md 的某条规则或 Token

### 5.4 安全规则

- **永不静默覆盖**：DESIGN.md 已存在时，展示给用户确认
- **不要凭空编造 Token**：没有代码就不写 token 值
- **不要重复 PRODUCT.md 内容**：DESIGN.md 是纯视觉，不含战略
