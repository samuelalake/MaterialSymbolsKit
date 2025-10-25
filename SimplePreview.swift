import SwiftUI
import MaterialSymbolsKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("Material Symbols Test")
                .font(.headline)
            
            // Basic home icon
            Image(materialSymbol: .home)
                .font(.system(size: 100))
            
            // Different weights
            HStack(spacing: 20) {
                Image(materialSymbol: .home)
                    .font(.system(size: 50, weight: .light))
                
                Image(materialSymbol: .home)
                    .font(.system(size: 50, weight: .regular))
                
                Image(materialSymbol: .home)
                    .font(.system(size: 50, weight: .bold))
            }
            
            Text("If you see the home icons above, it works! 🎉")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

