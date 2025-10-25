#!/usr/bin/env python3
"""Package Material Symbols into Swift Package"""

import os
import json
import shutil
from pathlib import Path

# Configuration
MATERIAL_REPO = Path("material-design-icons")
OUTPUT_DIR = Path("Sources/MaterialSymbolsKit/Resources/Symbols.xcassets")
SYMBOLS_LIST = Path("scripts/popular_symbols.txt")
STYLE = "materialsymbolsrounded"

def create_xcassets():
    """Create xcassets directory and Contents.json"""
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    contents = {
        "info": {
            "author": "xcode",
            "version": 1
        }
    }
    with open(OUTPUT_DIR / "Contents.json", "w") as f:
        json.dump(contents, f, indent=2)

def read_symbols_list():
    """Read symbols from the list file"""
    symbols = []
    with open(SYMBOLS_LIST, "r") as f:
        for line in f:
            line = line.strip()
            # Skip comments and empty lines
            if line and not line.startswith("#"):
                symbols.append(line)
    return list(set(symbols))  # Remove duplicates

def package_symbol(symbol_name):
    """Package a single symbol"""
    # Find symbol file
    symbol_file = MATERIAL_REPO / "symbols" / "ios" / symbol_name / STYLE / f"{symbol_name}_symbol.svg"
    
    if not symbol_file.exists():
        return False, f"File not found: {symbol_file}"
    
    # Create symbolset directory
    symbolset_dir = OUTPUT_DIR / f"material.{symbol_name}.symbolset"
    symbolset_dir.mkdir(parents=True, exist_ok=True)
    
    # Copy symbol file
    dest_file = symbolset_dir / f"material.{symbol_name}.svg"
    shutil.copy2(symbol_file, dest_file)
    
    # Create Contents.json for the symbolset
    contents = {
        "info": {
            "author": "xcode",
            "version": 1
        },
        "symbols": [
            {
                "filename": f"material.{symbol_name}.svg",
                "idiom": "universal"
            }
        ]
    }
    
    with open(symbolset_dir / "Contents.json", "w") as f:
        json.dump(contents, f, indent=2)
    
    return True, None

def main():
    print("📦 Packaging Material Symbols")
    print("=" * 50)
    print(f"Source: {MATERIAL_REPO}/symbols/ios/")
    print(f"Style: {STYLE}")
    print(f"Output: {OUTPUT_DIR}")
    print()
    
    # Check if material-design-icons repo exists
    if not MATERIAL_REPO.exists():
        print("❌ Error: material-design-icons directory not found")
        print("\nPlease clone the repo:")
        print("  git clone --depth 1 https://github.com/google/material-design-icons.git")
        return 1
    
    # Create xcassets
    create_xcassets()
    
    # Read symbols list
    symbols = read_symbols_list()
    print(f"Found {len(symbols)} symbols to package\n")
    
    # Package each symbol
    packaged = 0
    skipped = 0
    
    for symbol_name in symbols:
        success, error = package_symbol(symbol_name)
        if success:
            print(f"✅ Packaged: {symbol_name}")
            packaged += 1
        else:
            print(f"⚠️  Skipped {symbol_name} - {error}")
            skipped += 1
    
    print()
    print("=" * 50)
    print("📊 Summary:")
    print(f"  Total symbols: {len(symbols)}")
    print(f"  Successfully packaged: {packaged}")
    print(f"  Skipped (not found): {skipped}")
    print()
    
    if packaged == 0:
        print("❌ No symbols were packaged!")
        return 1
    
    print("✨ Packaging complete!")
    print("\nNext steps:")
    print("  1. Run: python3 scripts/generate_enum.py")
    print("  2. Run: swift build")
    print("  3. Run: swift test")
    
    return 0

if __name__ == "__main__":
    exit(main())

