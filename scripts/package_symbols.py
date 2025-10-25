#!/usr/bin/env python3
"""Package Material Symbols into Swift Package"""

import os
import json
import shutil
import urllib.request
from pathlib import Path
from urllib.error import HTTPError, URLError

# Configuration
BASE_URL = "https://raw.githubusercontent.com/google/material-design-icons/master/symbols/ios"
OUTPUT_DIR = Path("Sources/MaterialSymbolsKit/Resources/Symbols.xcassets")
SYMBOLS_LIST = Path("scripts/popular_symbols.txt")
STYLE = "materialsymbolsrounded"
TEMP_DIR = Path("/tmp/material_symbols_download")

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

def download_symbol(symbol_name):
    """Download a single symbol SVG from GitHub"""
    url = f"{BASE_URL}/{symbol_name}/{STYLE}/{symbol_name}_symbol.svg"
    
    try:
        # Create temp directory if needed
        TEMP_DIR.mkdir(parents=True, exist_ok=True)
        
        # Download to temp file
        temp_file = TEMP_DIR / f"{symbol_name}_symbol.svg"
        urllib.request.urlretrieve(url, temp_file)
        return True, temp_file
    except HTTPError as e:
        if e.code == 404:
            return False, f"Symbol not found in Google's repo (404)"
        return False, f"HTTP error {e.code}: {e.reason}"
    except URLError as e:
        return False, f"Network error: {e.reason}"
    except Exception as e:
        return False, f"Download failed: {str(e)}"

def package_symbol(symbol_name):
    """Download and package a single symbol"""
    # Download symbol from GitHub
    success, result = download_symbol(symbol_name)
    
    if not success:
        return False, result  # result contains error message
    
    symbol_file = result  # result contains temp file path
    
    # Create symbolset directory
    symbolset_dir = OUTPUT_DIR / f"material.{symbol_name}.symbolset"
    symbolset_dir.mkdir(parents=True, exist_ok=True)
    
    # Copy symbol file to package
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
    print(f"Source: GitHub (downloading directly)")
    print(f"Style: {STYLE}")
    print(f"Output: {OUTPUT_DIR}")
    print()
    
    # Create xcassets
    create_xcassets()
    
    # Read symbols list
    symbols = read_symbols_list()
    print(f"Found {len(symbols)} symbols to download and package\n")
    
    # Package each symbol (downloads on-demand)
    packaged = 0
    skipped = 0
    
    for i, symbol_name in enumerate(symbols, 1):
        print(f"[{i}/{len(symbols)}] Downloading {symbol_name}...", end=" ")
        success, error = package_symbol(symbol_name)
        if success:
            print("✅")
            packaged += 1
        else:
            print(f"⚠️  {error}")
            skipped += 1
    
    print()
    print("=" * 50)
    print("📊 Summary:")
    print(f"  Total symbols: {len(symbols)}")
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

