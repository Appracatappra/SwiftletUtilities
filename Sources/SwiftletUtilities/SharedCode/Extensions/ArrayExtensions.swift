//
//  ArrayExtensions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 4/21/21.
//

import Foundation

/**
 Extends `Array` to support the Action Data controls and adds convenience methods for working with colors in a `Codable`, `Encodable` or `Decodable` class.
 
 ## Examples:
 
 ```swift
 // Build a sample array.
 var values = ["One", "Two"]
 
 // Add new values if they don't already exist
 values.update(with: ["One", "Three"])
 ```
 */
extension Array where Element: Equatable{
    
    /**
     Updates the array by replacing matching items with the new version.
     
     ## Examples:
     
     ```swift
     // Build a sample array.
     var values = ["One", "Two"]
     
     // Add new values if they don't already exist
     values.update(with: "One")
     ```
     
     - Parameter element: The element to update in the array.
     
     - Remark: This function will add the element if it doesn't already exist.
     */
    public mutating func update(with element:Element) {
        var n = 0
        for item in self {
            if item == element {
                remove(at: n)
                insert(element, at: n)
                return
            }
            
            n += 1
        }
        
        // Not found, append element
        append(element)
    }
    
    /**
     Updates the array by replacing matching items with the new version.
     
     ## Examples:
     
     ```swift
     // Build a sample array.
     var values = ["One", "Two"]
     
     // Add new values if they don't already exist
     values.update(with: ["One", "Three"])
     ```
     
     - Parameter elements: The list of elements to update in the array.
     
     - Remark: This function will add the element if it doesn't already exist.
     */
    public mutating func update(with elements:[Element]) {
        
        // If empty just add all items to self
        guard count > 0 else {
            append(contentsOf: elements)
            return
        }
        
        // Update individual items
        for element in elements {
            update(with: element)
        }
    }
}
