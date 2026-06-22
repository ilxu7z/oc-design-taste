---
knowledge: font-pairings
description: 设计品味框架字体配对知识库 — Sans-Serif 主力、Serif 轮换池、中文配对、Monospace 推荐、禁止字体与配对公式
---

# 字体配对知识库

> 融合 oc v5 Section 4.1、原版 taste-skill Section 4.1 和原版 v1 Section 3 Rule 1 的字体规则。
> 核心原则：默认用无衬线（Sans-Serif），"有设计感就用衬线"是 AI 最大的排版幻觉之一。

---

## 1. Sans-Serif 主力字体池

以下字体为默认首选，按推荐优先级排列。**Inter 为硬禁止默认字体**（除非品牌明确指定或用户要求）。

### 1.1 主力推荐

| 字体 | 特性 | 适用场景 | 配对 Mono |
|------|------|---------|-----------|
| **Geist** | Vercel 出品，几何现代，多字重（100-900），内置可变字体 | B端画册、官网标题、SaaS 后台 | Geist Mono |
| **Satoshi** | 英式现代 Grotesk，人文细节，字怀适中 | 品牌官网、Premium 消费品、Agency 作品集 | JetBrains Mono |
| **Outfit** | 圆润友好，几何清晰，低对比度 | 消费品、健康/教育、儿童品牌 | IBM Plex Mono |
| **Cabinet Grotesk** | 紧凑 Grotesk，高 x-height，压缩感强 | 数据密集 Dashboard、技术文档、开发者工具 | Inter Tight |
| **Switzer** | 瑞士风格 Grotesk，中性干净，多字重 | 企业官网、B端、公共部门 | JetBrains Mono |
| **Plus Jakarta Sans** | 人文主义无衬线，开放字怀，可读性极佳 | 正文密集页面、长文阅读、新闻 | IBM Plex Mono |
| **Clash Display** | 展示用无衬线，大胆几何，标题专用 | 品牌 Hero、海报、大字排版 | —（展示专用） |

### 1.2 中文无衬线推荐

| 字体 | 特性 | 适用场景 |
|------|------|---------|
| **思源黑体（Noto Sans SC）** | 7 字重，中日韩全覆盖，开源免费 | 中文 B端、官网、正文 |
| **阿里巴巴普惠体** | 3.0 版本，多字重，商用免费 | 电商、消费品、品牌中文 |
| **HarmonyOS Sans** | 华为出品，几何现代，中文优化 | 科技品牌、中文 SaaS |
| **OPPO Sans** | 人文主义，字怀开放，可读性好 | 消费品、教育、中文正文 |

### 1.3 字体选择纪律

| 场景 | 推荐 | 避免 | 突破条件 |
|------|------|------|---------|
| B端画册/官网标题 | Geist / Outfit / 思源黑体 | Inter（默认安全牌） | 品牌已有 Inter 或用户明确要求 |
| 正文 | 同标题字体或其正文字重变体 | 换另一套字体 | 明确的编辑排版需求 |
| 数字/数据 | 等宽字体（JetBrains Mono / IBM Plex Mono） | 比例字体显示数据 | 仅 1-2 个数字可用比例字体 |
| 衬线（慎用） | PP Editorial / Cormorant / EB Garamond | Fraunces / Instrument Serif（AI 最爱） | **仅当**品牌明确要求或真正的 editorial/luxury |

---

## 2. Serif 轮换池

### 2.1 核心纪律

- **Serif 仅当以下之一明确成立时才可用：**
  - 品牌明确指定了衬线字体
  - 美学方向是 editorial / luxury / publication / heritage
- **❌ 禁止的默认衬线：** Fraunces、Instrument Serif（AI 最爱）
- **强调规则：** 标题中要强调某个词时，用同一字体的 italic/bold，**不要**在无衬线标题中插入随机衬线词
- **轮换规则：** 如果上一个项目用了衬线，这个项目必须用无衬线。不要连续两个项目用同一款衬线

### 2.2 15+ 款 Serif 轮换池

