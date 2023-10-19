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
    
    /// Options available when trimming a string.
    enum TrimmingOptions {
        /// Remove all whitespace characters from the string.
        case all
        
        /// Remove leading whitspace characters.
        case leading
        
        /// Remove trailing whitspace characters.
        case trailing
        
        /// REmove leading and trailing whitspace characters.
        case leadingAndTrailing
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
    
    /// Appends the given value to the end of the `String` inserting the given `separator` if the string isn't empty before the addition.
    /// - Parameters:
    ///   - value: The value to add.
    ///   - separator: The separator sequence to use.
    mutating func concat(_ value:String, separator:String = ",") {
        if self == "" {
            self = value
        } else {
            self = "\(self)\(separator)\(value)"
        }
    }
    
    /// Trims the given string with the given options.
    /// - Parameters:
    ///   - spaces: Defines the type of trim operation that should be performed.
    ///   - characterSet: Defines the type of whipspaces to remove.
    /// - Returns: The string with the requested whitespaces removed.
    func trimming(spaces: TrimmingOptions, using characterSet: CharacterSet = .whitespacesAndNewlines) ->  String {
        switch spaces {
        case .all: return trimmingAllSpaces(using: characterSet)
        case .leading: return trimingLeadingSpaces(using: characterSet)
        case .trailing: return trimingTrailingSpaces(using: characterSet)
        case .leadingAndTrailing:  return trimmingLeadingAndTrailingSpaces(using: characterSet)
        }
    }
    
    /// Removes leading whitespaces from the string.
    /// - Parameter characterSet: The type of whitespaces to remove.
    /// - Returns: The string with the leading whitespaces removed.
    private func trimingLeadingSpaces(using characterSet: CharacterSet) -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
            return self
        }

        return String(self[index...])
    }
    
    /// Removes the trailing whitespaces from the string.
    /// - Parameter characterSet: The types of whitespaces to remove.
    /// - Returns: The string with the trailing whitespaces removed.
    private func trimingTrailingSpaces(using characterSet: CharacterSet) -> String {
        guard let index = lastIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
            return self
        }

        return String(self[...index])
    }
    
    /// Removes the leading and trailing whitespaces from the string.
    /// - Parameter characterSet: The types of whitespaces to remove.
    /// - Returns: The string with the leading and trailing whitespaces removed.
    private func trimmingLeadingAndTrailingSpaces(using characterSet: CharacterSet) -> String {
        return trimmingCharacters(in: characterSet)
    }
    
    /// Removes all whitespaces characters from the string.
    /// - Parameter characterSet: The type of whitespaces characters to remove.
    /// - Returns: The string with all whitespaces characters removed.
    private func trimmingAllSpaces(using characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }
    
    /// Returns the string Base 64 encoded.
    /// - Returns: The encoded string or empty string ("") if unable to encode.
    func base64Encoded() -> String {
        if let value = data(using: .utf8)?.base64EncodedString() {
            return value
        } else {
            return ""
        }
    }
    
    /// Returns the string decoded from Base 64.
    /// - Returns: The decoded string or empty string ("") if unable to decode.
    func base64Decoded() -> String {
        guard let data = Data(base64Encoded: self) else { return "" }
        
        if let value = String(data: data, encoding: .utf8) {
            return value
        } else {
            return ""
        }
    }
    
    /// Checks to see if the string contains the given pattern ignoring case.
    /// - Parameters:
    ///   - inputPattern: The pattern that you are looking for.
    ///   - partialMatch: If `true` allow for partial pattern matches. If `false`, the entire string must match.
    /// - Returns: Returns `true` if the string contains the pattern.
    func hasPattern(_ inputPattern:String, partialMatch:Bool = true) -> Bool {
        var text = self.lowercased()
        var pattern = inputPattern.lowercased()
        
        // Are we doing a simple one-to-one compare?
        guard partialMatch else {
            return (text == pattern)
        }
        
        // Pad both entries to ensure we get the correct match types
        text = " \(text) "
        pattern = " \(pattern) "
        
        // Does the text contain the pattern?
        return text.contains(pattern)
    }
    
    /// Returns a random part from a pipe "|" separated string.
    /// - Returns: A random part or the entire string if no pipe "|" exist.
    func randomPart() -> String {
        
        guard self.contains("|") else {
            return self
        }
        
        let parts = self.components(separatedBy: "|")
        
        let max:Int = parts.count - 1
        let index = Int.random(in: 0...max)
        
        return parts[index]
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
