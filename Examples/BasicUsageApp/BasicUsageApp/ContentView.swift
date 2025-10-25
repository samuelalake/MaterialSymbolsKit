//import SwiftUI
////import MaterialSymbolsKit
//
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 40) {
//                    // Weight demonstration
//                    weightSection
//                    
//                    Divider()
//                    
//                    // Style & Fill demonstration
//                    styleSection
//                    
//                    Divider()
//                    
//                    // Rendering modes
//                    renderingSection
//                    
//                    Divider()
//                    
//                    // Common usage patterns
//                    usageSection
//                    
//                    Divider()
//                    
//                    // Grid of all symbols
//                    symbolGrid
//                }
//                .padding()
//            }
//            .navigationTitle("MaterialSymbolsKit")
//        }
//    }
//    
//    var weightSection: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            Text("Weight Variations")
//                .font(.headline)
//            
//            Text("Native Weights (100-700)")
//                .font(.subheadline)
//                .foregroundStyle(.secondary)
//            
//            ForEach([
//                Font.Weight.ultraLight,
//                .thin,
//                .light,
//                .regular,
//                .medium,
//                .semibold,
//                .bold
//            ], id: \.self) { weight in
//                HStack {
//                    if MaterialSymbols.allCases.count > 0 {
//                        Image(materialSymbol: MaterialSymbols.allCases[0])
//                            .font(.system(size: 40, weight: weight))
//                            .frame(width: 60)
//                    }
//                    Text(weight.name)
//                    Spacer()
//                }
//            }
//            
//            Text("Interpolated Weights (800-900)")
//                .font(.subheadline)
//                .foregroundStyle(.orange)
//                .padding(.top)
//            
//            ForEach([Font.Weight.heavy, .black], id: \.self) { weight in
//                HStack {
//                    if MaterialSymbols.allCases.count > 0 {
//                        Image(materialSymbol: MaterialSymbols.allCases[0])
//                            .font(.system(size: 40, weight: weight))
//                            .frame(width: 60)
//                    }
//                    Text(weight.name + " (iOS interpolated)")
//                    Spacer()
//                }
//            }
//        }
//        .padding()
//        .background(Color.gray.opacity(0.1))
//        .cornerRadius(10)
//    }
//    
//    var styleSection: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            Text("Styles & Fill")
//                .font(.headline)
//            
//            if MaterialSymbols.allCases.count > 0 {
//                let symbol = MaterialSymbols.allCases[0]
//                
//                VStack(spacing: 20) {
//                    // Rounded
//                    HStack(spacing: 30) {
//                        VStack {
//                            Image(materialSymbol: symbol, style: .rounded, fill: .outline)
//                                .font(.system(size: 50))
//                            Text("Rounded\nOutline")
//                                .font(.caption)
//                                .multilineTextAlignment(.center)
//                        }
//                        VStack {
//                            Image(materialSymbol: symbol, style: .rounded, fill: .filled)
//                                .font(.system(size: 50))
//                            Text("Rounded\nFilled")
//                                .font(.caption)
//                                .multilineTextAlignment(.center)
//                        }
//                    }
//                    
//                    // Outlined
//                    HStack(spacing: 30) {
//                        VStack {
//                            Image(materialSymbol: symbol, style: .outlined, fill: .outline)
//                                .font(.system(size: 50))
//                            Text("Outlined\nOutline")
//                                .font(.caption)
//                                .multilineTextAlignment(.center)
//                        }
//                        VStack {
//                            Image(materialSymbol: symbol, style: .outlined, fill: .filled)
//                                .font(.system(size: 50))
//                            Text("Outlined\nFilled")
//                                .font(.caption)
//                                .multilineTextAlignment(.center)
//                        }
//                    }
//                    
//                    // Sharp
//                    HStack(spacing: 30) {
//                        VStack {
//                            Image(materialSymbol: symbol, style: .sharp, fill: .outline)
//                                .font(.system(size: 50))
//                            Text("Sharp\nOutline")
//                                .font(.caption)
//                                .multilineTextAlignment(.center)
//                        }
//                        VStack {
//                            Image(materialSymbol: symbol, style: .sharp, fill: .filled)
//                                .font(.system(size: 50))
//                            Text("Sharp\nFilled")
//                                .font(.caption)
//                                .multilineTextAlignment(.center)
//                        }
//                    }
//                }
//            }
//        }
//        .padding()
//        .background(Color.orange.opacity(0.1))
//        .cornerRadius(10)
//    }
//    
//    var renderingSection: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            Text("Rendering Modes")
//                .font(.headline)
//            
//            if MaterialSymbols.allCases.count > 0 {
//                HStack(spacing: 30) {
//                    VStack {
//                        Image(materialSymbol: MaterialSymbols.allCases[0])
//                            .font(.system(size: 50))
//                            .symbolRenderingMode(.monochrome)
//                            .foregroundStyle(.blue)
//                        Text("Monochrome")
//                            .font(.caption)
//                    }
//                    
//                    VStack {
//                        Image(materialSymbol: MaterialSymbols.allCases[0])
//                            .font(.system(size: 50))
//                            .symbolRenderingMode(.hierarchical)
//                            .foregroundStyle(.blue)
//                        Text("Hierarchical")
//                            .font(.caption)
//                    }
//                    
//                    VStack {
//                        Image(materialSymbol: MaterialSymbols.allCases[0])
//                            .font(.system(size: 50))
//                            .symbolRenderingMode(.palette)
//                            .foregroundStyle(.blue, .green)
//                        Text("Palette")
//                            .font(.caption)
//                    }
//                }
//            }
//        }
//        .padding()
//        .background(Color.purple.opacity(0.1))
//        .cornerRadius(10)
//    }
//    
//    var usageSection: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            Text("Common Usage Patterns")
//                .font(.headline)
//            
//            if MaterialSymbols.allCases.count > 0 {
//                VStack(alignment: .leading, spacing: 10) {
//                    // In buttons
//                    Button(action: {}) {
//                        Label("Button", materialSymbol: MaterialSymbols.allCases[0])
//                    }
//                    .buttonStyle(.bordered)
//                    
//                    // In navigation
//                    Label("Navigation Item", materialSymbol: MaterialSymbols.allCases[0])
//                    
//                    // Standalone
//                    HStack {
//                        Text("Standalone icon:")
//                        Image(materialSymbol: MaterialSymbols.allCases[0])
//                            .font(.title)
//                    }
//                }
//            }
//        }
//        .padding()
//        .background(Color.green.opacity(0.1))
//        .cornerRadius(10)
//    }
//    
//    var symbolGrid: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            Text("All Available Symbols (\(MaterialSymbols.allCases.count))")
//                .font(.headline)
//            
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
//                ForEach(MaterialSymbols.allCases, id: \.self) { symbol in
//                    VStack(spacing: 8) {
//                        Image(materialSymbol: symbol)
//                            .font(.system(size: 32))
//                        Text(symbol.rawValue.replacingOccurrences(of: "material.", with: ""))
//                            .font(.caption2)
//                            .lineLimit(2)
//                            .multilineTextAlignment(.center)
//                    }
//                    .frame(height: 80)
//                }
//            }
//        }
//        .padding()
//        .background(Color.blue.opacity(0.1))
//        .cornerRadius(10)
//    }
//}
//
//extension Font.Weight {
//    var name: String {
//        switch self {
//        case .ultraLight: return "Ultralight"
//        case .thin: return "Thin"
//        case .light: return "Light"
//        case .regular: return "Regular"
//        case .medium: return "Medium"
//        case .semibold: return "Semibold"
//        case .bold: return "Bold"
//        case .heavy: return "Heavy"
//        case .black: return "Black"
//        default: return "Unknown"
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
//
