#!/bin/bash
# Process a batch of symbols for v1.1 scaling
# Usage: ./process_batch.sh [1-5]

set -e

BATCH_NUM=$1
MATERIAL_REPO="${MATERIAL_REPO:-material-design-icons}"
OUTPUT_DIR="Sources/MaterialSymbolsKit/Resources/Symbols.xcassets"
STYLE="materialsymbolsrounded"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

if [ -z "$BATCH_NUM" ]; then
    echo -e "${RED}Usage: $0 [1-5]${NC}"
    echo ""
    echo "Batch ranges:"
    echo "  1: A-E (~600 symbols)"
    echo "  2: F-J (~600 symbols)"
    echo "  3: K-O (~600 symbols)"
    echo "  4: P-T (~600 symbols)"
    echo "  5: U-Z (~600 symbols)"
    exit 1
fi

# Define batch pattern
case $BATCH_NUM in
    1) PATTERN="^[a-eA-E]"; RANGE="A-E" ;;
    2) PATTERN="^[f-jF-J]"; RANGE="F-J" ;;
    3) PATTERN="^[k-oK-O]"; RANGE="K-O" ;;
    4) PATTERN="^[p-tP-T]"; RANGE="P-T" ;;
    5) PATTERN="^[u-zU-Z0-9]"; RANGE="U-Z & Numbers" ;;
    *) echo -e "${RED}Invalid batch number. Use 1-5.${NC}"; exit 1 ;;
esac

echo "🚀 Processing Batch $BATCH_NUM: $RANGE"
echo "========================================"

# Check if material-design-icons exists
if [ ! -d "$MATERIAL_REPO" ]; then
    echo -e "${RED}❌ Error: $MATERIAL_REPO not found${NC}"
    echo "Clone first: git clone --depth 1 https://github.com/google/material-design-icons.git"
    exit 1
fi

# Generate symbol list for this batch
BATCH_LIST="scripts/batch_${BATCH_NUM}_symbols.txt"
echo "📋 Generating symbol list for batch $BATCH_NUM..."

# Find all symbol directories matching pattern
find "$MATERIAL_REPO/symbols/ios" -maxdepth 1 -type d | \
    sed 's|.*/||' | \
    grep -E "$PATTERN" | \
    sort > "$BATCH_LIST"

SYMBOL_COUNT=$(wc -l < "$BATCH_LIST" | tr -d ' ')
echo "✅ Found $SYMBOL_COUNT symbols in range $RANGE"
echo ""

# Run packaging script with batch list
echo "📦 Packaging symbols..."
SYMBOLS_LIST="$BATCH_LIST" ./scripts/package_symbols.sh

# Summary
echo ""
echo "========================================"
echo "📊 Batch $BATCH_NUM Summary:"
echo "  Range: $RANGE"
echo "  Symbols found: $SYMBOL_COUNT"
echo "  Batch list: $BATCH_LIST"
echo ""
echo "Next steps:"
echo "  1. Verify output in $OUTPUT_DIR"
echo "  2. Run: python3 scripts/generate_enum.py"
echo "  3. Run: swift build"
echo "  4. Run: swift test"
echo "  5. Commit: git add . && git commit -m 'Add batch $BATCH_NUM symbols ($RANGE)'"

