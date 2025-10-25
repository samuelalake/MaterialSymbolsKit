# Getting Started

Learn how to integrate MaterialSymbolsKit into your project and use Material Symbols.

## Installation

### Swift Package Manager

Add MaterialSymbolsKit to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/samuealake/MaterialSymbolsKit.git", from: "1.0.0")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter the repository URL
3. Select version 1.0.0 or later

## Basic Usage

### SwiftUI

Import the package and use Material Symbols anywhere you'd use an SF Symbol:

```swift
import SwiftUI
import MaterialSymbolsKit

struct ExampleView: View {
    var body: some View {
        // Create an image
        Image(materialSymbol: .home)
        
        // With font styling
        Image(materialSymbol: .search)
            .font(.largeTitle)
        
        // With weight
        Image(materialSymbol: .settings)
            .font(.system(size: 40, weight: .bold))
        
        // With color
        Image(materialSymbol: .favorite)
            .foregroundStyle(.red)
    }
}
```

### UIKit

```swift
import UIKit
import MaterialSymbolsKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create UIImage
        let image = UIImage(materialSymbol: .home)
        
        // With configuration
        let config = UIImage.SymbolConfiguration(
            pointSize: 40,
            weight: .bold
        )
        let styledImage = UIImage(materialSymbol: .search)?
            .withConfiguration(config)
        
        // Use in UIImageView
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
    }
}
```

## Common Patterns

### Navigation

```swift
NavigationView {
    List {
        NavigationLink(destination: HomeView()) {
            Label("Home", materialSymbol: .home)
        }
        NavigationLink(destination: SettingsView()) {
            Label("Settings", materialSymbol: .settings)
        }
    }
    .navigationTitle("Menu")
}
```

### Buttons

```swift
VStack {
    Button(action: addItem) {
        Label("Add Item", materialSymbol: .add)
    }
    .buttonStyle(.borderedProminent)
    
    Button(action: deleteItem) {
        Image(materialSymbol: .delete)
    }
    .buttonStyle(.bordered)
    .tint(.red)
}
```

### Toolbar

```swift
.toolbar {
    ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: share) {
            Image(materialSymbol: .share)
        }
    }
    
    ToolbarItem(placement: .navigationBarLeading) {
        Button(action: goBack) {
            Image(materialSymbol: .arrowBack)
        }
    }
}
```

## Next Steps

- Explore ``MaterialSymbols`` for available symbols
- Learn about <doc:Weight-Support>
- Check out the Examples folder for more patterns

