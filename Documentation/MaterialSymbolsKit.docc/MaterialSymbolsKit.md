# ``MaterialSymbolsKit``

Material Design symbols as type-safe SF Symbols for iOS, macOS, watchOS, and tvOS.

## Overview

MaterialSymbolsKit bridges Google's Material Design and Apple's ecosystem by providing 100+ Material Symbols in SF Symbol format with a type-safe Swift API.

### Key Features

- **Type-Safe Access**: Use `Image(materialSymbol: .home)` instead of error-prone strings
- **Full SF Symbol Support**: Works with all weights, rendering modes, and animations
- **Cross-Platform**: iOS 16+, macOS 13+, watchOS 9+, tvOS 16+
- **7 Native Weights**: Ultralight through Bold with iOS interpolation for heavier weights
- **Zero Dependencies**: Pure Swift implementation

### Quick Example

```swift
import SwiftUI
import MaterialSymbolsKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Simple usage
            Image(materialSymbol: .home)
                .font(.largeTitle)
            
            // Styled
            Image(materialSymbol: .favorite)
                .font(.system(size: 50, weight: .bold))
                .foregroundStyle(.red)
                .symbolRenderingMode(.hierarchical)
            
            // In labels
            Label("Settings", materialSymbol: .settings)
        }
    }
}
```

## Topics

### Essentials

- ``MaterialSymbols``
- ``Image/init(materialSymbol:)``

### Labels

- ``Label/init(_:materialSymbol:)-swift.type.method``

### Platform Support

- ``UIImage/init(materialSymbol:)``
- ``NSImage/init(materialSymbol:)``

### Articles

- <doc:Getting-Started>
- <doc:Weight-Support>

## See Also

- [Material Symbols](https://fonts.google.com/icons)
- [SF Symbols](https://developer.apple.com/sf-symbols/)

