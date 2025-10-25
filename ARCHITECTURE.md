# MaterialSymbolsKit Architecture

## Design Philosophy

**Simple by default, powerful when needed**

The API is designed to be:
1. **Progressive** - Start simple, add complexity only when needed
2. **Type-safe** - Compile-time validation prevents runtime errors
3. **Forward-compatible** - v1.0 API works unchanged in v1.1+
4. **Familiar** - Mirrors native iOS patterns

---

## API Architecture

### Core Components

```
MaterialSymbols (enum)           - Base symbol names
├─ MaterialSymbolStyle (enum)    - Visual styles: rounded, sharp, outlined
├─ MaterialSymbolFill (enum)     - Fill states: outline, filled
└─ MaterialSymbolConfiguration   - Preset configurations
```

### Usage Progression

```swift
// Level 1: Simple (v1.0)
Image(materialSymbol: .home)

// Level 2: Add fill (v1.1+)
Image(materialSymbol: .favorite, fill: .filled)

// Level 3: Add style (v1.1+)
Image(materialSymbol: .home, style: .sharp)

// Level 4: Full control (v1.1+)
Image(materialSymbol: .star, style: .sharp, fill: .filled)

// Level 5: Presets (v1.1+)
Image(materialSymbol: .home, configuration: .sharpFilled)
```

---

## Style Variants

Material Design provides 3 distinct visual styles:

### Rounded (Default)
- Friendly, approachable aesthetic
- Rounded corners on shapes
- **v1.0**: ✅ Included
- Example: `Image(materialSymbol: .home, style: .rounded)`

### Sharp
- Angular, modern aesthetic
- Sharp, 90-degree corners
- **v1.2**: Coming Q2 2025
- Example: `Image(materialSymbol: .home, style: .sharp)`

### Outlined
- Clean, minimal aesthetic
- Thin strokes, geometric precision
- **v1.2**: Coming Q2 2025
- Example: `Image(materialSymbol: .home, style: .outlined)`

---

## Fill States

Each symbol style supports 2 fill states:

### Outline (Default)
- Stroke only, no interior fill
- Google's naming: `fill0`
- **v1.0**: ✅ Included
- Example: `Image(materialSymbol: .home, fill: .outline)`

### Filled
- Solid interior fill
- Google's naming: `fill1`
- **v1.1**: Coming Q1 2025
- Example: `Image(materialSymbol: .favorite, fill: .filled)`

---

## Version Roadmap

### v1.0 (Current) - Foundation
**Scope**: 1 style × 1 fill × 100 symbols
```
✅ Rounded + Outline × 100 symbols
```

**Total**: 100 symbols

### v1.1 (Q1 2025) - Scale + Fill
**Scope**: 1 style × 2 fills × 3000 symbols
```
✅ Rounded + Outline × 3000 symbols (existing)
🆕 Rounded + Filled × 3000 symbols (new)
```

**Total**: 6,000 symbol variants

### v1.2 (Q2 2025) - Style Variants
**Scope**: 3 styles × 2 fills × 3000 symbols
```
✅ Rounded + Outline × 3000 symbols
✅ Rounded + Filled × 3000 symbols
🆕 Sharp + Outline × 3000 symbols (new)
🆕 Sharp + Filled × 3000 symbols (new)
🆕 Outlined + Outline × 3000 symbols (new)
🆕 Outlined + Filled × 3000 symbols (new)
```

**Total**: 18,000 symbol variants

---

## Implementation Details

### Symbol Naming Convention

```swift
// Internal naming
"material.{symbol}.{style}.{fill}"

// Examples:
"material.home.rounded.fill0"  // Rounded outline (v1.0)
"material.home.rounded.fill1"  // Rounded filled (v1.1+)
"material.home.sharp.fill0"    // Sharp outline (v1.2+)
"material.home.sharp.fill1"    // Sharp filled (v1.2+)
```

### Resource Organization

```
Symbols.xcassets/
├── material.home.symbolset/
│   ├── material.home.rounded.fill0.symbol  (v1.0)
│   ├── material.home.rounded.fill1.symbol  (v1.1+)
│   ├── material.home.sharp.fill0.symbol    (v1.2+)
│   ├── material.home.sharp.fill1.symbol    (v1.2+)
│   ├── material.home.outlined.fill0.symbol (v1.2+)
│   └── material.home.outlined.fill1.symbol (v1.2+)
```

### Fallback Strategy

For v1.0, when future styles/fills are requested:

```swift
func symbolName(style: MaterialSymbolStyle, fill: MaterialSymbolFill) -> String {
    // v1.0: Only rounded + outline packaged
    // Return base name, iOS will gracefully handle missing variants
    return rawValue  // "material.home"
    
    // v1.1+: Check for availability, return specific variant
    // return "material.\(name).\(style).\(fill)"
}
```

