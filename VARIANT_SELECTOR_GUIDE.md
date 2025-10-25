# Material Symbols Variant Selector Guide

## Overview

MaterialSymbolsKit now supports **fill variants** and can package different **style variants** using the enhanced packaging script.

## Current Status

- **Packaged**: 87 symbols × 2 fills (outline, filled) = **174 total symbols**
- **Style**: Rounded only (for now)
- **Fill support**: ✅ WORKING

## Using Fill Variants

### SwiftUI

```swift
import SwiftUI
import MaterialSymbolsKit

// Outline (default)
Image(materialSymbol: .calendarToday)
    .font(.system(size: 50))

// Filled
Image(materialSymbol: .calendarToday, fill: .filled)
    .font(.system(size: 50))

// With font weight
Image(materialSymbol: .home, fill: .filled)
    .font(.system(size: 50, weight: .ultraLight))
```

### UIKit

```swift
import UIKit
import MaterialSymbolsKit

// Outline
let outlineIcon = UIImage(materialSymbol: .home)

// Filled
let filledIcon = UIImage(materialSymbol: .home, fill: .filled)
```

## Packaging Additional Variants

Use the variant selector script to package different combinations:

### Package Filled Variants Only

```bash
python3 scripts/package_symbols_variants.py \
  --styles rounded \
  --fills filled
```

### Package Multiple Styles

```bash
# Package all 3 styles with both fills
python3 scripts/package_symbols_variants.py \
  --styles rounded outlined sharp \
  --fills outline filled
```

This would package: 87 symbols × 3 styles × 2 fills = **522 total symbols**

### Package Outlined Style Only

```bash
python3 scripts/package_symbols_variants.py \
  --styles outlined \
  --fills outline filled
```

### Package Sharp Style Only

```bash
python3 scripts/package_symbols_variants.py \
  --styles sharp \
  --fills outline filled
```

## Available Options

### Styles

- `rounded` - Friendly, rounded corners (currently packaged)
- `outlined` - Clean, minimal aesthetic
- `sharp` - Angular, modern edges

### Fills

- `outline` - Stroke only, no fill (default)
- `filled` - Solid fill

## Usage Examples

```swift
// Different fills with rounded style
Image(materialSymbol: .favorite, fill: .outline)  // ♡
Image(materialSymbol: .favorite, fill: .filled)   // ♥

// Different styles (when packaged)
Image(materialSymbol: .home, style: .rounded)    // Currently available
Image(materialSymbol: .home, style: .outlined)   // Package with --styles outlined
Image(materialSymbol: .home, style: .sharp)      // Package with --styles sharp

// Combine style and fill
Image(materialSymbol: .star, style: .sharp, fill: .filled)

// Using configuration
Image(materialSymbol: .home, configuration: .roundedFilled)
Image(materialSymbol: .home, configuration: .outlined)
Image(materialSymbol: .home, configuration: .sharpFilled)
```

## Symbol Naming Convention

Packaged symbols follow this naming pattern:

```
material.{symbol_name}.{style}.{fill}
```

Examples:
- `material.home.rounded.fill0` (outline)
- `material.home.rounded.fill1` (filled)
- `material.home.outlined.fill0` (outlined style, outline)
- `material.home.sharp.fill1` (sharp style, filled)

## After Packaging Variants

After running the packaging script:

1. **Regenerate the enum**:
   ```bash
   python3 scripts/generate_enum.py
   ```

2. **Build the package**:
   ```bash
   swift build
   ```

3. **Run tests**:
   ```bash
   swift test
   ```

## Package Size Considerations

Each symbol variant increases package size:

- **Current**: 87 symbols × 2 fills = 174 symbolsets (~4-5 MB)
- **All styles**: 87 symbols × 3 styles × 2 fills = 522 symbolsets (~12-15 MB)

Choose variants based on your app's needs:
- **Minimal**: Rounded + Outline only (87 symbolsets)
- **Standard**: Rounded + Both fills (174 symbolsets) ← Current setup
- **Full**: All styles + Both fills (522 symbolsets)

## Troubleshooting

### Fill not showing?

Make sure you've:
1. Packaged the filled variant with the script
2. The symbol exists (some symbols may not have filled versions)
3. Using the correct style (if you packaged specific styles only)

### Symbol not found?

Check if the symbol was successfully packaged:
```bash
ls Sources/MaterialSymbolsKit/Resources/Symbols.xcassets/material.{symbol_name}.*.symbolset
```

### Want to add more symbols?

1. Add to `scripts/popular_symbols.txt`
2. Run the variant packaging script
3. Regenerate the enum
