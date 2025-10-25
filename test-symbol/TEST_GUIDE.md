# Testing One Material Symbol - Step by Step Guide

## What We Found

Downloaded `home_symbol.svg` from Google's Material Design Icons repository.

**Template Analysis:**
- ✅ SF Symbol Template v.1.0 format
- ✅ Has 7 weights: Ultralight, Thin, Light, Regular, Medium, Semibold, Bold
- ❌ Heavy and Black slots exist but are EMPTY (no path data)
- ✅ 3 size scales: Small, Medium, Large

## Option A: Test As-Is (Use Google's 7-Weight Template)

### Step 1: Copy Symbol to Test Project
```bash
cd /Users/samuelalake/Developer/Apps/Swift/MaterialSymbolsKit
mkdir -p TestApp/TestApp/Assets.xcassets/material.home.symbolset
cp test-symbol/home_symbol.svg TestApp/TestApp/Assets.xcassets/material.home.symbolset/
```

### Step 2: Create Test Xcode Project
```bash
# Create new iOS App project
# File > New > Project > iOS > App
# Name: MaterialSymbolTest
# Interface: SwiftUI
```

### Step 3: Import Symbol
1. Open `Assets.xcassets` in Xcode
2. Right-click → New Symbol Set → name: `material.home`
3. Drag `home_symbol.svg` into the symbol set
4. Xcode will parse the template

### Step 4: Test in SwiftUI
```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Material Symbol Test")
                .font(.title)
            
            // Test all available weights
            HStack(spacing: 10) {
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .ultraLight))
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .thin))
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .light))
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .regular))
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .medium))
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .semibold))
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .bold))
            }
            
            // Test missing weights (iOS will interpolate)
            HStack(spacing: 10) {
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .heavy))
                Text("Heavy (interpolated)")
                
                Image(systemName: "material.home")
                    .font(.system(size: 40, weight: .black))
                Text("Black (interpolated)")
            }
            
            // Test sizing
            HStack(spacing: 10) {
                Image(systemName: "material.home")
                    .font(.system(size: 20))
                Image(systemName: "material.home")
                    .font(.system(size: 40))
                Image(systemName: "material.home")
                    .font(.system(size: 60))
            }
        }
        .padding()
    }
}
```

### Expected Results:
- ✅ All 7 weights render perfectly
- ⚠️ Heavy/Black may look identical to Bold or slightly interpolated
- ✅ Scales properly at different sizes
- ✅ Works with SF Symbol modifiers (colors, rendering modes)

---

## Option B: Generate Heavy + Black Weights with SwiftDraw

### Step 1: Install SwiftDraw
```bash
brew install swiftdraw
```

### Step 2: Extract Bold Variant
The SF Symbol template has all weights embedded. We need to extract just the Bold variant to use as source for generating heavier weights.

```bash
cd /Users/samuelalake/Developer/Apps/Swift/MaterialSymbolsKit/test-symbol

# The template embeds weights as separate groups
# We need to isolate the Bold-S (small) variant
# This requires parsing the SVG structure
```

**Challenge:** The template is a single file with all weights. SwiftDraw expects separate SVG files for each weight variant.

### Step 3: Create Bold-Only SVG

You'll need to manually extract or generate a standalone Bold SVG from Material Symbols source:

```bash
# Download the original Material Symbol (not the iOS template)
# Material Symbols have separate weight files
curl -O "https://fonts.gstatic.com/s/i/short-term/release/materialsymbolsrounded/home/default/48px.svg"

# This would be the regular weight
# Need to find Bold (wght 700) version
```

### Step 4: Generate Heavy & Black with SwiftDraw
```bash
# Assuming we have separate weight SVGs:
swiftdraw home-regular.svg \
  --format sfsymbol \
  --ultralight home-thin.svg \
  --black home-bold.svg \
  --insets auto \
  --output material.home.generated.symbol
```

**Problem:** SwiftDraw can't add weights to existing templates. It creates NEW templates from source SVGs.

This means we'd need to:
1. Ignore Google's iOS templates
2. Start from Material Symbol source SVGs
3. Generate entire SF Symbol from scratch

### Expected Results:
- ⚠️ More complex workflow
- ❓ Quality may differ from Google's templates
- ✅ Would have all 9 weights if successful

---

## Option C: Hybrid Approach (Advanced)

Parse Google's SF Symbol template, extract Bold variant paths, generate Heavy/Black, merge back.

**Steps:**
1. Parse `home_symbol.svg` XML structure
2. Extract `<g id="Bold-S">` path data
3. Create standalone Bold SVG
4. Use swiftdraw or manual stroke manipulation to create heavier variants
5. Insert new `<g id="Heavy-S">` and `<g id="Black-S">` paths back into template
6. Validate template integrity

**Complexity:** High - requires SVG manipulation expertise

---

## Recommended Quick Test (5 minutes)

```bash
# 1. Create minimal iOS app
cd /Users/samuelalake/Developer/Apps/Swift/MaterialSymbolsKit
mkdir -p TestApp

# 2. We'll use Xcode to quickly test
# I'll create a SwiftUI test file you can paste into a playground
```

