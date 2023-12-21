//
//  ImageExtensions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 4/15/21.
//

#if !os(macOS) && !os(watchOS)
import Foundation
import SwiftUI
import UIKit
import ImageIO
import LogManager

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

extension UIImage {
    
    /// Composits one `UIImage` into another `UIImage` at the given X and Y coordinates.
    /// - Parameters:
    ///   - image: The `UIImage` to overlay onto the existing image.
    ///   - posX: The X coordinate to write the image to.
    ///   - posY: The Y coordinate to write the image to.
    ///   - topImageSize: The size of the `UIImage` to overlay.
    ///   - combinedImage: A callback that receives the new combined image.
    public func overlayWithAsync(image: UIImage, posX: CGFloat, posY: CGFloat, topImageSize: CGSize,
                     combinedImage: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            let newWidth = self.size.width < posX + image.size.width ? posX + image.size.width : self.size.width
            let newHeight = self.size.height < posY + image.size.height ? posY + image.size.height : self.size.height
            let newSize = CGSize(width: newWidth, height: newHeight)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            //self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
            self.draw(at: CGPoint.zero, blendMode: .copy, alpha: 1)
            image.draw(in: CGRect(origin: CGPoint(x: posX, y: posY), size: topImageSize))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                combinedImage(newImage)
            }
        }
    }
    
    /// Composits one `UIImage` into another `UIImage` at the given X and Y coordinates.
    /// - Parameters:
    ///   - image: The `UIImage` to overlay onto the existing image.
    ///   - posX: The X coordinate to write the image to.
    ///   - posY: The Y coordinate to write the image to.
    ///   - topImageSize: The size of the `UIImage` to overlay or `nil` to use the input image size.
    /// - Returns: Returns the composited `UIImage`.
    public func overlayWith(image: UIImage, posX:CGFloat, posY:CGFloat, topImageSize:CGSize? = nil) -> UIImage {
        var overlaySize:CGSize
        
        // Get the size for the
        if let topImageSize {
            overlaySize = topImageSize
        } else {
            overlaySize = image.size
        }
        
        // Calculate the new image size
        let newWidth = self.size.width < posX + overlaySize.width ? posX + overlaySize.width : self.size.width
        let newHeight = self.size.height < posY + overlaySize.height ? posY + overlaySize.height : self.size.height
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        // Composit the images
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(at: CGPoint.zero, blendMode: .copy, alpha: 1)
        image.draw(in: CGRect(origin: CGPoint(x: posX, y: posY), size: overlaySize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// Returns a `UIImage` from an Asset Catalog scaled to the requested size by the given scale factor.
    /// - Parameters:
    ///   - named: The name of the image asset to load.
    ///   - atScale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image asset scaled to the requested size of `nil` if the image could not be loaded.
    public static func asset(named:String, atScale:CGFloat = 1.0) -> UIImage? {
        
        // Ensure we can load the image
        guard let sourceImage = UIImage(named: named) else {
            return nil
        }
        
        // Are we at full size?
        if atScale == 1.0 {
            // Yes, just return image as-is
            return sourceImage
        }
        
        // Calculate new image size
        let size = CGSize(width:sourceImage.size.width * atScale, height:sourceImage.size.height * atScale)
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            sourceImage.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    /// Returns a `UIImage` from the Asset Catalog scaled to the requested size by the given width and height scale.
    /// - Parameters:
    ///   - named: The name of the image asset to load.
    ///   - atWidthScale: [Optional] The requested width scale for the image. The default is `1.0`.
    ///   - atHeightScale: [Optional] The requested height scale for the image. The default is `1.0`.
    /// - Returns: The requested image asset scaled to the requested size of `nil` if the image could not be loaded.
    public static func asset(named:String, atWidthScale:CGFloat = 1.0, atHeightScale:CGFloat = 1.0) -> UIImage? {
        
        // Ensure we can load the image
        guard let sourceImage = UIImage(named: named) else {
            return nil
        }
        
        // Are we at full size?
        if atWidthScale == 1.0 && atHeightScale == 1.0 {
            // Yes, just return image as-is
            return sourceImage
        }
        
        // Calculate new image size
        let size = CGSize(width:sourceImage.size.width * atWidthScale, height:sourceImage.size.height * atHeightScale)
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            sourceImage.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    /// Returns a `UIImage` scaled to the requested size from a `Data` stream containing the image data.
    /// - Parameters:
    ///   - data: The `Data` stream containing the image data.
    ///   - size: A `CGSize` object containing the requested `width` and `height` for the image.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(data:Data, to size: CGSize, scale:CGFloat = 1.0) -> UIImage? {
        // Create source from data
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let source = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Source data for the image does not exist")
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
            return UIImage(cgImage: image)
        } else {
            return nil
        }
    }
    
    /// Returns a `UIImage` from the given URL scaled to the requested size.
    /// - Parameters:
    ///   - url: The URL of the source image as a `String`.
    ///   - size: A `CGSize` object containing the requested `width` and `height` for the image.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(url: String, to size: CGSize, scale:CGFloat = 1.0) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: This image named \(url) does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image named \(url) into NSData")
            return nil
        }

        return scaledImage(data:imageData, to:size, scale: scale)
    }
    
    /// Returns a `UIImage` from the given URL scaled to the requested size.
    /// - Parameters:
    ///   - bundleURL: A URL pointing to an image resource.
    ///   - size: A `CGSize` object containing the requested `width` and `height` for the image.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(bundleURL:URL?,  to size: CGSize, scale:CGFloat = 1.0) -> UIImage? {
        // Validate
        guard let bundleURL else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Cannot located image at \(String(describing: bundleURL))")
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image \(String(describing: bundleURL)) into NSData")
            return nil
        }

        return scaledImage(data:imageData, to:size, scale: scale)
    }
    
    /// Returns a `UIImage` from the given URL scaled to the requested size.
    /// - Parameters:
    ///   - url: The URL of the source image as a `String`.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(url: String, scale:CGFloat = 1.0) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: This image named \(url) does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image named \(url) into NSData")
            return nil
        }
        
        guard let size = sizeOfImageAt(url: bundleURL) else {
            return nil
        }

        return scaledImage(data:imageData, to:size, scale: scale)
    }
    
    /// Returns a `UIImage` from the given URL scaled to the requested size.
    /// - Parameters:
    ///   - bundleURL: A URL pointing to an image resource.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(bundleURL:URL?, scale:CGFloat = 1.0) -> UIImage? {
        // Validate
        guard let bundleURL else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Cannot located image at \(String(describing: bundleURL))")
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image \(String(describing: bundleURL)) into NSData")
            return nil
        }
        
        guard let size = sizeOfImageAt(url: bundleURL) else {
            return nil
        }

        return scaledImage(data:imageData, to:size, scale: scale)
    }
    
    /// Returns a `UIImage` with the given name from the Main App Bundle scaled to the requested size. This routine currently only works with `.jpg` and `.png` image types.
    /// - Parameters:
    ///   - name: The name of the image to load from the bundle.
    ///   - size: A `CGSize` object containing the requested `width` and `height` for the image.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(name: String, to size: CGSize, scale:CGFloat = 1.0) -> UIImage? {
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
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image named \(name) into NSData")
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
    
    /// Returns a `UIImage` with the given name from the Main App Bundle scaled to the requested size.
    /// - Parameters:
    ///   - name: The name of the image to load.
    ///   - scale: [Optional] The requested scale for the image. The default is `1.0`.
    /// - Returns: The requested image scaled to the requested size of `nil` if the image could not be loaded.
    public class func scaledImage(name: String, scale:CGFloat = 1.0) -> UIImage? {
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
            Debug.error(subsystem: "UIImageExtensions", category: "scaledImage", "ScaledImage: Cannot turn image named \(name) into NSData")
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

