//
//  ViewExtensions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 4/15/21.
//

#if !os(macOS)
import Foundation
import SwiftUI

/**
 Extends `View` to support the Action Data controls and adds convenience methods for working with `Image` properties in a `Codable`, `Encodable` or `Decodable` class.
 
 ## Examples:
 ```swift
 // Conver a view to a UIImage
 let image: view.toUIImage()
 ```
 */
extension View {
    /**
    This function changes our View to UIView, then calls another function to convert the newly-made UIView to a UIImage.
     
     ## Examples:
     ```swift
     // Conver a view to a UIImage
     let image: view.toUIImage()
     ```
     
     - Returns: A UIImage from the given view.
     */
    public func toUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        #if swift(>=5.5)
        // Temporarily lock out this line because it's failing to complie in the latest version of Swift 5.5 Beta 3 on iOS.
        #else
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        #endif
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        // Here is the call to the function that converts UIView to UIImage: `.asImage()`
        let image = controller.view.toUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

/**
 Extends `UIView` to support the Action Data controls and adds convenience methods for working with `Image` properties in a `Codable`, `Encodable` or `Decodable` class.
 
 ## Examples:
 ```swift
 // Conver a view to a UIImage
 let image: uiView.toUIImage()
 ```
 */
extension UIView {
    /**
    This is the function to convert UIView to UIImage.
     
     ## Examples:
     ```swift
     // Conver a view to a UIImage
     let image: uiView.toUIImage()
     ```
     
     - Returns: A UIImage from the given UIView.
    */
    public func toUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
#endif
