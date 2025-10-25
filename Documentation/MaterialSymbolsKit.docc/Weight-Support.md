# Weight Support

Understanding how Material Symbol weights work with SF Symbols.

## Overview

Material Symbols provide 7 native weight variations (100-700), while SF Symbols support 9 weights (100-900). MaterialSymbolsKit handles this gracefully using iOS's built-in interpolation.

## Native Weights (100-700)

Material Design defines these weights:

| Weight | Name | Value |
|--------|------|-------|
| Ultralight | 100 | Thinnest strokes |
| Thin | 200 | Very light |
| Light | 300 | Light |
| Regular | 400 | **Default** |
| Medium | 500 | Slightly heavier |
| Semibold | 600 | Bold |
| Bold | 700 | **Heaviest native** |

These weights are designed by Google's Material Design team and render perfectly:

```swift
// All these use native, designer-crafted weights
Image(materialSymbol: .home)
    .fontWeight(.ultraLight)  // 100
    .fontWeight(.thin)        // 200
    .fontWeight(.light)       // 300
    .fontWeight(.regular)     // 400
    .fontWeight(.medium)      // 500
    .fontWeight(.semibold)    // 600
    .fontWeight(.bold)        // 700
```

## Interpolated Weights (800-900)

SF Symbols support two additional weights that don't exist in Material Design:

| Weight | Name | Value | Source |
|--------|------|-------|--------|
| Heavy | 800 | Very bold | **iOS interpolated** |
| Black | 900 | Heaviest | **iOS interpolated** |

When you request these weights, iOS automatically creates them from Bold (700):

```swift
// iOS automatically interpolates these from .bold
Image(materialSymbol: .home)
    .fontWeight(.heavy)  // 800 - interpolated
    .fontWeight(.black)  // 900 - interpolated
```

## Why This Approach?

### Design System Integrity

Material Design intentionally stops at weight 700. Creating artificial weights would violate Google's design principles and potentially look inconsistent with Material Design aesthetics.

### iOS Handles It Well

iOS's interpolation algorithm is sophisticated and produces excellent results. For most use cases, the interpolated weights are indistinguishable from native ones.

### Quality Assurance

Using Google's designer-crafted weights ensures the highest quality for the vast majority of use cases (90%+ of apps rarely use Heavy/Black weights).

## Visual Comparison

```swift
VStack(alignment: .leading, spacing: 15) {
    // Native (perfect quality)
    HStack {
        Image(materialSymbol: .home)
            .font(.system(size: 50, weight: .bold))
        Text("Bold (700) - Native ✓")
    }
    
    // Interpolated (excellent quality)
    HStack {
        Image(materialSymbol: .home)
            .font(.system(size: 50, weight: .heavy))
        Text("Heavy (800) - Interpolated")
    }
    
    HStack {
        Image(materialSymbol: .home)
            .font(.system(size: 50, weight: .black))
        Text("Black (900) - Interpolated")
    }
}
```

## Best Practices

### Use Native Weights When Possible

For the best quality, stick to weights 100-700:

```swift
// Preferred
Image(materialSymbol: .home)
    .fontWeight(.bold)      // Native weight

// Works well, but interpolated
Image(materialSymbol: .home)
    .fontWeight(.black)     // Interpolated
```

### Test Interpolated Weights

If you need Heavy or Black weights, test them visually at your target sizes to ensure quality meets your standards.

### Consider Context

- **Small sizes (< 30pt)**: Interpolation works excellently
- **Large sizes (> 60pt)**: May want to stick to native weights
- **Print/high-DPI**: Native weights recommended

## Technical Details

### How iOS Interpolates

iOS uses the Bold (700) weight paths and algorithmically:
1. Increases stroke width proportionally
2. Adjusts curves to maintain shape integrity
3. Applies anti-aliasing for smooth rendering

### Performance Impact

Weight interpolation happens at render time with negligible performance impact. iOS caches interpolated results, so repeated renders are fast.

## See Also

- ``MaterialSymbols``
- <doc:Getting-Started>
- [SF Symbols Guidelines](https://developer.apple.com/design/human-interface-guidelines/sf-symbols)

