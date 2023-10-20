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
import LogManager

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
//    public convenience init?(named: String) {
//        self.init(named: NSImage.Name(named))
//    }
    
    /// Function for resizing an NSImage.
    /// - Parameters:
    ///   - image: The NSImage to resize.
    ///   - maxSize: The maximum Size for the Image.
    /// - Returns: The resized Image
    public static func resizeImage(image:NSImage, maxSize:NSSize) -> NSImage {
        var ratio:Float = 0.0
        let imageWidth = Float(image.size.width)
        let imageHeight = Float(image.size.height)
        let maxWidth = Float(maxSize.width)
        let maxHeight = Float(maxSize.height)
        
        // Get ratio (landscape or portrait)
        if (imageWidth > imageHeight) {
            // Landscape
            ratio = maxWidth / imageWidth;
        }
        else {
            // Portrait
            ratio = maxHeight / imageHeight;
        }
        
        // Calculate new size based on the ratio
        let newWidth = imageWidth * ratio
        let newHeight = imageHeight * ratio
        
        // Create a new NSSize object with the newly calculated size
        let newSize:NSSize = NSSize(width: Int(newWidth), height: Int(newHeight))
        
        // Cast the NSImage to a CGImage
        var imageRect:CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
        let imageRef = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
        
        // Create NSImage from the CGImage using the new size
        let imageWithNewSize = NSImage(cgImage: imageRef!, size: newSize)
        
        // Return the new image
        return imageWithNewSize
    }
    
    /// Returns a `NSImage` from an Asset Catalog scaled to the requested size by the given scale factor.
    /// - Parameters:
    ///   - named: The name of the image asset to load.
    ///   - atScale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image asset scaled to the requested size of `nil` if the image could not be loaded.
    public static func asset(named:String, atScale:CGFloat = 1.0) -> NSImage? {
        
        // Ensure we can load the image
        guard let sourceImage = NSImage(named: named) else {
            return nil
        }
        
        // Are we at full size?
        if atScale == 1.0 {
            // Yes, just return image as-is
            return sourceImage
        }
        
        // Calculate new image size
        let size = NSSize(width:sourceImage.size.width * atScale, height:sourceImage.size.height * atScale)
        
        // Return the resized image.
        return NSImage.resizeImage(image: sourceImage, maxSize: size)
    }
    
    /// Returns a `NSImage` from the Asset Catalog scaled to the requested size by the given width and height scale.
    /// - Parameters:
    ///   - named: The name of the image asset to load.
    ///   - atWidthScale: [Optional] The requested width scale for the image. The default is `1.0`.
    ///   - atHeightScale: [Optional] The requested height scale for the image. The default is `1.0`.
    /// - Returns: The requested image asset scaled to the requested size of `nil` if the image could not be loaded.
    public static func asset(named:String, atWidthScale:CGFloat = 1.0, atHeightScale:CGFloat = 1.0) -> NSImage? {
        
        // Ensure we can load the image
        guard let sourceImage = NSImage(named: named) else {
            return nil
        }
        
        // Are we at full size?
        if atWidthScale == 1.0 && atHeightScale == 1.0 {
            // Yes, just return image as-is
            return sourceImage
        }
        
        // Calculate new image size
        let size = NSSize(width:sourceImage.size.width * atWidthScale, height:sourceImage.size.height * atHeightScale)
        
        // Return the resized image.
        return NSImage.resizeImage(image: sourceImage, maxSize: size)
    }
    
    /// Returns a `NSImage` scaled to the requested size from a `Data` stream containing the image data.
    /// - Parameters:
    ///   - data: The `Data` stream containing the image data.
    ///   - size: A `CGSize` object containing the requested `width` and `height` for the image.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(data:Data, to size: CGSize, scale:CGFloat = 1.0) -> NSImage? {
        // Create source from data
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let source = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
            Debug.error(subsystem: "NSImageExtensions", category: "scaledImage", "ScaledImage: Source data for the image does not exist")
            return nil
        }
        
        // Calculate the desired dimension
        let maxDimensionInPixels = max(size.width, size.height) * scale
        
        let options: [CFString: Any] = [
                kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
            ]
        
        if let image = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary) {
            return NSImage(cgImage: image, size: size)
        } else {
            return nil
        }
    }
    
    /// Returns a `NSImage` from the given URL scaled to the requested size.
    /// - Parameters:
    ///   - url: The URL of the source image.
    ///   - size: A `CGSize` object containing the requested `width` and `height` for the image.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(url: String, to size: CGSize, scale:CGFloat = 1.0) -> NSImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            Debug.error(subsystem: "NSImageExtensions", category: "scaledImage", "ScaledImage: This image named \(url) does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            Debug.error(subsystem: "NSImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image named \(url) into NSData")
            return nil
        }

        return scaledImage(data:imageData, to:size, scale: scale)
    }
    
    /// Returns a `NSImage` from the given URL scaled to the requested size.
    /// - Parameters:
    ///   - url: The URL of the source image.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(url: String, scale:CGFloat = 1.0) -> NSImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            Debug.error(subsystem: "NSIImageExtensions", category: "scaledImage", "ScaledImage: This image named \(url) does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            Debug.error(subsystem: "NSImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image named \(url) into NSData")
            return nil
        }
        
        guard let size = sizeOfImageAt(url: bundleURL) else {
            return nil
        }

        return scaledImage(data:imageData, to:size, scale: scale)
    }
    
    /// Returns a `NSImage` with the given name from the Main App Bundle scaled to the requested size. This routine currently only works with `.jpg` and `.png` image types.
    /// - Parameters:
    ///   - name: The name of the image to load from the bundle.
    ///   - size: A `CGSize` object containing the requested `width` and `height` for the image.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(name: String, to size: CGSize, scale:CGFloat = 1.0) -> NSImage? {
        var bundleURL:URL? = nil
        
        // Try to load as jpg first
        bundleURL = Bundle.main.url(forResource: name, withExtension: "jpg")
        
        // If not found, try png
        if bundleURL == nil {
            bundleURL = Bundle.main.url(forResource: name, withExtension: "png")
        }
        
        guard let bundleURL = bundleURL else {
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            Debug.error(subsystem: "NSImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image named \(name) into NSData")
            return nil
        }
        
        return scaledImage(data:imageData, to:size, scale: scale)
    }
    
    /// Returns the URL pointing to an image in the Main App Bundle with the given name and extension.
    /// - Parameters:
    ///   - name: The name of the image
    ///   - withExtension: The extension of the image.
    /// - Returns: The URL pointing to the requested image resource or `nil` if the image cannot be found.
    public class func urlOfImageInBundle(name:String, withExtension:String) -> URL? {
        
        guard let path = Bundle.main.path(forResource: name, ofType: withExtension) else {
            return nil
        }
        
        return URL(fileURLWithPath: path)
    }
    
    /// Returns a `NSImage` with the given name from the Main App Bundle scaled to the requested size.
    /// - Parameters:
    ///   - name: The name of the image to load.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(name: String, scale:CGFloat = 1.0) -> NSImage? {
        var bundleURL:URL? = nil
        
        // Try to load as jpg first
        bundleURL = Bundle.main.url(forResource: name, withExtension: "jpg")
        
        // If not found, try png
        if bundleURL == nil {
            bundleURL = Bundle.main.url(forResource: name, withExtension: "png")
        }
        
        guard let bundleURL = bundleURL else {
            return nil
        }
        
        guard let size = sizeOfImageAt(url: bundleURL) else {
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            Debug.error(subsystem: "NSImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image named \(name) into NSData")
            return nil
        }
        
        return scaledImage(data:imageData, to:size, scale: scale)
    }
    
    /// Returns the size of the image at the requested URL.
    /// - Parameter url: The URL pointing to the requested image
    /// - Returns: A `CGSize` containing the width and height of the requeste image or `nil` if the image cannot be found.
    public static func sizeOfImageAt(url: URL) -> CGSize? {
        // with CGImageSource we avoid loading the whole image into memory
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return nil
        }
        
        let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
            return nil
        }
        
        if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
           let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
            return CGSize(width: width, height: height)
        } else {
            return nil
        }
    }
}
#endif