| 字体 | 风格 | 适用场景 |
|------|------|---------|
| **PP Editorial New** | 当代编辑衬线，优雅克制 | 编辑排版、杂志、品牌手册 |
| **GT Sectra Display** | 高对比度，学术感，数字友好 | 学术出版、年度报告、luxury |
| **Cardinal Grotesque** | 混合 Grotesque 骨架的衬线 | 创意 agency、实验性品牌 |
| **Reckless Neue** | 复古现代，粗衬线，大胆 | 海报、标题、品牌 Hero |
| **Tiempos Headline** | 新闻衬线，紧凑，高可读性 | 新闻网站、长文、编辑内容 |
| **Recoleta** | 圆润复古，南美风情 | 食品包装、生活方式、旅行 |
| **Cormorant Garamond** | Garamond 变体，多字重，免费 | 正文密集、书籍、学术 |
| **Playfair Display** | 高对比度，经典编辑衬线 | 时尚、luxury、杂志标题 |
| **EB Garamond** | 经典 Garamond 复刻，免费开源 | 学术、文档、长文正文 |
| **IvyPresto** | 精致编辑衬线，优雅细节 | 奢侈品、美妆、酒店 |
| **Migra** | 实验性衬线，几何切割 | 创意品牌、艺术、展览 |
| **Editorial Old** | 粗犷编辑衬线，手工感 | 工艺品牌、独立出版 |
| **Saol Display** | 爱尔兰风格，粗重，有力量 | 体育、烈酒、男性品牌 |
| **Söhne Breit Kursiv** | 宽体斜体衬线，独特 | 创意标题、品牌标语 |
| **Domaine Display** | 高对比度，精致，奢华 | 地产、酒店、高端服务 |
| **Canela** | 温暖衬线，有机曲线 | 食品、生活方式、自然品牌 |
| **Schnyder** | 瑞士风格衬线，精确 | 手表、精密仪器、金融 |
| **Tobias** | 现代衬线，干净 | 法律、咨询、专业服务 |
| **NB Architekt** | 建筑感衬线，几何 | 建筑、设计、空间品牌 |
| **ITC Galliard** | 经典书籍衬线，优雅 | 出版、文化机构、博物馆 |

### 2.3 中文衬线推荐

| 字体 | 特性 | 适用场景 |
|------|------|---------|
| **思源宋体（Noto Serif SC）** | 7 字重，中日韩全覆盖，开源免费 | 中文 editorial、品牌手册、长文 |
| **方正清刻本悦宋** | 刻本风格，人文气息 | 文化品牌、艺术、出版 |
| **方正雅宋** | 现代宋体，清晰易读 | 新闻、杂志、中文正文 |

### 2.4 中文 Sans + Serif 配对规则

| 配对 | 场景 | 说明 |
|------|------|------|
| 思源黑体 + 思源宋体 | 中文 editorial | 同一家族体系，天然和谐 |
| 阿里巴巴普惠体 + 方正雅宋 | 中文品牌手册 | 普惠体做标题，雅宋做正文 |
| Geist + 思源宋体 | 中英双语 editorial | Geist 英文标题，思源宋体中文正文 |

---

## 3. Monospace 推荐

### 3.1 推荐列表

| 字体 | 特性 | 适用场景 |
|------|------|---------|
| **Geist Mono** | 与 Geist 同家族，几何现代 | 代码展示、数据表、技术文档 |
| **JetBrains Mono** | 开发者优化，连字丰富，高可读性 | 代码编辑器、终端、技术博客 |
| **Space Mono** | 宽体等宽，复古科技感 | 标题/展示用等宽、品牌标识 |
| **IBM Plex Mono** | IBM 出品，人文等宽，多字重 | 企业文档、数据仪表盘、正式报告 |
| **Fira Code** | 连字丰富，开源 | 代码编辑器、开发者工具 |
| **Source Code Pro** | Adobe 出品，清晰稳定 | 通用代码展示、文档 |

### 3.2 使用纪律

- 数据密集区域用 `font-variant-numeric: tabular-nums` 确保数字等宽对齐
- 代码块用 Monospace，正文不用
- 仅 1-2 个数字时可用比例字体

---

## 4. 禁止字体列表

### 4.1 硬禁止字体（除非品牌指定）

| 字体 | 为什么禁 | 突破条件 |
|------|---------|---------|
| **Inter** | LLM 安全牌，默认字体，无个性 | 品牌本身用 Inter 或用户明确要求 |
| **Roboto** | Android 默认，模板感 | 用户明确要求 Material 风格 |
| **Arial** | Web 安全字体，无设计感 | 邮件模板（客户端兼容） |
| **Open Sans** | 过度使用，无个性 | 用户明确要求 |
| **Helvetica** | 系统字体，付费问题 | 品牌本身用 Helvetica |
| **Fraunces** | AI 最爱衬线，过度使用 | 品牌明确指定 |
| **Instrument Serif** | AI 最爱衬线，过度使用 | 品牌明确指定 |

