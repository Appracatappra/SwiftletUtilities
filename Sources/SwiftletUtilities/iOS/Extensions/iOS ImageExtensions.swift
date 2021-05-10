//
//  ImageExtensions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 4/15/21.
//

#if os(iOS)
import Foundation
import SwiftUI

/**
 Extends `Image` to support the Swiftlet Data controls and adds convenience methods for working with image properties in a `Codable`, `Encodable` or `Decodable` class.
 
 ## Examples:
 ```swift
 // Assign aa image from Base 64 encoded String in iOS, tvOS or watchOS
 let imageString = Image(named: "Background.png").toString()
 let image: Image ~= imageString
 ```
*/
extension Image {
    
    // MARK: - Enumerations
    /**
     Defines the Image Representation Format that will be used when converting a `Image` to `String` (via `toString()`) or to `Data` (via `toData()`).
     */
    public enum ImageRepresentationFormat {
        /// Converts the `Image` to a PGN format.
        case pngRepresentation
        
        /// Converts the `Image` to a JPG format with the given Image Quality of `0` (lowest) to `100` (highest).
        case jpgRepresentation(imageQuality: Int)
    }
    
    // MARK: - Custom Operators
    /**
     Sets the `Image` from the given Base 64 encoded `String` instance.
     
     ## Examples:
     ```swift
     // Assign an image from Base 64 encoded String in iOS, tvOS or watchOS
     let imageString = Image(named: "Background.png").toString()
     let image: Image ~= imageString
     ```
     */
    public static func ~= ( left: inout Image, right: String) {
        left = right.image!
    }
    
    /**
     Sets the `Image` from the given `Data` instance.
     
     ## Examples:
     ```swift
     // Assign an image from Base 64 encoded Data in iOS, tvOS or watchOS
     let imageData = Image(named: "Background.png").toData()
     let image: Image ~= imageData
     ```
     */
    public static func ~= ( left: inout Image, right: Data) {
        left = right.image!
    }
    
    // MARK: - Public Functions
    /**
     Converts the `Image` to a `String` representation encoded in Base 64.
     
     ## Examples:
     ```swift
     // Assign an image to Base 64 encoded String in iOS, tvOS or watchOS
     let imageString = Image(named: "Background.png").toString()
     ```
     
     - Parameter imageRepresentation: Determines the representation that will be used when converting the image. The default is `pngRepresentation`.
     
     - Returns: The `Image` in the requested representation converted to a Base 64 encoded string.
     */
    public func toString(imageRepresentation: ImageRepresentationFormat = .pngRepresentation) -> String {
        var rawData: Data?
        let image = self.toUIImage()
        
        // Take action based on the desired image representation
        switch imageRepresentation {
        case .pngRepresentation:
            rawData = image.pngData()
        case .jpgRepresentation(let imageQuality):
            let quality = Float(imageQuality) * 0.01
            rawData = image.jpegData(compressionQuality: CGFloat(quality))
        }
        
        // Encode as base64 and return
        let base64 = rawData?.base64EncodedString(options: .lineLength64Characters)
        return base64!
    }
    
    /**
     Converts the `Image` to a `Data` representation.
     
     ## Examples:
     ```swift
     // Assign an image to Base 64 encoded Data in iOS, tvOS or watchOS
     let imageData = Image(named: "Background.png").toString()
     ```
     
     - Parameter imageRepresentation: Determins the representation that will be used when converting the image. The default is `pngRepresentation`.
     
     - Returns: The `Image` in the requested representation converted to a raw `Data`.
     */
    public func toData(imageRepresentation: ImageRepresentationFormat = .pngRepresentation) -> Data? {
        var rawData: Data?
        let image = self.toUIImage()
        
        // Take action based on the desired image representation
        switch imageRepresentation {
        case .pngRepresentation:
            rawData = image.pngData()
        case .jpgRepresentation(let imageQuality):
            let quality = Float(imageQuality) * 0.01
            rawData = image.jpegData(compressionQuality: CGFloat(quality))
        }
        
        // Return the requested data
        return rawData
    }
    
    // MARK: - Initializers
    /**
     Creates a new `Image` instance from a Base 64 encoded string.
     
     ## Examples:
     ```swift
     // Assign an image from Base 64 encoded String in iOS, tvOS or watchOS
     let imageString = Image(named: "Background.png")
     let image = Image(fromString: imageString)
     ```
     
     - Parameter value: A Base 64 encoded `String` representing an image.
     */
    public init?(fromString value: String) {
        let data = Data(base64Encoded: value, options: .ignoreUnknownCharacters)
        let image = UIImage(data: data!)
        
        self.init(uiImage: image!)
    }
    
    /**
     Creates a new `Image` instance from  Base 64 encoded data.
     
     ## Examples:
     ```swift
     // Assign an image from Base 64 encoded data in iOS, tvOS or watchOS
     let imageData = Image(named: "Background.png").ToData()
     let image = Image(data: imageData)
     ```
     
     - Parameter data: Base 64 encoded `Data` representing an image.
     */
    public init?(data:Data) {
        let image = UIImage(data: data)
        
        self.init(uiImage: image!)
    }
}
#endif

