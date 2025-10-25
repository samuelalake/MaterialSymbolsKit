// QuickTest.swift
// Copy this into an iOS Playground or new Xcode project to test the symbol

import SwiftUI

struct MaterialSymbolTestView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Material Symbol: Home")
                    .font(.largeTitle)
                    .padding()
                
                // Test all 7 available weights
                VStack(alignment: .leading, spacing: 15) {
                    Text("Available Weights (from Google template)")
                        .font(.headline)
                    
                    weightRow(weight: .ultraLight, name: "Ultralight")
                    weightRow(weight: .thin, name: "Thin")
                    weightRow(weight: .light, name: "Light")
                    weightRow(weight: .regular, name: "Regular")
                    weightRow(weight: .medium, name: "Medium")
                    weightRow(weight: .semibold, name: "Semibold")
                    weightRow(weight: .bold, name: "Bold")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                Divider()
                
                // Test missing weights (iOS interpolation)
                VStack(alignment: .leading, spacing: 15) {
                    Text("Missing Weights (iOS will interpolate)")
                        .font(.headline)
                    
                    weightRow(weight: .heavy, name: "Heavy ⚠️")
                    weightRow(weight: .black, name: "Black ⚠️")
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
                
                Divider()
                
                // Test different sizes
                VStack(alignment: .leading, spacing: 15) {
                    Text("Size Scaling")
                        .font(.headline)
                    
                    HStack(spacing: 20) {
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 20))
                            Text("20pt")
                                .font(.caption)
                        }
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 40))
                            Text("40pt")
                                .font(.caption)
                        }
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 60))
                            Text("60pt")
                                .font(.caption)
                        }
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 80))
                            Text("80pt")
                                .font(.caption)
                        }
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                
                Divider()
                
                // Test rendering modes
                VStack(alignment: .leading, spacing: 15) {
                    Text("Rendering Modes")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 40))
                                .symbolRenderingMode(.monochrome)
                            Text("Monochrome")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 40))
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.blue)
                            Text("Hierarchical")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 40))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.blue, .green)
                            Text("Palette")
                                .font(.caption)
                        }
                    }
                }
                .padding()
                .background(Color.purple.opacity(0.1))
                .cornerRadius(10)
                
                // Comparison with native SF Symbol
                VStack(alignment: .leading, spacing: 15) {
                    Text("Compare with Native SF Symbol")
                        .font(.headline)
                    
                    HStack(spacing: 40) {
                        VStack {
                            Image(systemName: "material.home")
                                .font(.system(size: 50, weight: .regular))
                            Text("Material Home")
                                .font(.caption)
                        }
                        
                        VStack {
                            Image(systemName: "house")
                                .font(.system(size: 50, weight: .regular))
                            Text("SF Symbol House")
                                .font(.caption)
                        }
                    }
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
    }
    
    func weightRow(weight: Font.Weight, name: String) -> some View {
        HStack {
            Image(systemName: "material.home")
                .font(.system(size: 40, weight: weight))
                .frame(width: 60)
            
            Text(name)
                .frame(width: 120, alignment: .leading)
            
            // Show multiple sizes for this weight
            HStack(spacing: 10) {
                Image(systemName: "material.home")
                    .font(.system(size: 20, weight: weight))
                Image(systemName: "material.home")
                    .font(.system(size: 30, weight: weight))
            }
        }
    }
}

#Preview {
    MaterialSymbolTestView()
}

// MARK: - Package API Preview

/// This is what the final package API would look like
public enum MaterialSymbols: String, CaseIterable {
    case home = "material.home"
    case search = "material.search"
    case settings = "material.settings"
    // ... 3000+ more
    
    public var image: Image {
        Image(self.rawValue, bundle: .module)
    }
}

// Usage examples:
struct UsageExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            // Simple usage
            MaterialSymbols.home.image
                .font(.largeTitle)
            
            // With modifiers
            MaterialSymbols.home.image
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.blue)
            
            // In navigation
            Label("Home", systemImage: MaterialSymbols.home.rawValue)
            
            // In toolbar
            Button(action: {}) {
                MaterialSymbols.search.image
            }
        }
    }
}