### 4.2 硬禁止图标库（除非品牌指定）

| 图标库 | 为什么禁 | 替代方案 |
|--------|---------|---------|
| **Lucide** | 标准粗描边，过度使用 | Phosphor Light/Thin、Radix Icons |
| **Feather** | 与 Lucide 同源，粗 | Phosphor、Tabler |
| **FontAwesome** | 过时，体积大，非 SVG | Phosphor、HugeIcons |
| **Material Icons** | Google 默认，模板感 | Radix Icons、Tabler |

**允许的图标库：** Phosphor Light/Thin、Remix Line、HugeIcons、Radix Icons、Tabler

---

## 5. 字体配对公式

### 5.1 三层配对体系

每个项目应建立 Display + Body + Mono 三层字体配对：

| 层级 | 角色 | 推荐 |
|------|------|------|
| **Display（展示）** | 标题、Hero、品牌大字 | Sans-Serif 主力（Geist / Satoshi / Cabinet Grotesk） |
| **Body（正文）** | 段落、描述、UI 文本 | 同 Display 字体或其正文字重变体 |
| **Mono（等宽）** | 代码、数据、数字 | 与 Display 配对的 Mono 字体 |

### 5.2 标准配对组合

| Display | Body | Mono | 适用场景 |
|---------|------|------|---------|
| Geist | Geist | Geist Mono | 现代 SaaS、开发者工具、B端 |
| Satoshi | Satoshi | JetBrains Mono | 品牌官网、Premium 消费品 |
| Outfit | Outfit | IBM Plex Mono | 消费品、健康、教育 |
| Cabinet Grotesk | Inter Tight | JetBrains Mono | 数据密集 Dashboard |
| Switzer | Switzer | IBM Plex Mono | 企业官网、公共部门 |
| 思源黑体 | 思源黑体 | JetBrains Mono | 中文 B端、中文官网 |
| 思源黑体（标题） | 思源宋体（正文） | JetBrains Mono | 中文 editorial |

### 5.3 配对纪律

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 一个项目只用一种 Display 字体 | 不混搭 Geist + Satoshi | 品牌有多字体体系且用户确认 |
| Body 优先用 Display 同字体 | 减少字体加载，视觉统一 | 明确的编辑排版需求 |
| Mono 必须与 Display 协调 | 风格一致，不突兀 | 无 |
| 连续项目轮换字体 | 不用同一款 Display 连续两次 | 品牌锁定字体 |
| 禁止 Inter 默认 | 主动选择替代字体 | 品牌或用户明确要求 |

---

## 6. 排版纪律速查

| 规则 | 说明 | 突破条件 |
|------|------|---------|
| 英文行宽 ≤ 65ch | 超过导致阅读疲劳 | 窄栏引用、数据表 |
| 中文行宽 ≤ 40em | 中文阅读舒适宽度 | 表格、数据密集区 |
| `<br>` 不断标题 | "for thirty<br>*years.*" 式花活是 AI 痕迹 | 用户明确要求，或 editorial 大字排版 |
| 标题不加随机衬线词 | "we design **and** spatial" 中 **and** 换字体是业余 | 同一字体用 italic/bold 强调即可 |
| Italic 下延字母 clearance | 斜体含 y/g/j/p/q 时，`leading-[1.1]` 最低 + `pb-1` | 会裁切下延字母 |
| 显示/标题字号 | 默认 `text-4xl md:text-6xl tracking-tighter leading-none` | 内容驱动 |
| 正文字号 | 默认 `text-base text-gray-600 leading-relaxed max-w-[65ch]` | 内容驱动 |
| 孤词修复 | 标题最后一行只剩一个词 → `text-wrap: balance` 或 `text-wrap: pretty` | 无 |
| 数字用等宽 | 数据密集区域用 `font-variant-numeric: tabular-nums` | 仅 1-2 个数字 |
| 全大写副标题节制 | 全大写标签太多 → 用小写斜体、首字母大写或小型大写 | 品牌风格要求 |
