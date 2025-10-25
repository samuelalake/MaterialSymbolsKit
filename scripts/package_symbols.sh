#!/bin/bash
# Package Material Symbols into Swift Package
# This script copies Google's SF Symbol templates into the package's xcassets

set -e

# Configuration
MATERIAL_REPO="${MATERIAL_REPO:-material-design-icons}"
OUTPUT_DIR="Sources/MaterialSymbolsKit/Resources/Symbols.xcassets"
SYMBOLS_LIST="${SYMBOLS_LIST:-scripts/popular_symbols.txt}"
STYLE="${STYLE:-materialsymbolsrounded}"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if material-design-icons repo exists
if [ ! -d "$MATERIAL_REPO" ]; then
    echo -e "${RED}❌ Error: $MATERIAL_REPO directory not found${NC}"
    echo ""
    echo "Please either:"
    echo "  1. Clone the repo: git clone --depth 1 https://github.com/google/material-design-icons.git"
    echo "  2. Set MATERIAL_REPO environment variable to the repo location"
    echo ""
    exit 1
fi

# Create xcassets directory and Contents.json
mkdir -p "$OUTPUT_DIR"
cat > "$OUTPUT_DIR/Contents.json" << 'EOF'
{
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF

# Counters
total_symbols=0
packaged_symbols=0
skipped_symbols=0

echo "📦 Packaging Material Symbols"
echo "================================"
echo "Source: $MATERIAL_REPO/symbols/ios/"
echo "Style: $STYLE"
echo "Output: $OUTPUT_DIR"
echo ""

# Process each symbol
while IFS= read -r symbol_name || [ -n "$symbol_name" ]; do
    # Skip comments and empty lines
    [[ "$symbol_name" =~ ^#.*$ ]] && continue
    [[ -z "$symbol_name" ]] && continue
    
    total_symbols=$((total_symbols + 1))
    
    # Find symbol file
    symbol_file="$MATERIAL_REPO/symbols/ios/$symbol_name/$STYLE/${symbol_name}_symbol.svg"
    
    if [ ! -f "$symbol_file" ]; then
        echo -e "${YELLOW}⚠️  Skipping $symbol_name - file not found${NC}"
        echo "    Expected: $symbol_file"
        skipped_symbols=$((skipped_symbols + 1))
        continue
    fi
    
    # Create symbolset directory
    symbolset_dir="$OUTPUT_DIR/material.$symbol_name.symbolset"
    mkdir -p "$symbolset_dir"
    
    # Copy symbol file (keep .svg extension - Xcode handles it)
    cp "$symbol_file" "$symbolset_dir/material.$symbol_name.svg"
    
    # Create Contents.json for the symbolset
    cat > "$symbolset_dir/Contents.json" << EOF
{
  "info" : {
    "author" : "xcode",
    "version" : 1
  },
  "symbols" : [
    {
      "filename" : "material.$symbol_name.svg",
      "idiom" : "universal"
    }
  ]
}
EOF
    
    packaged_symbols=$((packaged_symbols + 1))
    echo -e "${GREEN}✅ Packaged: $symbol_name${NC}"
done < "$SYMBOLS_LIST"

echo ""
echo "================================"
echo "📊 Summary:"
echo "  Total symbols processed: $total_symbols"
echo "  Successfully packaged: $packaged_symbols"
echo "  Skipped (not found): $skipped_symbols"
echo ""

if [ $packaged_symbols -eq 0 ]; then
    echo -e "${RED}❌ No symbols were packaged!${NC}"
    exit 1
fi

echo -e "${GREEN}✨ Packaging complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Run: python3 scripts/generate_enum.py"
echo "  2. Run: swift build"
echo "  3. Run: swift test"

