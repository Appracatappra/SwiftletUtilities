//
//  StringExtensions.swift
//  CoderPlayground
//
//  Created by Kevin Mullins on 9/26/17.
//  Copyright © 2017 Appracatappra, LLC. All rights reserved.
//

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
    
    // MARK: - Enumerations
    /// Defines the type of truncation that will be applied to a string that is too long.
    public enum TruncationPosition {
        /// Truncate head, example "...my string".
        case head
        
        /// Truncate middle, example "my...string".
        case middle
        
        /// Truncate end, example "my string...".
        case tail
    }
    
    // MARK: - Custom Operators
    /**
     Sets the `String` from the given `Color` where the color is converted to a hex string in the format `#rrggbbaa` where:
     
     * `rr` - Specifies the red component as a hex value in the range 00 to FF.
     * `gg` - Specifies the green component as a hex value in the range 00 to FF.
     * `bb` - Specifies the blue component as a hex value in the range 00 to FF.
     * `aa` - Specifies the alpha component as a hex value in the range 00 to FF.
     
     ## Examples:
     ```swift
     // Get the hex representation of a color in iOS, tvOS and watchOS.
     let hex: String ~= Color.white
     ```
     
     */
    public static func ~= ( left: inout String, right: Color) {
        left = right.toHex()
    }
    
    /**
     Tests the two string to see if they are equal, ignoring case.
     
     ## Examples:
     ```swift
     // Build Strings
     let store1 = "Store"
     let store2 = "store"
     
     // Compare
     if store1 === store 2 {
     }
     ```
     */
    public static func === ( left: String, right: String) -> Bool  {
        return left.compare(right, options: .caseInsensitive) == .orderedSame
    }
    
    // MARK: - Public Functions
    /**
     Attempts to convert the `String` into a `Color` if it is in the format `rrggbb` or `rrggbbaa` where:
     
     * `rr` - Specifies the red component as a hex value in the range 00 to FF.
     * `gg` - Specifies the green component as a hex value in the range 00 to FF.
     * `bb` - Specifies the blue component as a hex value in the range 00 to FF.
     * `aa` - Specifies the alpha component as a hex value in the range 00 to FF.
     
     ## Examples:
     ```swift
     // Get the hex representation of a color in iOS, tvOS and watchOS.
     let hex: String ~= Color.white
     let color = hex.uiColor
     ```
     
     The hex string can optionally start with the prefix of `#`. If the `String` cannot be converted to a `UIImage`, `nil` is returned.
    */
    public var color: Color? {
        return Color(fromHex: self)
    }
    
    // MARK: - Initializers
    /**
     Initializes a `String` instance from a given `Color` stored in the format `#rrggbbaa` where:
     
     * `rr` - Specifies the red component as a hex value in the range 00 to FF.
     * `gg` - Specifies the green component as a hex value in the range 00 to FF.
     * `bb` - Specifies the blue component as a hex value in the range 00 to FF.
     * `aa` - Specifies the alpha component as a hex value in the range 00 to FF.
     
     ## Examples:
     ```swift
     // Get the hex representation of a color in iOS, tvOS and watchOS.
     let hex = String(fromColor: Color.white)
     ```
     
     - Parameter color: The given `Color` to convert to a hex string.
     */
    public init(fromColor color: Color) {
        self = color.toHex()
    }
    
    /**
     Returns a pretty-printed type name (minus the module name) for the given value.
     
     ## Example:
     ```swift
     // Assings a pretty type name
     let name = String.typeName(of: "<module>")
     ```
     
     - Parameter value: The value to get the type name of.
     - Returns: The type name minus the module name.
     */
    public static func typeName(of value: Any) -> String {
        // Use a mirror to get the type name
        let mirror = Mirror(reflecting: value)
        var name = "\(mirror.subjectType)"
        
        // Clean up dictionary names
        name = name.replacingOccurrences(of: "<", with: "(")
        name = name.replacingOccurrences(of: ">", with: ")")
        
        // Remove the module name if included
        if name.contains(".") {
            let parts = name.components(separatedBy: ".")
            return parts[parts.count-1]
        } else {
            return name
        }
    }
    
    /**
     Returns the draw height of the string in the given font constrained to the given width.
     
     ## Example:
     ```swift
     // Get a string height in iOS, tvOS and watchOS
     let font = UIFont.systemFont(ofSize: 34, weight: UIFontWeightThin)
     let text = "Hello World"
     let height = text.height(withConstrainedWidth: 250, font: font)
     ```
     
     - Parameters:
         - width: The pixel width to constrain the string to.
         - font: The font that the string will be drawn in.
     
     - Returns: The height of the string drawn in the given font constrained to the given width.
    */
    public func height(withConstrainedWidth width: CGFloat, font: Font) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /**
     Returns the draw width of the string in the given font constrained to the given height.
     
     ## Example:
     ```swift
     // Get a string height in iOS, tvOS and watchOS
     let font = UIFont.systemFont(ofSize: 34, weight: UIFontWeightThin)
     let text = "Hello World"
     let height = text.width(withConstrainedHeight: 50, font: font)
     ```
     
     - Parameters:
         - height: The pixel height to constrain the string to.
         - font: The font that the string will be drawn in.
     
     - Returns: The width of the string drawn in the given font constrained to the given height.
     */
    public func width(withConstrainedHeight height: CGFloat, font: Font) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    /**
     Returns the drawing bounds of the string in the given font constrained to the given maximum bounds.
     
     ## Example:
     ```swift
     // Get a string height in iOS, tvOS and watchOS
     let font = UIFont.systemFont(ofSize: 34, weight: UIFontWeightThin)
     let text = "Hello World"
     let bounds = text.bounds(withConstrainedSize: GGSize(width: 250, height: 50), font: font)
     ```
     
     - Parameters:
     - size: The maximum pixel width and height on the string.
     - font: The font that the string will be drawn in.
     
     - Returns: The bounds on the string drawn in the given font constrained to the given maximum bounds.
    */
    public func bounds(withConstrainedSize size: CGSize, font: Font) -> CGSize {
        let boundingBox = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return CGSize(width: boundingBox.width, height: boundingBox.height)
    }
    
    /**
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     
     - Parameters:
     - limit: The maximum number of characters in the string.
     - position: Where to apply the truncation.
     - leader: The truncation indicator.
     - Remark: This functions is from https://gist.github.com/budidino/8585eecd55fd4284afaaef762450f98e with a modification by user Serdar Akarca.
    */
    public func truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "...") -> String {
        guard self.count > limit else { return self }
        
        switch position {
        case .head:
            return leader + self.suffix(limit)
        case .middle:
            let headCharactersCount = Int(ceil(Float(limit - leader.count) / 2.0))
            
            let tailCharactersCount = Int(floor(Float(limit - leader.count) / 2.0))
            
            return "\(self.prefix(headCharactersCount))\(leader)\(self.suffix(tailCharactersCount))"
        case .tail:
            return self.prefix(limit) + leader
        }
    }
    
    /**
     Takes a string containing HTML encoded entities and returns the string's value decoded from HTML.
     
     - Returns: Returns the string's value decoded from HTML.
     */
    public var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded ?? self
    }
}
