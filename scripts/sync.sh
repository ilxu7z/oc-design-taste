#!/bin/bash
# oc-design-taste 同步脚本
# 用途：将本地增强同步到 GitHub 仓库，或从 GitHub 拉取更新
# 用法：./scripts/sync.sh {up|down|diff}

set -euo pipefail

SKILL_DIR="${SKILL_DIR:-$HOME/.openclaw/skills/design-taste}"
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BRANCH="${BRANCH:-main}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { echo -e "${GREEN}→${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC}  $*"; }
err()  { echo -e "${RED}✗${NC} $*"; }

show_diff() {
  log "对比本地安装 vs 仓库..."
  if [ ! -d "$SKILL_DIR" ]; then
    err "本地 skill 目录不存在: $SKILL_DIR"
    exit 1
  fi
  
  echo ""
  echo "=== 仅在仓库中存在 ==="
  diff -rq "$REPO_DIR/skills/design-taste" "$SKILL_DIR" \
    --exclude=".git" 2>&1 | grep "Only in $REPO_DIR" || echo "  (无)"
  
  echo ""
  echo "=== 仅在本地安装中存在 ==="
  diff -rq "$REPO_DIR/skills/design-taste" "$SKILL_DIR" \
    --exclude=".git" 2>&1 | grep "Only in $SKILL_DIR" || echo "  (无)"
  
  echo ""
  echo "=== 内容差异 ==="
  diff -rq "$REPO_DIR/skills/design-taste" "$SKILL_DIR" \
    --exclude=".git" 2>&1 | grep "differ" || echo "  (无差异)"
}

sync_to_upstream() {
  log "同步本地增强 → GitHub 仓库..."
  
  cd "$REPO_DIR"
  git fetch origin "$BRANCH"
  
  if ! git diff --quiet "origin/$BRANCH" --; then
    warn "仓库有未推送的提交，请先 push 或 rebase"
    git status --short
    return 1
  fi
  
  # 复制增强文件
  local copied=0
  for f in SKILL.md EVOLUTION.md; do
    if [ -f "$SKILL_DIR/$f" ]; then
      if ! diff -q "$SKILL_DIR/$f" "$REPO_DIR/skills/design-taste/$f" > /dev/null 2>&1; then
        cp "$SKILL_DIR/$f" "$REPO_DIR/skills/design-taste/$f"
        log "  已复制: $f"
        ((copied++))
      fi
    fi
  done
  
  for dir in domains libraries knowledge profiles; do
    if [ -d "$SKILL_DIR/$dir" ]; then
      for f in $(find "$SKILL_DIR/$dir" -name "*.md" -type f); do
        local rel="${f#$SKILL_DIR/}"
        if [ ! -f "$REPO_DIR/skills/design-taste/$rel" ]; then
          mkdir -p "$(dirname "$REPO_DIR/skills/design-taste/$rel")"
          cp "$f" "$REPO_DIR/skills/design-taste/$rel"
          log "  新增: $rel"
          ((copied++))
        elif ! diff -q "$f" "$REPO_DIR/skills/design-taste/$rel" > /dev/null 2>&1; then
          cp "$f" "$REPO_DIR/skills/design-taste/$rel"
          log "  已复制: $rel"
          ((copied++))
        fi
      done
    fi
  done
  
  if [ "$copied" -eq 0 ]; then
    log "无差异，无需同步"
  else
    log "已复制 $copied 个文件。请手动 review 后 commit & push："
    echo ""
    echo "  cd $REPO_DIR"
    echo "  git diff --stat"
    echo "  git add -A && git commit -m 'sync: local enhancements'"
    echo "  git push origin $BRANCH"
  fi
}

sync_from_upstream() {
  log "从 GitHub 拉取更新 → 本地安装..."
  
  cd "$REPO_DIR"
  git fetch origin "$BRANCH"
  git checkout "$BRANCH"
  git pull origin "$BRANCH"
  
  if [ ! -d "$SKILL_DIR" ]; then
    err "本地 skill 目录不存在: $SKILL_DIR"
    exit 1
  fi
  
  # 备份当前版本
  local backup_dir="${SKILL_DIR}.bak.$(date +%Y%m%d-%H%M%S)"
  cp -r "$SKILL_DIR" "$backup_dir"
  log "已备份到: $backup_dir"
  
  # 同步（保留本地独有文件）
  rsync -av --ignore-existing \
    "$REPO_DIR/skills/design-taste/" "$SKILL_DIR/"
  
  # 覆盖已存在的文件（仓库版本优先）
  rsync -av \
    "$REPO_DIR/skills/design-taste/" "$SKILL_DIR/"
  
  log "同步完成。本地独有文件已保留在备份中。"
  echo ""
  echo "备份: $backup_dir"
  echo "如需恢复: cp -r $backup_dir/* $SKILL_DIR/"
}

case "${1:-}" in
  diff)
    show_diff
    ;;
  up)
    sync_to_upstream
    ;;
  down)
    sync_from_upstream
    ;;
  *)
    echo "用法: $0 {diff|up|down}"
    echo ""
    echo "  diff  — 对比本地安装与仓库的差异"
    echo "  up    — 将本地增强同步到 GitHub 仓库"
    echo "  down  — 从 GitHub 拉取更新到本地安装"
    echo ""
    echo "环境变量:"
    echo "  SKILL_DIR  本地 skill 目录 (默认: ~/.openclaw/skills/design-taste)"
    echo "  BRANCH     Git 分支 (默认: main)"
    exit 1
    ;;
esac
