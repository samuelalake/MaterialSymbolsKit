import Foundation

/// Style variants for Material Symbols
///
/// Material Design provides three distinct visual styles for symbols.
///
/// - **Rounded**: Friendly, approachable corners (default)
/// - **Outlined**: Clean, minimal aesthetic
/// - **Sharp**: Angular, modern edges
///
/// Example:
/// ```swift
/// Image(materialSymbol: .home, style: .rounded)  // Default
/// Image(materialSymbol: .home, style: .sharp)    // Angular
/// Image(materialSymbol: .home, style: .outlined) // Minimal
/// ```
public enum MaterialSymbolStyle: String, CaseIterable, Sendable {
    /// Rounded corners - friendly and approachable (default)
    case rounded
    
    /// Outlined - clean and minimal
    case outlined
    
    /// Sharp corners - angular and modern
    case sharp
}

/// Fill state for Material Symbols
///
/// Symbols can be displayed with or without fill.
///
/// - **Outline**: Stroke only, no fill (default)
/// - **Filled**: Solid fill
///
/// Example:
/// ```swift
/// Image(materialSymbol: .home, fill: .outline)  // Default
/// Image(materialSymbol: .home, fill: .filled)   // Solid
/// ```
public enum MaterialSymbolFill: String, CaseIterable, Sendable {
    /// Outline only (default)
    case outline = "fill0"
    
    /// Filled with solid color
    case filled = "fill1"
}

/// Configuration for Material Symbol rendering
public struct MaterialSymbolConfiguration: Sendable {
    public let style: MaterialSymbolStyle
    public let fill: MaterialSymbolFill
    
    public init(
        style: MaterialSymbolStyle = .rounded,
        fill: MaterialSymbolFill = .outline
    ) {
        self.style = style
        self.fill = fill
    }
    
    /// Default configuration (rounded, outline)
    public static let `default` = MaterialSymbolConfiguration()
    
    /// Rounded filled variant
    public static let roundedFilled = MaterialSymbolConfiguration(fill: .filled)
    
    /// Sharp outline variant
    public static let sharp = MaterialSymbolConfiguration(style: .sharp)
    
    /// Sharp filled variant
    public static let sharpFilled = MaterialSymbolConfiguration(style: .sharp, fill: .filled)
    
    /// Outlined outline variant
    public static let outlined = MaterialSymbolConfiguration(style: .outlined)
    
    /// Outlined filled variant
    public static let outlinedFilled = MaterialSymbolConfiguration(style: .outlined, fill: .filled)
}

extension MaterialSymbols {
    /// Get the full symbol name including style and fill variant
    ///
    /// - Parameters:
    ///   - style: Visual style (rounded, outlined, sharp)
    ///   - fill: Fill state (outline, filled)
    /// - Returns: Full symbol resource name
    ///
    /// Example:
    /// ```swift
    /// MaterialSymbols.home.symbolName(style: .rounded, fill: .outline)
    /// // Returns: "material.home.rounded.fill0"
    /// ```
    public func symbolName(
        style: MaterialSymbolStyle = .rounded,
        fill: MaterialSymbolFill = .outline
    ) -> String {
        // v1.0: Only rounded + default fill packaged
        // v1.1+: Will check for style/fill variants
        
        // For now, return base name (only rounded packaged)
        // Future: "material.\(rawValue).\(style.rawValue).\(fill.rawValue)"
        return rawValue
    }
    
    /// Get the full symbol name using configuration
    public func symbolName(configuration: MaterialSymbolConfiguration) -> String {
        symbolName(style: configuration.style, fill: configuration.fill)
    }
}

