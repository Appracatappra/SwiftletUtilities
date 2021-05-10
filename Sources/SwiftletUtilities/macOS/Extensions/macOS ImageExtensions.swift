//
//  ImageExtensions.swift
//  SwiftletUtilities macOS
//
//  Created by Kevin Mullins on 4/16/21.
//  Copyright © 2021 Appracatappra, LLC. All rights reserved.
//

#if os(macOS)
import Foundation
import SwiftUI
import AppKit

/**
 Extends `NSBitmapImageRep` to support the Action Data controls and adds convenience methods for working with image properties in a `Codable`, `Encodable` or `Decodable` class.
 
 */
extension NSBitmapImageRep {
    
    /// Returns the bitmap as data in the png format.
    public var pngData: Data? {
        return representation(using: .png, properties: [:])
    }
    
    /// Returns the bitmap as data in the jpeg format.
    public var jpgData: Data? {
        return representation(using: .jpeg, properties: [:])
    }
}

/**
 Extends `NSImage` to support the Action Data controls and adds convenience methods for working with image properties in a `Codable`, `Encodable` or `Decodable` class.
 
 ## Examples:
 ```swift
 // Assign aa image from Base 64 encoded String in macOS
 let imageString = NSImage(named: "Background.png").toString()
 let image: NSImage ~= imageString
 ```
 */
extension NSImage {
    
    /**
     Returns the image as data in the png format.
     
     ## Example:
     ```swift
     // Get png Data from image
     let data = NSImage(named: "Background.png").pngData
     ```
    */
    public var pngData: Data? {
        if let tiffData = tiffRepresentation {
            if let bitmap = NSBitmapImageRep(data: tiffData) {
                return bitmap.pngData
            }
        }
        return nil
    }
    
    /**
     Returns the image as data in the jpeg format.
     
     ## Example:
     ```swift
     // Get jpeg Data from image
     let data = NSImage(named: "Background.png").jpgData
     ```
     */
    public var jpgData: Data? {
        if let tiffData = tiffRepresentation {
            if let bitmap = NSBitmapImageRep(data: tiffData) {
                return bitmap.jpgData
            }
        }
        return nil    }
    
    /**
     Defines the Image Representation Format that will be used when converting a `NSImage` to `String` (via `toString()`) or to `Data` (via `toData()`).
     */
    public enum ImageRepresentationFormat {
        /// Converts the `NSImage` to a PGN format.
        case pngRepresentation
        
        /// Converts the `NSImage` to a JPG format with the given Image Quality of `0` (lowest) to `100` (highest).
        case jpgRepresentation(imageQuality: Int)
    }
    
    // MARK: - Custom Operators
    /**
     Sets the `NSImage` from the given `String` Instance.
     
     ## Examples:
     ```swift
     // Assign an image from Base 64 encoded String in macOS
     let imageString = NSImage(named: "Background.png").toString()
     let image: NSImage ~= imageString
     ```
     */
    public static func ~= ( left: inout NSImage, right: String) {
        left = right.nsImage!
    }
    
    /**
     Sets the `NSImage` from the given `Data` instance.
     
     ## Examples:
     ```swift
     // Assign an image from Base 64 encoded Data in macOS
     let imageData = NSImage(named: "Background.png").toData()
     let image: NSImage ~= imageData
     ```
     */
    public static func ~= ( left: inout NSImage, right: Data) {
        left = right.nsImage!
    }
    
    // MARK: - Public Functions
    /**
     Converts the `NSImage` to a `String` representation encoded in Base 64.
     
     ## Examples:
     ```swift
     // Assign an image to Base 64 encoded String in macOS
     let imageString = NSImage(named: "Background.png").toString()
     ```
     
     - Parameter imageRepresentation: Determines the representation that will be used when converting the image. The default is `pngRepresentation`.
     
     - Returns: The `NSImage` in the requested representation converted to a Base 64 encoded string.
     */
    public func toString(imageRepresentation: ImageRepresentationFormat = .pngRepresentation) -> String {
        var rawData: Data?
        
        // Take action based on the desired image representation
        switch imageRepresentation {
        case .pngRepresentation:
            rawData = pngData
        case .jpgRepresentation(_):
            //let quality = Float(imageQuality) * 0.01
            rawData = jpgData
        }
        
        // Encode as base64 and return
        let base64 = rawData?.base64EncodedString(options: .lineLength64Characters)
        return base64!
    }
    
    /**
     Converst the `NSImage` to a `Data` representation.
     
     ## Examples:
     ```swift
     // Assign an image to Base 64 encoded Data in macOS
     let imageData = NSImage(named: "Background.png").toString()
     ```
     
     - Parameter imageRepresentation: Determins the representation that will be used when converting the image. The default is `pngRepresentation`.
     
     - Returns: The `NSImage` in the requested representation converted to a raw `Data`.
     */
    public func toData(imageRepresentation: ImageRepresentationFormat = .pngRepresentation) -> Data? {
        var rawData: Data?
        
        // Take action based on the desired image representation
        switch imageRepresentation {
        case .pngRepresentation:
            rawData = pngData
        case .jpgRepresentation(_):
            //let quality = Float(imageQuality) * 0.01
            rawData = jpgData
        }
        
        // Return the requested data
        return rawData
    }
    
    // MARK: - Initializers
    /**
     Creates a new `NSImage` instance from a Base 64 encoded string.
     
     ## Examples:
     ```swift
     // Assign an image from Base 64 encoded String in macOS
     let imageString = NSImage(named: "Background.png").toString()
     let image = NSImage(fromString: imageString)
     ```
     
     - Parameter value: A Base 64 encoded `String` representing an image.
     */
    public convenience init?(fromString value: String) {
        let data = Data(base64Encoded: value, options: .ignoreUnknownCharacters)
        self.init(data: data!)
    }
    
    /**
     Creates a new `NSImage` instance from a string specifying the name of an image added as an asset.
     
     ## Examples:
     ```swift
     // Assign an image from an asset name in macOS
     let imageString = NSImage(named: "Background.png")
     ```
     
     - Parameter value: A Base 64 encoded `String` representing an image.
     */
    public convenience init?(named: String) {
        self.init(named: NSImage.Name(named))
    }
}
#endif
