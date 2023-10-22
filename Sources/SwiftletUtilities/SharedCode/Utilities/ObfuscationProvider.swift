//
//  ObfuscationProvider.swift
//  Hex2Hex
//
//  Created by Kevin Mullins on 10/22/23.
//

import Foundation
import SwiftletUtilities

/// `ObfuscationProvider` is a generic utility to provice a simply obfuscation of a string of text.
///  - Remark: This is NOT a cryptographically secure process! It's only meant to hide specific values against casual "prying-eyes".
open class ObfuscationProvider {
    
    // MARK: - Enumerations
    /// Provides the direction of a tumble operation.
    public enum Direction {
        /// Tumble left.
        case left
        
        /// Tumble right.
        case right
    }
    
    // MARK: - Static Properties
    // Holds the charaset used as a sault in the obfuscation process
    public static let characterSet = "0123456789 AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@#$%^&*()_-+={}[]|:;,./?"
    
    // MARK: - Static Functions
    /// Gets the "ASCII" value of the given character.
    /// - Parameter character: The character to get the code for.
    /// - Returns: The "ASCII" code for the given character or `-1` if the character cannot be converted.
    public static func Ascii(_ character:String) -> Int {
        
        // Find position in character set
        for n in 0..<characterSet.count {
            let char = String(characterSet[n])
            if char == character {
                return n
            }
        }
        
        // Not found
        return -1
    }
    
    /// Returns the character for the given "ASCII" code.
    /// - Parameter value: The value to get the character for.
    /// - Returns: The Requested character.
    public static func Character(for value:Int) -> String {
        
        // Ensure that the requested value is safe.
        guard value >= 0 && value < characterSet.count else {
            return ""
        }
        
        // Return character at position.
        return String(characterSet[value])
    }
    
    /// Tumbles the character either left or right by the given amount.
    /// - Parameters:
    ///   - direction: The direction to tumble in.
    ///   - character: The character to tumble.
    ///   - position: The amount to tumble.
    /// - Returns: The tumbled character.
    public static func tumble(direction:Direction, character:String, position:Int) -> String {
        var index = Ascii(character)
        var counter = position
        
        // Ensure the character can be tumbled
        guard index >= 0 else {
            // No, it can't tumble. Just return the input character.
            return character
        }
        
        // Offset the index by the given amount.
        while counter > 0 {
            switch direction {
            case .left:
                index -= 1
                if index < 0 {
                    index = characterSet.count - 1
                }
            case .right:
                index += 1
                if index >= characterSet.count {
                    index = 0
                }
            }
            
            counter -= 1
        }
        
        // Return new character at the offset position.
        return Character(for: index)
    }
    
    /// Generates a checksum for the given string.
    /// - Parameter text: The string to get the checksum for
    /// - Returns: The computed checksum
    public static func checksum(_ text:String) -> Int {
        var checksum:Int = 0
        
        // Compute the checksum
        for n in 0..<text.count {
            let char = String(text[n])
            let value = Ascii(char)
            checksum += (value * n)
        }
        
        return checksum
    }
    
    /// Verifies the string against a checksum.
    /// - Parameters:
    ///   - text: The text to verify.
    ///   - checksum: The initial checksum.
    /// - Returns: Returns `true` if the text verifies against the checksum, else returns `false`.
    public static func verify(text:String, checksum:Int) -> Bool {
        let newChecksum = ObfuscationProvider.checksum(text)
        return (newChecksum == checksum)
    }
    
    /// Obfuscates the given string.
    /// - Parameter text: The string to obfuscate.
    /// - Returns: The obfuscated string.
    public static func obfuscate(_ text:String) -> String {
        var output = ""
        
        for n in 0..<text.count {
            let char = String(text[n])
            let newChar = tumble(direction: .right, character: char, position: n)
            output += newChar
        }
        
        return output
    }
    
    /// Deobfuscates the given string.
    /// - Parameter text: The string to deobfuscate.
    /// - Returns: The deobfuscated string.
    public static func deobfuscate(_ text:String) -> String {
        var output = ""
        
        for n in 0..<text.count {
            let char = String(text[n])
            let newChar = tumble(direction: .left, character: char, position: n)
            output += newChar
        }
        
        return output
    }
    
}
