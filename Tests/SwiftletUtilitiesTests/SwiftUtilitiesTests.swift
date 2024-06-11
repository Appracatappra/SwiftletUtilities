//
//  SwiftUtilitiesTests.swift
//  
//
//  Created by Kevin Mullins on 5/14/21.
//

import XCTest
import SwiftUI
@testable import SwiftletUtilities

final class SwiftUtilitiesTests: XCTestCase {
    
    func testColors() {
        let text = "FF0000"
        let color = Color(fromHex: text)
        let value = color?.toHex(withPrefix: false, includeAlpha: false)
        XCTAssertEqual(value, text)
    }
    
    func testArrays() {
        var array = ["One", "Two", "Three"]
        array.update(with: "One")
        XCTAssert(array.count == 3)
    }
    
    func testDouble() {
        let value = 1000
        let text = value.formatted()
        XCTAssert(text == "1,000")
    }
    
}
