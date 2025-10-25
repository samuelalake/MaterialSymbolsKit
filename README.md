# MaterialSymbolsKit

> Material Design symbols as type-safe SF Symbols for iOS, macOS, watchOS, and tvOS

[![Swift](https://img.shields.io/badge/Swift-6.1-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20|%20macOS%20|%20watchOS%20|%20tvOS-blue.svg)](https://developer.apple.com)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

MaterialSymbolsKit brings Google's Material Symbols to Apple platforms in SF Symbol format, providing type-safe access to 100+ (expanding to 3000+) beautifully designed icons.

## Features

- ✅ **Type-Safe API**: Compile-time symbol validation with `Image(materialSymbol: .home)`
- ✅ **7 Native Weights**: Ultralight through Bold (100-700); Heavy/Black fallback to Regular
- ✅ **Full SF Symbol Support**: Works with all rendering modes, animations, and effects
- ✅ **Cross-Platform**: iOS 16+, macOS 13+, watchOS 9+, tvOS 16+
- ✅ **Zero Dependencies**: Pure Swift, no external dependencies
- ✅ **SwiftUI & UIKit**: Extensions for both frameworks

## Installation

### Swift Package Manager

Add MaterialSymbolsKit to your project:

```swift
dependencies: [
    .package(url: "https://github.com/samuelalake/MaterialSymbolsKit.git", from: "1.0.0")
]
```

## Quick Start

```swift
import SwiftUI
import MaterialSymbolsKit

struct ContentView: View {
    var body: some View {
        VStack {
            // Simple usage (defaults: rounded style, outline fill)
            Image(materialSymbol: .home)
                .font(.largeTitle)
            
            // With weight styling
            Image(materialSymbol: .search)
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.blue)
            
            // With fill variant (v1.1+)
            Image(materialSymbol: .favorite, fill: .filled)
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            // With style variant (v1.1+)
            Image(materialSymbol: .settings, style: .sharp)
                .font(.largeTitle)
            
            // With both style and fill (v1.1+)
            Image(materialSymbol: .star, style: .sharp, fill: .filled)
                .font(.largeTitle)
                .foregroundStyle(.orange)
            
            // In labels
            Label("Settings", materialSymbol: .settings)
            Label("Favorites", materialSymbol: .favorite, fill: .filled)
            
            // In buttons
            Button(action: {}) {
                Image(materialSymbol: .add)
            }
        }
    }
}
```

## Usage

### SwiftUI

```swift
// Basic image (defaults to rounded, outline)
Image(materialSymbol: .home)

// With weight and color
Image(materialSymbol: .favorite)
    .font(.system(size: 50, weight: .semibold))
    .foregroundStyle(.red)
    .symbolRenderingMode(.hierarchical)

// With fill variant (v1.1+)
Image(materialSymbol: .favorite, fill: .filled)
    .foregroundStyle(.red)

// With style variant (v1.1+)
Image(materialSymbol: .home, style: .sharp)
Image(materialSymbol: .home, style: .outlined)

// With both style and fill (v1.1+)
Image(materialSymbol: .star, style: .sharp, fill: .filled)

// Using configuration presets (v1.1+)
Image(materialSymbol: .home, configuration: .sharpFilled)
Image(materialSymbol: .home, configuration: .outlined)

// In labels
Label("Home", materialSymbol: .home)
Label("Favorites", materialSymbol: .favorite, fill: .filled)
Label {
    Text("Custom Label")
} icon: {
    Image(materialSymbol: .star, style: .sharp)
}
```

### UIKit

```swift
import MaterialSymbolsKit

// Create UIImage
let image = UIImage(materialSymbol: .home)
imageView.image = image

// With fill variant (v1.1+)
let filled = UIImage(materialSymbol: .favorite, fill: .filled)

// With style variant (v1.1+)
let sharp = UIImage(materialSymbol: .home, style: .sharp)

// With both (v1.1+)
let sharpFilled = UIImage(materialSymbol: .star, style: .sharp, fill: .filled)

// With configuration
let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)
let image = UIImage(materialSymbol: .search)?
    .withConfiguration(config)
```

### AppKit (macOS)

```swift
import MaterialSymbolsKit

// Create NSImage
let image = NSImage(materialSymbol: .home)
imageView.image = image

// With style and fill (v1.1+)
let sharpFilled = NSImage(materialSymbol: .home, style: .sharp, fill: .filled)
```

## Weight Support

Material Symbols include **7 native weights** (100-700):
- Ultralight (100)
- Thin (200)
- Light (300)
- Regular (400)
- Medium (500)
- Semibold (600)
- Bold (700)

**Heavy (800) and Black (900)** weights fall back to Regular (400) as iOS cannot extrapolate beyond the available weight range. For best visual results, use weights from Ultralight (100) to Bold (700).

```swift
// Native weights - perfect rendering
Image(materialSymbol: .home)
    .fontWeight(.ultraLight)  // 100 - Native
    .fontWeight(.regular)     // 400 - Native
    .fontWeight(.bold)        // 700 - Native (heaviest available)

// Unsupported weights - fallback to Regular
Image(materialSymbol: .home)
    .fontWeight(.heavy)  // 800 - Falls back to Regular (400)
    .fontWeight(.black)  // 900 - Falls back to Regular (400)
```

## Available Symbols

### v1.0 (Current)
- **Count**: 100 carefully curated symbols
- **Style**: Rounded only
- **Fill**: Outline only (default)
- **Coverage**: Navigation, actions, communication, media, content, files, and more

### Styles & Fill States

Material Symbols come in **3 visual styles**:
- **Rounded** (default) - Friendly, approachable corners
- **Outlined** - Clean, minimal aesthetic  
- **Sharp** - Angular, modern edges

And **2 fill states**:
- **Outline** (default) - Stroke only, no fill
- **Filled** - Solid fill

```swift
// v1.0: Rounded + Outline (default)
Image(materialSymbol: .home)

// v1.1+: All combinations
Image(materialSymbol: .home, style: .rounded, fill: .outline)  // Default
Image(materialSymbol: .home, style: .rounded, fill: .filled)   // Rounded filled
Image(materialSymbol: .home, style: .sharp, fill: .outline)    // Sharp outline
Image(materialSymbol: .home, style: .sharp, fill: .filled)     // Sharp filled
Image(materialSymbol: .home, style: .outlined, fill: .outline) // Outlined outline
Image(materialSymbol: .home, style: .outlined, fill: .filled)  // Outlined filled
```

**Note**: v1.0 ships with rounded outline variants only. API supports all styles/fills for forward compatibility.

See [SYMBOLS_SELECTION.md](SYMBOLS_SELECTION.md) for the complete list and rationale.

## Roadmap

### v1.1 - Full Symbol Set (Q1 2025)
- Expand to 3000+ symbols (from 100)
- Automated batch processing
- **Filled variants** (fill1) for all symbols
- Performance optimizations

### v1.2 - Style Variants (Q2 2025)
- **Sharp style** variant (3000+ symbols)
- **Outlined style** variant (3000+ symbols)
- Total: 9000+ symbols (3 styles × 2 fills × ~3000 base symbols)

### v2.0 - Advanced Features (Q3 2025)
- Symbol search and discovery
- Category-based collections
- Custom symbol bundles
- Modular packages (Core + Extended)

## Building from Source

```bash
# Clone the repository
git clone https://github.com/samuelalake/MaterialSymbolsKit.git
cd MaterialSymbolsKit

# Download Material Design Icons (optional - for regenerating symbols)
git clone --depth 1 https://github.com/google/material-design-icons.git

# Package symbols
./scripts/package_symbols.sh

# Generate enum
python3 scripts/generate_enum.py

# Build
swift build

# Test
swift test
```

## Documentation

Full documentation is available at [Documentation Link].

- [Getting Started Guide](Documentation/MaterialSymbolsKit.docc/Getting-Started.md)
- [Weight Support Details](Documentation/MaterialSymbolsKit.docc/Weight-Support.md)
- [API Reference](Documentation/MaterialSymbolsKit.docc/MaterialSymbolsKit.md)

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

Areas for contribution:
- Example apps and tutorials
- Documentation improvements
- Symbol category collections
- Performance optimizations

## License

MaterialSymbolsKit is released under the Apache License 2.0. See [LICENSE](LICENSE) for details.

Material Symbols are created by Google and licensed under [Apache License 2.0](https://github.com/google/material-design-icons/blob/master/LICENSE).

## Acknowledgments

- Material Symbols by [Google](https://github.com/google/material-design-icons)
- SF Symbols by [Apple](https://developer.apple.com/sf-symbols/)

## Author

**Samuel Alake**  
Product Designer | Aspiring Design Engineer  
- GitHub: [@samuealake](https://github.com/samuealake)
- Project: [MaterialSymbolsKit](https://github.com/samuealake/MaterialSymbolsKit)

Built with ❤️ for the iOS community

---

**Note**: This package provides Material Symbols in SF Symbol format for use in Apple platform applications. It is not affiliated with or endorsed by Google or Apple.

