# Weight Support

Understanding how Material Symbol weights work with SF Symbols.

## Overview

Material Symbols provide 7 native weight variations (100-700), while SF Symbols support 9 weights (100-900). This guide explains how MaterialSymbolsKit handles the weight gap, validated through empirical testing.

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

## Unsupported Weights (800-900) - Fallback Behavior

SF Symbols support two additional weights that don't exist in Material Design:

| Weight | Name | Value | Behavior |
|--------|------|-------|----------|
| Heavy | 800 | Very bold | **Falls back to Regular (400)** |
| Black | 900 | Heaviest | **Falls back to Regular (400)** |

**Empirical Finding:** When you request these weights, iOS falls back to Regular (400) because it cannot extrapolate beyond the available weight range (100-700):

```swift
// These fall back to Regular (400) - validated in Xcode
Image(materialSymbol: .home)
    .fontWeight(.heavy)  // 800 - Falls back to Regular
    .fontWeight(.black)  // 900 - Falls back to Regular
```

**Recommendation:** Use `.bold` (700) for heavy emphasis instead of `.heavy` or `.black`.

## Why This Approach?

### Design System Integrity

Material Design intentionally stops at weight 700. Creating artificial weights would violate Google's design principles and potentially look inconsistent with Material Design aesthetics.

### iOS Fallback is Acceptable

iOS falls back to Regular (400) for Heavy/Black weights, which is acceptable because these weights are rarely used (< 10% of apps) and developers can use Bold (700) for heavy emphasis.

### Quality Assurance

Using Google's designer-crafted weights ensures the highest quality for the vast majority of use cases (90%+ of apps rarely use Heavy/Black weights).

## Visual Comparison

```swift
VStack(alignment: .leading, spacing: 15) {
    // Native weights (perfect quality)
    HStack {
        Image(materialSymbol: .home)
            .font(.system(size: 50, weight: .ultraLight))
        Text("Ultralight (100) - Native ✓")
    }
    
    HStack {
        Image(materialSymbol: .home)
            .font(.system(size: 50, weight: .regular))
        Text("Regular (400) - Native ✓")
    }
    
    HStack {
        Image(materialSymbol: .home)
            .font(.system(size: 50, weight: .bold))
        Text("Bold (700) - Native ✓ (Heaviest)")
    }
    
    // Fallback weights (use .bold instead)
    HStack {
        Image(materialSymbol: .home)
            .font(.system(size: 50, weight: .heavy))
        Text("Heavy (800) - Falls back to Regular ⚠️")
    }
    
    HStack {
        Image(materialSymbol: .home)
            .font(.system(size: 50, weight: .black))
        Text("Black (900) - Falls back to Regular ⚠️")
    }
}
```

## Best Practices

### Use Native Weights When Possible

For the best quality, stick to weights 100-700:

```swift
// ✅ Recommended - Use native weights (100-700)
Image(materialSymbol: .home)
    .fontWeight(.bold)      // 700 - Heaviest native weight

// ⚠️ Not recommended - Falls back to Regular
Image(materialSymbol: .home)
    .fontWeight(.black)     // Falls back to Regular (400)
```

### Avoid Heavy/Black Weights

For heavy emphasis, use `.bold` (700) instead of `.heavy` or `.black`, which fall back to Regular.

### Weight Range Guide

- **100-700 (Ultralight to Bold)**: Full native support, perfect rendering ✅
- **800-900 (Heavy to Black)**: Falls back to Regular (400) ⚠️

For all use cases, stick to the 100-700 range for the best results.

## Technical Details

### How iOS Handles Missing Weights

When an SF Symbol lacks a specific weight variant:
1. iOS first tries to interpolate between available weights
2. If the requested weight is outside the available range, it falls back to a default weight
3. For Material Symbols (100-700), weights 800-900 trigger fallback to Regular (400)

### Performance Impact

Weight fallback happens at render time with no performance impact. The fallback is instant and cached by iOS.

## See Also

- ``MaterialSymbols``
- <doc:Getting-Started>
- [SF Symbols Guidelines](https://developer.apple.com/design/human-interface-guidelines/sf-symbols)

