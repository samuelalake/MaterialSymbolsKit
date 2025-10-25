# Xcode Testing Instructions - Manual Step

## Purpose
Validate that iOS weight interpolation for Heavy/Black weights looks acceptable before proceeding with full package build.

## Steps

### 1. Create Test Project
1. Open Xcode
2. File → New → Project
3. Select iOS → App
4. Name: `MaterialSymbolTest`
5. Interface: SwiftUI
6. Save in: `test-symbol/MaterialSymbolTest/`

### 2. Import Symbol
1. In Xcode, select `Assets.xcassets`
2. Click `+` button (bottom left)
3. Select "New Symbol Set"
4. Name it: `material.home`
5. Drag `home_symbol.svg` from test-symbol folder into the symbol set
6. Xcode will automatically parse the SF Symbol template

### 3. Test Rendering
Replace `ContentView.swift` with:

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Material Symbol Weight Test")
                    .font(.title)
                    .padding()
                
                Divider()
                
                // Native weights (should look perfect)
                VStack(alignment: .leading, spacing: 15) {
                    Text("Native Weights (100-700)")
                        .font(.headline)
                    
                    weightRow(.ultraLight, "Ultralight (100)")
                    weightRow(.thin, "Thin (200)")
                    weightRow(.light, "Light (300)")
                    weightRow(.regular, "Regular (400)")
                    weightRow(.medium, "Medium (500)")
                    weightRow(.semibold, "Semibold (600)")
                    weightRow(.bold, "Bold (700)")
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
                
                Divider()
                
                // Interpolated weights (validate quality)
                VStack(alignment: .leading, spacing: 15) {
                    Text("Interpolated Weights (800-900)")
                        .font(.headline)
                    
                    weightRow(.heavy, "Heavy (800) ⚠️ Interpolated")
                    weightRow(.black, "Black (900) ⚠️ Interpolated")
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
                
                Divider()
                
                // Comparison at different sizes
                VStack(alignment: .leading, spacing: 15) {
                    Text("Size Scaling Test")
                        .font(.headline)
                    
                    HStack(spacing: 20) {
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 30, weight: .bold))
                            Text("30pt Bold")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 30, weight: .heavy))
                            Text("30pt Heavy")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 30, weight: .black))
                            Text("30pt Black")
                                .font(.caption)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 60, weight: .bold))
                            Text("60pt Bold")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 60, weight: .heavy))
                            Text("60pt Heavy")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 60, weight: .black))
                            Text("60pt Black")
                                .font(.caption)
                        }
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
    }
    
    func weightRow(_ weight: Font.Weight, _ label: String) -> some View {
        HStack {
            Image(systemName: "material.home")
                .font(.system(size: 50, weight: weight))
                .frame(width: 80)
            
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ContentView()
}
```

### 4. Evaluate Quality

Run the app and assess:

**✅ PASS Criteria:**
- Heavy weight looks like a reasonable progression from Bold
- Black weight looks heavier than Heavy
- No visual artifacts or distortion
- Symbols scale properly at different sizes

**❌ FAIL Criteria:**
- Heavy/Black look identical to Bold
- Obvious distortion or artifacts
- Scaling issues at larger sizes

### 5. Document Results

Create `test-symbol/interpolation-test-results.md` with:
- Screenshots of native vs interpolated weights
- Your assessment (PASS/FAIL)
- Any observations about quality
- Decision: Proceed with Option A (as-is) or reconsider

## Expected Outcome

iOS interpolation should produce acceptable Heavy/Black weights. If quality is good, proceed with Phase 2 of the plan.

