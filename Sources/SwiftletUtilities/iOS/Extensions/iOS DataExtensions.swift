//
//  DataExtensions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 4/15/21.
//

#if !os(macOS) && !os(watchOS)
import Foundation
import SwiftUI

/**
 Extends `Data` to support the Action Data controls and adds convenience methods for working with data properties in a `Codable`, `Encodable` or `Decodable` class.
 
 ## Examples:
 ```swift
 // Assign data from an image in iOS, tvOS or watchOS
 let imageData: Data ~= Image(named: "Background.png")
 ```
*/
extension Data {
    
    // MARK: - Custom Operators
    /**
     Sets the `Data` instance from the given `Image` instance.
     
     ## Examples:
     ```swift
     // Assign data from an image in iOS, tvOS or watchOS
     let imageData: Data ~= Image(named: "Background.png")
     ```
     */
    public static func ~= ( left: inout Data, right: Image) {
        left = right.toData()!
    }
    
    // MARK: - Public Properties
    /**
     Attempts to create a `Image` from the data stored in the current `Data` instance. Returns the Image if it can be created else returns `nil`.
     
     ## Examples:
     ```swift
     // Assign data from an image in iOS, tvOS or watchOS
     let imageData: Data ~= Image(named: "Background.png")
     if let image = imageData.image {
        ...
     }
     ```
     */
    public var image: Image? {
        return Image(data: self)
    }
}
#endif
