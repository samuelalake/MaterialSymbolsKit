import SwiftUI

public extension Image {
    /// Create an Image from a Material Symbol
    ///
    /// Material Symbols provide 3000+ icons from Google's Material Design
    /// in SF Symbol format, with 7 native weight variations.
    ///
    /// - Parameters:
    ///   - materialSymbol: The Material Symbol to display
    ///   - style: Visual style (rounded, outlined, sharp). Default is rounded.
    ///   - fill: Fill state (outline, filled). Default is outline.
    ///
    /// Example:
    /// ```swift
    /// // Simple (uses defaults: rounded, outline)
    /// Image(materialSymbol: .home)
    ///
    /// // With style
    /// Image(materialSymbol: .home, style: .sharp)
    ///
    /// // With fill
    /// Image(materialSymbol: .home, fill: .filled)
    ///
    /// // With both
    /// Image(materialSymbol: .home, style: .sharp, fill: .filled)
    /// ```
    ///
    /// - Note: v1.0 includes only rounded style. Sharp and outlined variants coming in v1.1+
    init(
        materialSymbol: MaterialSymbols,
        style: MaterialSymbolStyle = .rounded,
        fill: MaterialSymbolFill = .outline
    ) {
        let symbolName = materialSymbol.symbolName(style: style, fill: fill)
        self.init(symbolName, bundle: .module)
    }
    
    /// Create an Image from a Material Symbol with configuration
    ///
    /// - Parameters:
    ///   - materialSymbol: The Material Symbol to display
    ///   - configuration: Style and fill configuration
    ///
    /// Example:
    /// ```swift
    /// Image(materialSymbol: .home, configuration: .sharpFilled)
    /// Image(materialSymbol: .home, configuration: .outlined)
    /// ```
    init(
        materialSymbol: MaterialSymbols,
        configuration: MaterialSymbolConfiguration
    ) {
        self.init(
            materialSymbol: materialSymbol,
            style: configuration.style,
            fill: configuration.fill
        )
    }
}

public extension Label where Title == Text, Icon == Image {
    /// Create a Label with a Material Symbol
    ///
    /// - Parameters:
    ///   - titleKey: The localized string key for the label text
    ///   - materialSymbol: The Material Symbol to display as the icon
    ///   - style: Visual style (rounded, outlined, sharp). Default is rounded.
    ///   - fill: Fill state (outline, filled). Default is outline.
    ///
    /// Example:
    /// ```swift
    /// Label("Home", materialSymbol: .home)
    /// Label("Home", materialSymbol: .home, style: .sharp, fill: .filled)
    /// ```
    init(
        _ titleKey: LocalizedStringKey,
        materialSymbol: MaterialSymbols,
        style: MaterialSymbolStyle = .rounded,
        fill: MaterialSymbolFill = .outline
    ) {
        self.init {
            Text(titleKey)
        } icon: {
            Image(materialSymbol: materialSymbol, style: style, fill: fill)
        }
    }
    
    /// Create a Label with a Material Symbol
    ///
    /// - Parameters:
    ///   - title: The label text
    ///   - materialSymbol: The Material Symbol to display as the icon
    ///   - style: Visual style (rounded, outlined, sharp). Default is rounded.
    ///   - fill: Fill state (outline, filled). Default is outline.
    ///
    /// Example:
    /// ```swift
    /// Label("Home", materialSymbol: .home)
    /// Label("Home", materialSymbol: .home, style: .sharp, fill: .filled)
    /// ```
    init(
        _ title: String,
        materialSymbol: MaterialSymbols,
        style: MaterialSymbolStyle = .rounded,
        fill: MaterialSymbolFill = .outline
    ) {
        self.init {
            Text(title)
        } icon: {
            Image(materialSymbol: materialSymbol, style: style, fill: fill)
        }
    }
}

#if canImport(UIKit)
import UIKit

public extension UIImage {
    /// Create a UIImage from a Material Symbol
    ///
    /// - Parameters:
    ///   - materialSymbol: The Material Symbol to load
    ///   - style: Visual style (rounded, outlined, sharp). Default is rounded.
    ///   - fill: Fill state (outline, filled). Default is outline.
    ///
    /// Example:
    /// ```swift
    /// let image = UIImage(materialSymbol: .home)
    /// let sharpFilled = UIImage(materialSymbol: .home, style: .sharp, fill: .filled)
    /// imageView.image = image
    /// ```
    convenience init?(
        materialSymbol: MaterialSymbols,
        style: MaterialSymbolStyle = .rounded,
        fill: MaterialSymbolFill = .outline
    ) {
        let symbolName = materialSymbol.symbolName(style: style, fill: fill)
        self.init(named: symbolName, in: .module, with: nil)
    }
}
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSImage {
    /// Create an NSImage from a Material Symbol
    ///
    /// - Parameters:
    ///   - materialSymbol: The Material Symbol to load
    ///   - style: Visual style (rounded, outlined, sharp). Default is rounded.
    ///   - fill: Fill state (outline, filled). Default is outline.
    ///
    /// Example:
    /// ```swift
    /// let image = NSImage(materialSymbol: .home)
    /// let sharpFilled = NSImage(materialSymbol: .home, style: .sharp, fill: .filled)
    /// imageView.image = image
    /// ```
    convenience init?(
        materialSymbol: MaterialSymbols,
        style: MaterialSymbolStyle = .rounded,
        fill: MaterialSymbolFill = .outline
    ) {
        let symbolName = materialSymbol.symbolName(style: style, fill: fill)
        self.init(named: symbolName)
    }
}
#endif

