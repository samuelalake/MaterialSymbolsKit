# Contributing to MaterialSymbolsKit

Thank you for your interest in contributing to MaterialSymbolsKit! This document provides guidelines for contributions.

## Project Philosophy

**Core = Stable, Examples = Flexible**

- The core package provides direct access to Google's official symbols with a minimal, stable API
- Contributions should focus on documentation, examples, and helper utilities
- Breaking changes to the core API require careful consideration

## How to Contribute

### 1. Documentation & Examples

The most valuable contributions:

- **Tutorial content**: How-to guides for common use cases
- **Example apps**: Showcase apps demonstrating MaterialSymbolsKit features
- **Code samples**: Snippets for the documentation
- **Blog posts**: Write about your experience using the package

### 2. Symbol Categories

Help organize symbols by creating category collections:

```swift
// Sources/MaterialSymbolsKit/Collections/Navigation.swift
public extension MaterialSymbols {
    static let navigationSymbols: [MaterialSymbols] = [
        .home, .menu, .search, .arrowBack, .arrowForward
    ]
}
```

### 3. Platform-Specific Helpers

Improve platform integration:

```swift
// UIKit conveniences
public extension UIButton {
    func setMaterialSymbol(_ symbol: MaterialSymbols, for state: UIControl.State) {
        setImage(UIImage(materialSymbol: symbol), for: state)
    }
}
```

### 4. Testing & Validation

- Add test cases
- Report rendering issues
- Validate symbols across platforms
- Performance benchmarks

### 5. Bug Reports

When reporting bugs, include:
- MaterialSymbolsKit version
- Platform and OS version
- Xcode version
- Minimal reproduction code
- Expected vs actual behavior
- Screenshots if applicable

## What We Don't Accept

- ❌ Custom symbols not from Material Design
- ❌ Modifications to Google's symbol files
- ❌ Breaking changes to core API without discussion
- ❌ Dependencies (keep package zero-dependency)

## Development Setup

### Prerequisites

- Xcode 15.0+
- Swift 6.1+
- Git

### Getting Started

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/MaterialSymbolsKit.git
cd MaterialSymbolsKit

# Download Material Design Icons (for symbol packaging)
git clone --depth 1 https://github.com/google/material-design-icons.git

# Build
swift build

# Run tests
swift test
```

### Making Changes

1. Create a branch:
```bash
git checkout -b feature/your-feature-name
```

2. Make your changes

3. Run tests:
```bash
swift test
swift build
```

4. Commit with clear messages:
```bash
git commit -m "Add navigation symbol collection"
```

5. Push and create Pull Request

## Pull Request Guidelines

### Title Format

```
[Type] Brief description

Types: Feature, Fix, Docs, Test, Refactor, Perf
```

### Description Template

```markdown
## Description
Brief description of changes

## Motivation
Why is this change needed?

## Changes Made
- Change 1
- Change 2

## Testing
How was this tested?

## Screenshots (if applicable)
```

### Code Standards

- Follow Swift API Design Guidelines
- Add documentation comments for public APIs
- Include tests for new functionality
- Maintain backward compatibility
- Keep changes focused and atomic

### Documentation

Public APIs require documentation:

```swift
/// Brief description
///
/// Detailed explanation of the function/property.
///
/// - Parameters:
///   - param1: Description
///   - param2: Description
/// - Returns: Description
///
/// Example:
/// ```swift
/// let result = function(param1: value1, param2: value2)
/// ```
public func function(param1: Type1, param2: Type2) -> ReturnType {
    // Implementation
}
```

## Code Review Process

1. **Automated Checks**: CI runs tests and builds
2. **Maintainer Review**: Code quality and design review
3. **Feedback**: Address any requested changes
4. **Approval**: Maintainer approves PR
5. **Merge**: Changes merged to main branch

## Community Guidelines

- Be respectful and constructive
- Help others in issues and discussions
- Share your MaterialSymbolsKit projects
- Report bugs and suggest improvements

## Questions?

- **Issues**: [GitHub Issues](https://github.com/samuealake/MaterialSymbolsKit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/samuealake/MaterialSymbolsKit/discussions)
- **Email**: Create an issue for technical questions

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.

---

Thank you for contributing to MaterialSymbolsKit! 🎉