---

## API Examples

### Basic Usage (Works in all versions)

```swift
struct HomeView: View {
    var body: some View {
        VStack {
            // Simple - uses defaults
            Image(materialSymbol: .home)
            
            // With weight
            Image(materialSymbol: .home)
                .fontWeight(.bold)
            
            // With color
            Image(materialSymbol: .home)
                .foregroundStyle(.blue)
        }
    }
}
```

### Fill Variants (v1.1+)

```swift
struct FavoriteButton: View {
    @State private var isFavorite = false
    
    var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            Image(
                materialSymbol: .favorite,
                fill: isFavorite ? .filled : .outline
            )
            .foregroundStyle(isFavorite ? .red : .gray)
        }
    }
}
```

### Style Variants (v1.2+)

```swift
struct StylePicker: View {
    @State private var style: MaterialSymbolStyle = .rounded
    
    var body: some View {
        VStack {
            Picker("Style", selection: $style) {
                Text("Rounded").tag(MaterialSymbolStyle.rounded)
                Text("Sharp").tag(MaterialSymbolStyle.sharp)
                Text("Outlined").tag(MaterialSymbolStyle.outlined)
            }
            
            Image(materialSymbol: .home, style: style)
                .font(.system(size: 100))
        }
    }
}
```

### Configuration Presets (v1.1+)

```swift
struct IconGrid: View {
    var body: some View {
        Grid {
            GridRow {
                Image(materialSymbol: .home, configuration: .default)
                Image(materialSymbol: .home, configuration: .roundedFilled)
            }
            GridRow {
                Image(materialSymbol: .home, configuration: .sharp)
                Image(materialSymbol: .home, configuration: .sharpFilled)
            }
            GridRow {
                Image(materialSymbol: .home, configuration: .outlined)
                Image(materialSymbol: .home, configuration: .outlinedFilled)
            }
        }
    }
}
```

---

## Migration Path

### v1.0 → v1.1 (Seamless)

All v1.0 code works unchanged:

```swift
// v1.0 code
Image(materialSymbol: .home)

// Still works in v1.1, automatically uses default style/fill
// New: Can opt into filled variant
Image(materialSymbol: .home, fill: .filled)
```

### v1.1 → v1.2 (Seamless)

All v1.1 code works unchanged:

```swift
// v1.1 code
Image(materialSymbol: .home)
Image(materialSymbol: .home, fill: .filled)

// Still works in v1.2
// New: Can opt into style variants
Image(materialSymbol: .home, style: .sharp)
Image(materialSymbol: .home, style: .sharp, fill: .filled)
```

---

## Performance Considerations

### Bundle Size Growth

| Version | Symbols | Variants per Symbol | Total Files | Estimated Size |
|---------|---------|---------------------|-------------|----------------|
| v1.0 | 100 | 1 (rounded outline) | 100 | ~3 MB |
| v1.1 | 3000 | 2 (rounded × 2 fills) | 6,000 | ~150 MB |
| v1.2 | 3000 | 6 (3 styles × 2 fills) | 18,000 | ~450 MB |

### Mitigation Strategies

**v1.1**:
- On-demand resources for rarely-used symbols
- Separate Core (500 symbols) + Extended (2500 symbols) packages

**v1.2**:
- Separate packages per style:
  - `MaterialSymbolsKit` (rounded)
  - `MaterialSymbolsKitSharp` (sharp)
  - `MaterialSymbolsKitOutlined` (outlined)
- Users import only styles they need

### Loading Performance

Symbols load lazily by iOS:
- No upfront memory cost
- Cached by system
- Same performance as native SF Symbols

---

## Design Principles

### 1. Progressive Enhancement
Start simple, add complexity only when needed

### 2. Backward Compatibility
New features never break existing code

### 3. Type Safety
Compile-time validation prevents runtime errors

### 4. Familiar Patterns
API mirrors native iOS conventions

### 5. Forward Thinking
v1.0 API designed for v1.2 capabilities

---

## Future Considerations

### Variable Symbols (v2.0+)
Material Symbols support variable axes (weight, grade, optical size). Could be exposed as:

```swift
Image(materialSymbol: .home)
    .materialVariableValue(0.5) // Interpolate between states
```

### Custom Symbols (v2.0+)
Allow users to add their own Material-style symbols:

```swift
MaterialSymbols.register(
    name: "custom.icon",
    style: .rounded,
    symbolFile: "custom_icon.symbol"
)
```

---

## Conclusion

This architecture provides:
- ✅ Simple API for common cases
- ✅ Progressive enhancement for advanced needs
- ✅ Forward compatibility for future growth
- ✅ Type safety throughout
- ✅ Familiar iOS patterns

Users can start with v1.0 and seamlessly adopt v1.1/v1.2 features as they become available, without any code changes required.

