//
//  IntegerExtensions.swift
//  ActionUtilities iOS
//
//  Created by Kevin Mullins on 2/26/19.
//

import Foundation

/**
 Extends `Int` with several useful features.
 
 ## Example:
 ```swift
 let n:Int = 1000
 
 // Returns 1,000
 let text = n.formatted()
 ```
 */
public extension Int {
    
    /**
     Returns the Int as a string formatted with the given pattern.
     
     - Parameter formatString: The pattern to format the Int into. The default pattern is `#,##0.##`.
     - Returns: The Int as a string in the given format.
    */
    func formatted(as formatString:String = "#,##0.##") -> String {
        let formatter = NumberFormatter()
        formatter.positiveFormat = formatString
        formatter.negativeFormat = formatString
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    /// Converts a `String` to an `Int`.
    /// - Parameter text: The text holding the number.
    /// - Parameter defaultValue: The default value to return if the text cannot be converted.
    /// - Returns: Returns the `String` as an `Int` or the `defaultValue` if it cannot be converted.
    static func from(_ text:String, defaultValue:Int = 0) -> Int {
        if let value = Int(text) {
            return value
        } else {
            return defaultValue
        }
    }
    
    /// Converts a `Substring` to an `Int`.
    /// - Parameter text: The text holding the number.
    /// - Parameter defaultValue: The default value to return if the text cannot be converted.
    /// - Returns: Returns the `String` as an `Int` or the `defaultValue` if it cannot be converted.
    static func from(_ text:Substring, defaultValue:Int = 0) -> Int {
        return from(String(text), defaultValue: defaultValue)
    }
    
    /// Converts the `Int` to a `String`.
    /// - Returns: Returns the `Int` as a `String`.
    func print() -> String {
        return "\(self)"
    }
}
