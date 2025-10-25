# Changelog

All notable changes to MaterialSymbolsKit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned for v1.1.0
- Expand to 3000+ Material Symbols
- Automated batch processing implementation
- Performance optimizations
- Symbol search utilities

## [1.0.0] - 2025-01-XX

### Added
- Initial release of MaterialSymbolsKit
- 100 curated Material Symbols as SF Symbols
- Type-safe Swift API with `Image(materialSymbol:)` initializer
- Support for iOS 16+, macOS 13+, watchOS 9+, tvOS 16+
- Full SF Symbol feature support (weights, rendering modes, animations)
- SwiftUI `Image` and `Label` extensions
- UIKit `UIImage` extension
- AppKit `NSImage` extension
- Comprehensive DocC documentation
- Example app demonstrating usage patterns
- Automated packaging scripts for symbol processing
- Zero dependencies

### Technical Details
- 7 native weight variations (Ultralight through Bold)
- iOS automatic interpolation for Heavy and Black weights
- SF Symbol template format from Google Material Design Icons
- Swift 6.1 support with Sendable conformance

### Documentation
- Getting Started guide
- Weight Support detailed explanation
- API reference documentation
- Symbol selection rationale
- Scaling strategy documentation
- Technical blog post

[Unreleased]: https://github.com/samuealake/MaterialSymbolsKit/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/samuealake/MaterialSymbolsKit/releases/tag/v1.0.0

