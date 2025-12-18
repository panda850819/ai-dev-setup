#!/bin/bash

# Claude Code Plugin 一鍵安裝腳本
# 用法: bash setup-plugins.sh

set -e

echo "========================================"
echo "  Claude Code Plugin 安裝腳本"
echo "========================================"
echo ""

# 顏色定義
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 檢查 claude 是否安裝
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}⚠ Claude Code 尚未安裝${NC}"
    echo "請先安裝 Claude Code: npm install -g @anthropic-ai/claude-code"
    exit 1
fi

echo -e "${BLUE}步驟 1/3: 新增 Marketplaces${NC}"
echo "----------------------------------------"

# 新增 marketplaces（如果尚未存在）
MARKETPLACES=(
    "obra/superpowers-marketplace"
    "thedotmack/claude-mem"
    "anthropic/claude-plugins-official"
)

echo "將透過 Claude Code 的 /plugin 命令新增 marketplaces"
echo ""
echo "請在 Claude Code 互動介面中執行以下命令："
echo ""
for marketplace in "${MARKETPLACES[@]}"; do
    echo -e "  ${GREEN}/plugin marketplace add ${marketplace}${NC}"
done

echo ""
echo -e "${BLUE}步驟 2/3: 安裝 Plugins${NC}"
echo "----------------------------------------"

# 要安裝的 plugins
PLUGINS=(
    "superpowers@superpowers-marketplace"
    "claude-mem@thedotmack"
    "context7@claude-plugins-official"
)

echo "請在 Claude Code 互動介面中執行以下命令："
echo ""
for plugin in "${PLUGINS[@]}"; do
    echo -e "  ${GREEN}/plugin install ${plugin}${NC}"
done

echo ""
echo -e "${BLUE}步驟 3/3: 設定 settings.json${NC}"
echo "----------------------------------------"

# 建立或更新 settings.json
SETTINGS_FILE="$HOME/.claude/settings.json"

if [ -f "$SETTINGS_FILE" ]; then
    echo "settings.json 已存在，請確認包含以下設定："
else
    echo "建立 settings.json..."
    mkdir -p "$HOME/.claude"
fi

cat << 'EOF'
{
  "enabledPlugins": {
    "claude-mem@thedotmack": true,
    "context7@claude-plugins-official": true,
    "superpowers@superpowers-marketplace": true
  }
}
EOF

echo ""
echo "========================================"
echo -e "${GREEN}✓ 安裝指引完成${NC}"
echo "========================================"
echo ""
echo "摘要 - 你需要的 Plugins:"
echo "  • superpowers - 核心 skills (TDD, debugging, brainstorming...)"
echo "  • claude-mem  - 跨對話記憶"
echo "  • context7    - 文件查詢"
echo ""
echo "你的個人 Skills 位置: ~/.claude/skills/"
echo "  • triage - 問題分流 skill"
echo ""
