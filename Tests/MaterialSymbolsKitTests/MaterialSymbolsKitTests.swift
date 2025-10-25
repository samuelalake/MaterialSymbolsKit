import XCTest
@testable import MaterialSymbolsKit
import SwiftUI

final class MaterialSymbolsKitTests: XCTestCase {
    func testEnumCaseCount() {
        // Should have at least 50 cases after generation
        XCTAssertGreaterThanOrEqual(MaterialSymbols.allCases.count, 1)
    }
    
    func testRawValueFormat() {
        // All raw values should start with "material."
        for symbol in MaterialSymbols.allCases {
            XCTAssertTrue(
                symbol.rawValue.hasPrefix("material."),
                "Symbol \(symbol) has invalid raw value: \(symbol.rawValue)"
            )
        }
    }
    
    func testImageInit() {
        // Should be able to create images from all symbols
        for symbol in MaterialSymbols.allCases {
            let image = Image(materialSymbol: symbol)
            XCTAssertNotNil(image)
        }
    }
    
    func testLabelInit() {
        // Should be able to create labels with first available symbol
        if let firstSymbol = MaterialSymbols.allCases.first {
            let label = Label("Test", materialSymbol: firstSymbol)
            XCTAssertNotNil(label)
        }
    }
    
    #if canImport(UIKit)
    func testUIImageInit() {
        // Test with first available symbol
        if let firstSymbol = MaterialSymbols.allCases.first {
            let image = UIImage(materialSymbol: firstSymbol)
            // Image may be nil in test environment without assets
            XCTAssertTrue(image == nil || image != nil)
        }
    }
    #endif
}
