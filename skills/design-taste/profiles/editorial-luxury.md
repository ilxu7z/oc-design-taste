---
profile: editorial-luxury
description: 编辑/奢侈品/高级感美学预设 — 暖调、serif、留白、纸感、embossing、优雅
dial-suggestion: VARIANCE 4-6 / MOTION 2-4 / DENSITY 1-3
---

# 美学预设：Editorial Luxury（编辑奢侈品）

## 1. 氛围概述

Editorial Luxury 是高端编辑/奢侈品/生活方式品牌的美学方向。它模拟精装杂志、奢侈品牌手册、高级酒店画册的视觉语言。核心气质：**安静、昂贵、有触感**。

- **密度**：美术馆级留白（DENSITY 1-3）。每个元素都有呼吸空间
- **变化**：中等偏移（VARIANCE 4-6）。非对称但克制，不激进
- **动效**：静态到柔和（MOTION 2-4）。无闪烁，无弹跳，无编排叙事

## 2. 色板

### 2.1 主色板

| 角色 | 色值 | 说明 |
|------|------|------|
| 画布背景 | `#FDFBF7` | 暖奶油白 — 模拟高级纸张底色 |
| 卡片/容器 | `#FFFFFF` | 纯白，用于卡片和内容块 |
| 主文字 | `#1A1714` | 浓缩咖啡近黑 — 温暖而非冷黑 |
| 副文字 | `#6B6358` | 暖灰褐 — 正文、描述、元数据 |
| 三级文字 | `#9C9488` | 更浅的灰褐 — 时间戳、标签 |
| 分隔线 | `rgba(0,0,0,0.06)` | 极淡发丝线 |
| 阴影 | `rgba(0,0,0,0.03)` | 极淡扩散阴影 — 几乎不可见 |

### 2.2 强调色（选 1 个）

| 选项 | 色值 | 适用场景 |
|------|------|---------|
| 深酒红 | `#8B2D3A` | 经典奢侈品、美妆、酒店 |
| 鼠尾绿 | `#7A8B7A` | 自然/有机品牌、健康 |
| 焦赭石 | `#A67C52` | 皮革/工艺/复古定位 |
| 深海军蓝 | `#1B3A5C` | 专业服务、金融、法律 |

### 2.3 禁令

- ❌ 纯黑 `#000000` — 用 `#1A1714` 替代
- ❌ 纯白 `#FFFFFF` 作为背景 — 用 `#FDFBF7` 替代
- ❌ 高饱和强调色（饱和度 > 60%）
- ❌ 霓虹色、渐变、AI 紫蓝发光
- ❌ 暖米咖喱色板作为默认（仅当品牌本身是暖色调时可用）

## 3. 排版体系

### 3.1 字体选择

| 层级 | 推荐字体 | 参数 |
|------|---------|------|
| **Display/标题** | `PP Editorial New`, `Cormorant Garamond`, `EB Garamond`, `Instrument Serif` | Serif，`letter-spacing: -0.02em`，`line-height: 1.1`，重量 600-700 |
| **正文** | `Satoshi`, `Outfit`, `Geist` | Sans-Serif，`line-height: 1.7`，重量 400 |
| **元数据/标签** | `Geist Mono`, `JetBrains Mono` | Monospace，`letter-spacing: 0.05em`，`text-transform: uppercase`，`font-size: 0.75rem` |
| **引用/装饰** | `PP Editorial New Italic`, `Cormorant Italic` | Serif Italic，大号，用于 pull quotes |

### 3.2 字号比例

```
Display: clamp(2.5rem, 5vw, 5rem)    — 标题
Subhead: clamp(1.25rem, 2vw, 1.75rem) — 副标题
Body:    1rem / 1.125rem              — 正文
Small:   0.8125rem                    — 标签、元数据
Caption: 0.6875rem                    — 图片说明、脚注
```

### 3.3 中文特化

| 规则 | 值 | 说明 |
|------|----|------|
| 中文字体 | 思源宋体（Source Han Serif / Noto Serif CJK SC） | 用于中文标题和正文 |
| 中文行宽 | ≤ 40em | 中文阅读舒适宽度 |
| 中文字号 | 比英文大 0.125rem | 中文笔画密集，需稍大字号 |
| 中英文混排 | 中文用思源宋体，英文用 Editorial New | 确保视觉和谐 |
| 中文标题 | 思源宋体 Weight 600，`letter-spacing: 0.02em` | 中文 serif 标题需要稍宽字距 |

### 3.4 排版纪律

- **Serif 用于标题，Sans-Serif 用于正文** — 这是 editorial 排版的核心约定
- **标题大写** — 全大写标题仅用于短标题（≤ 4 词），加宽 tracking
- **首字母大写** — 标题用 Sentence case，非 Title Case
- **孤词修复** — `text-wrap: balance` 或 `text-wrap: pretty`
- **Em-dash 禁令** — 零 em-dash 在可见文本中
- **中文标点** — 用全角中文标点（，。：；——但 em-dash 仍禁止）

## 4. 布局原则

### 4.1 页面节奏

