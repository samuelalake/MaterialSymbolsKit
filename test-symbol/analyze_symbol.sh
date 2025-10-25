#!/bin/bash
# analyze_symbol.sh - Analyze SF Symbol template structure

set -e

SYMBOL_FILE="home_symbol.svg"

echo "📊 Analyzing SF Symbol Template: $SYMBOL_FILE"
echo "================================================"
echo ""

# Check if file exists
if [ ! -f "$SYMBOL_FILE" ]; then
    echo "❌ Error: $SYMBOL_FILE not found"
    exit 1
fi

echo "✅ File found: $SYMBOL_FILE"
echo ""

# Check template version
echo "🔍 Template Version:"
grep -o 'Template v\.[0-9.]*' "$SYMBOL_FILE" || echo "  Version info not found"
echo ""

# Count weight variations
echo "⚖️  Weight Variations:"
echo "  Looking for weight groups..."
for weight in Ultralight Thin Light Regular Medium Semibold Bold Heavy Black; do
    count=$(grep -c "id=\"$weight-" "$SYMBOL_FILE" || echo "0")
    if [ "$count" -gt 0 ]; then
        echo "  ✅ $weight: $count variations found"
    else
        echo "  ❌ $weight: MISSING"
    fi
done
echo ""

# Count size scales
echo "📏 Size Scales:"
for size in Small Medium Large; do
    count=$(grep -c "id=\".*-${size:0:1}\"" "$SYMBOL_FILE" || echo "0")
    echo "  $size: $count elements"
done
echo ""

# Check for path data in Heavy/Black
echo "🔬 Checking Heavy/Black Weight Data:"
if grep -q 'id="Heavy-' "$SYMBOL_FILE"; then
    heavy_has_path=$(grep -A 5 'id="Heavy-S"' "$SYMBOL_FILE" | grep -c '<path' || echo "0")
    if [ "$heavy_has_path" -gt 0 ]; then
        echo "  ✅ Heavy weight HAS path data"
    else
        echo "  ⚠️  Heavy weight group exists but NO path data"
    fi
else
    echo "  ❌ Heavy weight group not found"
fi

if grep -q 'id="Black-' "$SYMBOL_FILE"; then
    black_has_path=$(grep -A 5 'id="Black-S"' "$SYMBOL_FILE" | grep -c '<path' || echo "0")
    if [ "$black_has_path" -gt 0 ]; then
        echo "  ✅ Black weight HAS path data"
    else
        echo "  ⚠️  Black weight group exists but NO path data"
    fi
else
    echo "  ❌ Black weight group not found"
fi
echo ""

# File size
echo "💾 File Size:"
size=$(ls -lh "$SYMBOL_FILE" | awk '{print $5}')
echo "  $size"
echo ""

# Preview path structure (first few groups)
echo "📝 Structure Preview (first few weight groups):"
grep -o 'id="[A-Za-z]*-[SML]"' "$SYMBOL_FILE" | head -15
echo ""

# Summary
echo "================================================"
echo "📋 SUMMARY"
echo "================================================"

working_weights=$(grep -o 'id="[A-Za-z]*-[SML]"' "$SYMBOL_FILE" | sed 's/id="\(.*\)-."/\1/' | sort -u | wc -l | tr -d ' ')
echo "✅ Working weights: $working_weights"

if grep -q 'id="Heavy-' "$SYMBOL_FILE" && ! grep -A 5 'id="Heavy-S"' "$SYMBOL_FILE" | grep -q '<path'; then
    echo "⚠️  Heavy weight: Template exists but NO data"
fi

if grep -q 'id="Black-' "$SYMBOL_FILE" && ! grep -A 5 'id="Black-S"' "$SYMBOL_FILE" | grep -q '<path'; then
    echo "⚠️  Black weight: Template exists but NO data"
fi

echo ""
echo "🎯 RECOMMENDATION:"
if [ "$working_weights" -ge 7 ]; then
    echo "   ✅ OPTION 1: Package as-is with $working_weights weights"
    echo "   ✨ High quality, fast implementation"
    echo "   ⚡️ iOS will interpolate missing weights if requested"
else
    echo "   ⚠️  Only $working_weights weights found"
    echo "   Consider investigating further or generating missing weights"
fi

echo ""
echo "================================================"

