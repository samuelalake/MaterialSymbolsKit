/// Material Symbols as SF Symbols for iOS
///
/// This package provides Material Design symbols in SF Symbol format,
/// enabling type-safe usage with SwiftUI and UIKit.
///
/// ## Weight Support
/// Material Symbols include 7 native weights (100-700):
/// - Ultralight, Thin, Light, Regular, Medium, Semibold, Bold
///
/// Heavy (800) and Black (900) weights are interpolated by iOS from Bold (700).
///
/// ## Usage
/// ```swift
/// import SwiftUI
/// import MaterialSymbolsKit
///
/// Image(materialSymbol: .home)
///     .font(.largeTitle)
/// ```
public enum MaterialSymbols: String, CaseIterable, Sendable {
    case home = "material.home"
}
