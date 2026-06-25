# Changelog

## v9.0 (2026-06-25)

### Added
- **GSAP animation engine deep integration** (`knowledge/gsap-animation-engine.md`, 501 lines)
  - Motion decision tree (CSS vs Motion vs GSAP precise routing)
  - Three-knob precise mapping (MOTION/VARIANCE/DENSITY → GSAP config per tier)
  - Easing taste mapping (power3.out ≈ quart, power4.out ≈ quint, expo.out ≈ expo)
  - ScrollTrigger 8 anti-patterns (ST01-ST08) with correct alternatives
  - Plugin-to-design-effect mapping (Flip/SplitText/DrawSVG/MorphSVG/MotionPath etc. 13 plugins)
  - Performance rules (transform+opacity priority, will-change, quickTo, batch, ScrollTrigger pin perf)
  - Framework integration minimum correct patterns (React useGSAP / Vue 3 / Svelte / SSR safety)
  - matchMedia + reduced-motion dual guard (stronger than CSS @media alone)
  - autoAlpha vs opacity rules (why autoAlpha is the "correct answer")
  - Horizontal scroll hijack pitfalls (containerAnimation 3 common mistakes)
- **SKILL.md §4.H**: MOTION → engine selection table (CSS / Motion / GSAP routing by intensity tier)
- **SKILL.md §4.H**: GSAP ease name mapping
- **SKILL.md §6.F2**: GSAP pre-flight checklist (10 items, triggered when MOTION ≥ 6)
- **SKILL.md §1**: MOTION 8-10 tier plugin capability list (SplitText/DrawSVG/MorphSVG)
- **SKILL.md §2**: Route table entry for `knowledge/gsap-animation-engine.md`
- **motion-patterns.md**: 5 GSAP advanced patterns (+224 lines)
  - SplitText character-by-character reveal
  - DrawSVG stroke animation
  - Flip layout animation
  - quickTo high-performance tracking
  - ScrollTrigger.batch batch triggering
- **CHANGELOG.md**: Version history tracking

### Changed
- SKILL.md: 652 → 690 lines (v8 → v9)
- motion-patterns.md: 597 → 821 lines
- Version identifier unified to v9 across all files

## v8.1 (2026-06-24)

### Added
- Color Strategy 4-step parameter model
- Design critique methodology (`knowledge/design-critique.md`)
- Design token extraction (`knowledge/design-token-extraction.md`)
- Design context understanding (`knowledge/design-context.md`)

## v8.0 (2026-06-22)

### Added
- Full modular architecture (domains/libraries/knowledge/profiles)
- Three-knob inference model (VARIANCE/MOTION/DENSITY)
- Register judgment system (Brand/Product/Hybrid)
- Color Strategy 4-step model
- AI Slop dynamic detection
- A2UI protocol knowledge layer (4 files, 1,786 lines)
- 8 domain files
- 3 library files
- 7 aesthetic profiles
- EVOLUTION.md v2 self-evolution engine

## v5.0 — v7.0

Historical versions. See git log for details.

## v4.0 and earlier

Historical versions. See git log for details.
