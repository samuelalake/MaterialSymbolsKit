# How to Preview Material Symbols

The package preview requires a separate Xcode project. Here are your options:

## Option 1: Create Quick Preview Playground (Easiest)

1. **Create a new iOS Playground in Xcode:**
   ```
   File → New → Playground → iOS → Blank
   ```

2. **Add this code:**
   ```swift
   import SwiftUI
   import PlaygroundSupport
   
   // Replace this path with your actual package path
   import MaterialSymbolsKit
   
   struct PreviewView: View {
       var body: some View {
           VStack(spacing: 20) {
               Text("Material Symbol Preview")
                   .font(.title)
               
               // Preview home symbol at different weights
               ForEach([
                   (Font.Weight.ultraLight, "Ultralight"),
                   (.regular, "Regular"),
                   (.bold, "Bold"),
                   (.heavy, "Heavy"),
                   (.black, "Black")
               ], id: \.1) { weight, name in
                   HStack {
                       Image(materialSymbol: .home)
                           .font(.system(size: 50, weight: weight))
                       Text(name)
                   }
               }
               
               // Different sizes
               HStack(spacing: 20) {
                   Image(materialSymbol: .home)
                       .font(.system(size: 20))
                   Image(materialSymbol: .home)
                       .font(.system(size: 40))
                   Image(materialSymbol: .home)
                       .font(.system(size: 60))
               }
           }
           .padding()
       }
   }
   
   PlaygroundPage.current.setLiveView(PreviewView())
   ```

3. **Link to your package:**
   - Right-click on the playground
   - Add Files → Navigate to MaterialSymbolsKit folder
   - Select Package.swift

## Option 2: Create Test iOS App Project

1. **Create new iOS App:**
   ```
   File → New → Project → iOS → App
   Name: MaterialSymbolsPreview
   ```

2. **Add MaterialSymbolsKit as local package:**
   ```
   File → Add Package Dependencies
   → Add Local... 
   → Select MaterialSymbolsKit folder
   ```

3. **Use in ContentView:**
   ```swift
   import SwiftUI
   import MaterialSymbolsKit
   
   struct ContentView: View {
       var body: some View {
           Image(materialSymbol: .home)
               .font(.system(size: 100))
       }
   }
   ```

## Option 3: View SVG Directly (No Code)

Just open the symbol file:

```bash
# From project root
open Sources/MaterialSymbolsKit/Resources/Symbols.xcassets/material.home.symbolset/material.home.svg
```

This opens in SF Symbols app (if installed) or your default SVG viewer.

## Option 4: Use Example App (If Packaged with Examples)

```bash
cd Examples/BasicUsage
swift run
```

## Option 5: Quick Terminal Check

Verify the symbol is properly packaged:

```bash
# List all packaged symbols
find Sources/MaterialSymbolsKit/Resources/Symbols.xcassets -name "*.svg"

# Inspect home symbol
ls -lh Sources/MaterialSymbolsKit/Resources/Symbols.xcassets/material.home.symbolset/
```

---

## Why Can't I Preview Directly?

Swift packages don't support `@main` for app previews directly. You need either:
- A separate Xcode app project that imports the package
- A Playground
- Or the Examples folder set up as an executable target

**Recommended**: Use Option 2 (create test iOS app) for the best preview experience with full SwiftUI capabilities.

