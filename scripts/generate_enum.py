#!/usr/bin/env python3
"""
Generate MaterialSymbols.swift enum from packaged symbols

This script scans the Symbols.xcassets directory and generates
a Swift enum with cases for all packaged symbols.
"""

import os
import sys
from pathlib import Path

def get_packaged_symbols(xcassets_dir):
    """Find all .symbolset directories and extract symbol names"""
    symbols = []
    
    if not os.path.exists(xcassets_dir):
        print(f"❌ Error: {xcassets_dir} does not exist")
        print(f"   Run package_symbols.sh first to package symbols")
        return []
    
    for item in os.listdir(xcassets_dir):
        if item.endswith('.symbolset') and item.startswith('material.'):
            # Extract symbol name from material.{name}.symbolset
            symbol_name = item.replace('material.', '').replace('.symbolset', '')
            symbols.append(symbol_name)
    
    return sorted(symbols)

def symbol_name_to_swift_case(symbol_name):
    """Convert symbol name to valid Swift enum case name"""
    # Replace hyphens and underscores with nothing (camelCase)
    case_name = symbol_name.replace('-', '_').replace('_', '')
    
    # If starts with digit, prefix with underscore
    if case_name and case_name[0].isdigit():
        case_name = '_' + case_name
    
    # Convert to camelCase
    parts = symbol_name.split('_')
    if parts:
        case_name = parts[0] + ''.join(word.capitalize() for word in parts[1:])
    
    # Handle special keywords
    swift_keywords = ['case', 'class', 'default', 'enum', 'extension', 'func', 
                      'import', 'protocol', 'return', 'static', 'struct', 'var']
    if case_name in swift_keywords:
        case_name = '`' + case_name + '`'
    
    return case_name

def generate_enum_file(symbols, output_file):
    """Generate the MaterialSymbols.swift file"""
    
    code = '''/// Material Symbols as SF Symbols for iOS
///
/// This package provides Material Design symbols in SF Symbol format,
/// enabling type-safe usage with SwiftUI and UIKit.
///
/// ## Weight Support
/// Material Symbols include 7 native weights (100-700):
/// - Ultralight, Thin, Light, Regular, Medium, Semibold, Bold
///
/// Heavy (800) and Black (900) weights are interpolated by iOS from Bold (700).
///
/// ## Usage
/// ```swift
/// import SwiftUI
/// import MaterialSymbolsKit
///
/// Image(materialSymbol: .home)
///     .font(.largeTitle)
/// ```
public enum MaterialSymbols: String, CaseIterable, Sendable {
'''
    
    if not symbols:
        code += '    // No symbols packaged yet - run package_symbols.sh first\n'
        code += '    case placeholder = "material.placeholder"\n'
    else:
        for symbol in symbols:
            swift_case = symbol_name_to_swift_case(symbol)
            code += f'    case {swift_case} = "material.{symbol}"\n'
    
    code += '}\n'
    
    # Write file
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, 'w') as f:
        f.write(code)
    
    return len(symbols)

def main():
    # Paths
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    xcassets_dir = project_root / "Sources" / "MaterialSymbolsKit" / "Resources" / "Symbols.xcassets"
    output_file = project_root / "Sources" / "MaterialSymbolsKit" / "MaterialSymbols.swift"
    
    print("🔍 Scanning packaged symbols...")
    symbols = get_packaged_symbols(str(xcassets_dir))
    
    if not symbols:
        print("⚠️  No symbols found - generating placeholder enum")
    else:
        print(f"✅ Found {len(symbols)} packaged symbols")
    
    print(f"📝 Generating {output_file}...")
    count = generate_enum_file(symbols, str(output_file))
    
    print(f"✨ Generated MaterialSymbols.swift with {count} cases")
    
    if symbols:
        print("\nSample symbols:")
        for symbol in symbols[:10]:
            case_name = symbol_name_to_swift_case(symbol)
            print(f"  - MaterialSymbols.{case_name}")
        
        if len(symbols) > 10:
            print(f"  ... and {len(symbols) - 10} more")

if __name__ == '__main__':
    main()

