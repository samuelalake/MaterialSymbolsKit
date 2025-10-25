#!/usr/bin/env python3
"""Package Material Symbols with support for style and fill variants"""

import os
import json
import shutil
import urllib.request
from pathlib import Path
from urllib.error import HTTPError, URLError
import argparse

# Configuration
BASE_URL = "https://raw.githubusercontent.com/google/material-design-icons/master/symbols/ios"
OUTPUT_DIR = Path("Sources/MaterialSymbolsKit/Resources/Symbols.xcassets")
SYMBOLS_LIST = Path("scripts/popular_symbols.txt")
TEMP_DIR = Path("/tmp/material_symbols_download")

# Available variants
STYLES = {
    'rounded': 'materialsymbolsrounded',
    'outlined': 'materialsymbolsoutlined',
    'sharp': 'materialsymbolssharp'
}

FILLS = {
    'outline': '',  # No suffix for outline
    'filled': '_fill1'  # fill1 suffix for filled
}

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

def download_symbol(symbol_name, style_key, fill_key):
    """Download a single symbol SVG from GitHub

    Args:
        symbol_name: Base symbol name (e.g., 'home')
        style_key: Style variant key ('rounded', 'outlined', 'sharp')
        fill_key: Fill variant key ('outline', 'filled')

    Returns:
        (success, result): success is bool, result is temp_file path or error message
    """
    style_name = STYLES[style_key]
    fill_suffix = FILLS[fill_key]

    # Build URL: {symbol_name}/{style}/{symbol_name}{fill_suffix}_symbol.svg
    url = f"{BASE_URL}/{symbol_name}/{style_name}/{symbol_name}{fill_suffix}_symbol.svg"

    try:
        # Create temp directory if needed
        TEMP_DIR.mkdir(parents=True, exist_ok=True)

        # Download to temp file
        temp_file = TEMP_DIR / f"{symbol_name}_{style_key}_{fill_key}.svg"
        urllib.request.urlretrieve(url, temp_file)
        return True, temp_file
    except HTTPError as e:
        if e.code == 404:
            return False, "404"
        return False, f"HTTP error {e.code}"
    except URLError as e:
        return False, f"Network error: {e.reason}"
    except Exception as e:
        return False, f"Download failed: {str(e)}"

def package_symbol(symbol_name, style_key, fill_key):
    """Download and package a single symbol variant

    Args:
        symbol_name: Base symbol name (e.g., 'home')
        style_key: Style variant ('rounded', 'outlined', 'sharp')
        fill_key: Fill variant ('outline', 'filled')

    Returns:
        (success, error_message)
    """
    # Download symbol from GitHub
    success, result = download_symbol(symbol_name, style_key, fill_key)

    if not success:
        return False, result  # result contains error message

    symbol_file = result  # result contains temp file path

    # Create symbolset directory
    # Naming: material.{symbol}.{style}.{fill}
    # e.g., material.home.rounded.fill0
    fill_suffix = "fill0" if fill_key == "outline" else "fill1"
    symbolset_name = f"material.{symbol_name}.{style_key}.{fill_suffix}"
    symbolset_dir = OUTPUT_DIR / f"{symbolset_name}.symbolset"
    symbolset_dir.mkdir(parents=True, exist_ok=True)

    # Copy symbol file to package
    dest_file = symbolset_dir / f"{symbolset_name}.svg"
    shutil.copy2(symbol_file, dest_file)

    # Create Contents.json for the symbolset
    contents = {
        "info": {
            "author": "xcode",
            "version": 1
        },
        "symbols": [
            {
                "filename": f"{symbolset_name}.svg",
                "idiom": "universal"
            }
        ]
    }

    with open(symbolset_dir / "Contents.json", "w") as f:
        json.dump(contents, f, indent=2)

    return True, None

def main():
    parser = argparse.ArgumentParser(description='Package Material Symbols with variant support')
    parser.add_argument('--styles', nargs='+',
                       choices=['rounded', 'outlined', 'sharp'],
                       default=['rounded'],
                       help='Style variants to package (default: rounded)')
    parser.add_argument('--fills', nargs='+',
                       choices=['outline', 'filled'],
                       default=['outline', 'filled'],
                       help='Fill variants to package (default: both)')

    args = parser.parse_args()

    print("📦 Packaging Material Symbols with Variants")
    print("=" * 50)
    print(f"Source: GitHub (downloading directly)")
    print(f"Styles: {', '.join(args.styles)}")
    print(f"Fills: {', '.join(args.fills)}")
    print(f"Output: {OUTPUT_DIR}")
    print()

    # Create xcassets
    create_xcassets()

    # Read symbols list
    symbols = read_symbols_list()
    total_variants = len(symbols) * len(args.styles) * len(args.fills)
    print(f"Found {len(symbols)} symbols")
    print(f"Total variants to package: {total_variants}\n")

    # Package each symbol variant
    packaged = 0
    skipped = 0
    variant_count = 0

    for symbol_name in symbols:
        for style in args.styles:
            for fill in args.fills:
                variant_count += 1
                variant_label = f"{symbol_name} ({style}, {fill})"
                print(f"[{variant_count}/{total_variants}] {variant_label}...", end=" ")

                success, error = package_symbol(symbol_name, style, fill)
                if success:
                    print("✅")
                    packaged += 1
                else:
                    if error == "404":
                        print("⚠️  Not found")
                    else:
                        print(f"⚠️  {error}")
                    skipped += 1

    print()
    print("=" * 50)
    print("📊 Summary:")
    print(f"  Total variants attempted: {total_variants}")
    print(f"  Successfully packaged: {packaged}")
    print(f"  Skipped (not found): {skipped}")
    print()

    # Cleanup temp directory
    if TEMP_DIR.exists():
        shutil.rmtree(TEMP_DIR)
        print("🧹 Cleaned up temporary files")
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
