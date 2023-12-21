//
//  StringExtensions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 9/26/17.
//  Copyright © 2021 Appracatappra, LLC. All rights reserved.
//

#if !os(macOS) && !os(watchOS)
import Foundation
import SwiftUI

/**
 Extends `String` to support the Action Data controls and adds convenience methods for working with `Image` and `Color` properties in a `Codable`, `Encodable` or `Decodable` class.
 
 ## Examples:
 ```swift
 // Get the hex representation of a color in iOS, tvOS and watchOS.
 let hex: String ~= Color.white
 ```
 */
extension String {
    
    // MARK: - Custom Operators
    /**
     Sets the `String` from the given `Image` where the image is converted to a PNG representation and Base 64 encoded.
     
     ## Examples:
     ```swift
     // Get the Base 64 representation of an image in iOS, tvOS and watchOS.
     let hex: String ~= Image(named: "Background.png")
     ```
     */
    public static func ~= ( left: inout String, right: Image) {
        left = right.toString()
    }
    
    // MARK: - Computed Properties
    /**
     If the `String` contains a Base 64 encoded representation of an image it is returns as a `Image`, else `nil` is returned.
     
     ## Examples:
     ```swift
     // Get the Base 64 representation of an image in iOS, tvOS and watchOS.
     let hex: String ~= Image(named: "Background.png")
     let image = hex.image
     ```
    */
    public var image: Image? {
        return Image(fromString: self)
    }
    
    // MARK: - Constructors
    /**
     Initializes a `String` instance from a given `Image` where the image is converted to a PNG representation and Base 64 encoded.
     
     ## Examples:
     ```swift
     // Get the Base 64 representation of an image in iOS, tvOS and watchOS.
     let hex = String(fromImage: Image(named: "Background.png"))
     ```
     */
    public init(fromImage image: Image) {
        self = image.toString()
    }
}
#endif