- **巨量留白** — Section padding `py-24` 到 `py-40`
- **不对称但克制** — 60/40 或 70/30 分栏，不极端
- **内容宽度** — `max-w-5xl` 或 `max-w-6xl`，居中
- **正文宽度** — `max-w-prose`（约 65ch / 40em 中文）

### 4.2 Hero 规范

- **Editorial Manifesto Hero** — 大字排版 + 大量留白，无多余视觉元素
- **Asymmetric Split Hero** — 左文右图，或左图右文
- **文字元素 ≤ 3 个** — 标题 + 副文本 + CTA（可选）
- **Hero 必须有视觉元素** — 图片、视频、或排版本身作为视觉
- **无版本标签、无序号 eyebrow、无滚动提示**

### 4.3 Section 多样性

- 至少 4 种不同布局家族在 8 个 section 中
- 无 3 个连续 section 用同一布局
- Zigzag 交替最多 2 段
- 无三列等宽卡片

### 4.4 卡片与容器

- 卡片用 `rounded-[1.5rem]` 或 `rounded-[2rem]`
- 边框 `1px solid rgba(0,0,0,0.06)`
- 阴影极淡 — `0 8px 32px rgba(0,0,0,0.04)`
- 内边距 `p-8` 到 `p-12`
- 卡片仅用于层级表达 — 否则用负空间分组

## 5. 纹理与触感

Editorial Luxury 的核心差异在于**触感**。设计必须模拟物理印刷品的质感。

### 5.1 纸张纹理

```css
/* 全局纸张噪点 */
.editorial-noise::before {
  content: '';
  position: fixed;
  inset: 0;
  z-index: 50;
  pointer-events: none;
  opacity: 0.03;
  background-image: url("data:image/svg+xml,..."); /* SVG 噪点 */
  mix-blend-mode: multiply;
}
```

### 5.2 Embossing 效果

```css
/* 压印/浮雕效果 — 用于 Logo 或大标题 */
.emboss {
  color: #FDFBF7;
  text-shadow:
    0 1px 0 rgba(0,0,0,0.08),
    0 -1px 0 rgba(255,255,255,0.3);
}
```

### 5.3 半色调装饰

- 用于背景装饰或图片处理
- 低透明度（`opacity: 0.02-0.05`）
- 仅用于固定 `pointer-events-none` 层

## 6. 动效哲学

- **静态优先** — MOTION 2-4 范围，动效是点缀不是特征
- **入场动画** — `translateY(8px)` + `opacity: 0` → `translateY(0)` + `opacity: 1`，800ms，`cubic-bezier(0.16, 1, 0.3, 1)`
- **无弹跳、无弹簧、无编排** — 保持安静
- **Hover 状态** — 仅颜色变化，无缩放、无位移
- **Reduced Motion** — 必须 honor

## 7. 图片与视觉资产

- **摄影方向** — 电影级、暖调、低饱和、自然光
- **图片处理** — 叠加极淡暖色 overlay（`opacity: 0.04`）
- **占位图** — `picsum.photos/seed/{描述}/{w}/{h}`
- **无标签叠加在图片上**
- **无照片署名作为装饰**

## 8. 品牌套件应用

当生成品牌套件时，使用 Luxury / Beauty / Fashion 视觉模式：

- 象牙/石头/浓缩咖啡色板
- Serif 字标
- 优雅字母组合
- 纸张纹理
- Embossing 效果
- 产品标签
- Editorial 裁剪
- 柔和阴影

## 9. 禁令清单

- ❌ Em-dash `—` 在任何位置
- ❌ Inter / Roboto / Arial / Open Sans 字体
- ❌ 纯黑 `#000000` 背景
- ❌ 霓虹色、渐变、AI 紫蓝发光
- ❌ 三列等宽卡片
- ❌ 序号 eyebrow（`001 · Capabilities`）
- ❌ 版本标签在 Hero
- ❌ 滚动提示（`Scroll to explore`）
- ❌ 装饰性状态圆点
- ❌ 中间点 `·` 过度使用
- ❌ 假精确数字（99.99%）
- ❌ AI 文案痕迹（"Elevate", "Seamless", "Unleash"）
- ❌ Emoji 当图标
- ❌ `h-screen` — 用 `min-h-[100dvh]`
- ❌ 纯文字 + 渐变色块 Hero
- ❌ 暖米咖喱色板作为默认（Section 4.2.B 禁令）

## 10. 适用场景

| 场景 | 推荐度 | 备注 |
|------|--------|------|
| 奢侈品官网 | ⭐⭐⭐ | 核心场景 |
| 品牌手册/画册 | ⭐⭐⭐ | 核心场景 |
| 酒店/度假村网站 | ⭐⭐⭐ | 核心场景 |
| 美妆/时尚品牌 | ⭐⭐⭐ | 核心场景 |
| 高端 Agency 官网 | ⭐⭐⭐ | 核心场景 |
| 地产/豪宅网站 | ⭐⭐ | 调整色板更温暖 |
| 文化/艺术机构 | ⭐⭐ | 可提高 VARIANCE |
| B端产品画册 | ⭐ | 仅高端 B端品牌 |
| SaaS 产品页 | ❌ | 用 Ethereal Glass 或 Soft Structuralism |
| Dashboard | ❌ | 不适用 |
