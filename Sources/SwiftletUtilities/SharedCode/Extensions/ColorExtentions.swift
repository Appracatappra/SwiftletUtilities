//
//  ColorExtentions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 4/15/21.
//  Copyright © 2021 Appracatappra, LLC. All rights reserved.

import Foundation
import SwiftUI

/**
 Extends `Color` to support the Action Data controls and adds convenience methods for working with colors in a `Codable`, `Encodable` or `Decodable` class.
 
 ## iOS, tvOS and watchOS Examples:
 
 ```swift
 // Assign a color from a string
 let color: Color ~= "#FF0000"
 
 // Initialize a color from a hex string
 let green = Color(fromHex: "00FF00")
 
 // Convert color to a hex string
 let white = Color.white.toHex()
 ```
 */
extension Color {
    
    // MARK: - Custom Operators
    /**
     Sets a `Color` from a hex string in the format `rrggbb` or `rrggbbaa` where:
     
     * `rr` - Specifies the red component as a hex value in the range 00 to FF.
     * `gg` - Specifies the green component as a hex value in the range 00 to FF.
     * `bb` - Specifies the blue component as a hex value in the range 00 to FF.
     * `aa` - Specifies the alpha component as a hex value in the range 00 to FF.
     
     The hex string can optionally start with the prefix of `#`.
     
     ## Examples:
     ```swift
     // Assign a color from a string in iOS, tvOS or watchOS
     let color: Color ~= "#FF0000"
     ```
     */
    public static func ~= ( left: inout Color, right: String) {
        left = right.color!
    }
    
    // MARK: - Initializers
    /**
     Initializes a `UIColor` from a hex string in the format `rrggbb` or `rrggbbaa` where:
     
     * `rr` - Specifies the red component as a hex value in the range 00 to FF.
     * `gg` - Specifies the green component as a hex value in the range 00 to FF.
     * `bb` - Specifies the blue component as a hex value in the range 00 to FF.
     * `aa` - Specifies the alpha component as a hex value in the range 00 to FF.
     
     The hex string can optionally start with the prefix of `#`.
     
     ## Examples:
     ```swift
     // Assign a color from a string in iOS, tvOS or watchOS
     let color = UIColor(fromHex: "#FF0000")
     ```
     
     - Parameter hex: The hex value to convert to a `UIColor`.
     */
    public init?(fromHex hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(RGBColorSpace.sRGBLinear, red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
    }
    
    /**
     Initializes a `Color` for the given grayscale percent and alph value.
     
     ## Example:
     ```swift
     let gray = Color(fromGrayScaleShade: 200)
     ```
     
     - Parameters:
         - shade: A number from 0 to 255 specifying the shade of gray to mix.
         - alphaPercent: A number from 0 to 100 specifying the opacity of the color.
    */
    public init(fromGrayScaleShade shade:Int, withAlphaPercent alphaPercent: Int = 100) {
        let value = CGFloat(shade) / 255.0
        let alphaValue = CGFloat(alphaPercent) / 100.0
        self.init(RGBColorSpace.sRGB, red: Double(value), green: Double(value), blue: Double(value), opacity: Double(alphaValue))
    }
    
    /**
     Initializes a `Color` from the given red, green, blue and alpha values.
     
     ## Example:
     ```swift
     let white = Color(red: 255, green: 255, blue: 255)
     ```
     
     - Parameters:
         - red: A number between 0 and 255.
         - green: A number between 0 and 255.
         - blue: A number between 0 and 255.
         - alpha: A percentage between 0 and 100.
    */
    public init(red: Int, green: Int, blue: Int, alpha: Int = 100) {
        let r = CGFloat(red) / 255.0
        let g = CGFloat(green) / 255.0
        let b = CGFloat(blue) / 255.0
        let a = CGFloat(alpha) / 100.0
        
        self.init(RGBColorSpace.sRGB, red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
    }
    
    /**
     Initialize a `Color` from the given tuple of red, green, blue and alpha values where:
     
     * `red` - Is a number between 0 and 255.
     * `green` - Is a number between 0 and 255.
     * `blue` - Is a number between 0 and 255.
     * `alpha` - Is a percentage between 0 and 100.
     
     ## Example:
     ```swift
     let white = Color(fromRGBA: (red: 255, green: 255, blue: 255, alpha: 100))
     ```
     
     - Parameter rgbComponents: A tuple of red, green, blue and alpha values.
    */
    public init (fromRGBA rgbComponents: (red: Int, green: Int, blue: Int, alpha: Int)) {
        let r = CGFloat(rgbComponents.red) / 255.0
        let g = CGFloat(rgbComponents.green) / 255.0
        let b = CGFloat(rgbComponents.blue) / 255.0
        let a = CGFloat(rgbComponents.alpha) / 100.0
        
        self.init(RGBColorSpace.sRGB, red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
    }
    
    /**
     Initializes a `Color` from the given hue, saturation, brightness and alpha values.
     
     ## Example:
     ```swift
     let red = Color(hue: 0, saturation: 100, brightness: 100)
     ```
     
     - Parameters:
         - hue: A number between 0 and 360.
         - saturation: A percentage between 0 and 100.
         - brightness: A percentage between 0 and 100.
         - alpha: A percentage between 0 and 100.
    */
    public init (hue: Int, saturation: Int, brightness: Int, alpha: Int = 100) {
        let h = CGFloat(hue) / 360.0
        let s = CGFloat(saturation) / 100.0
        let b = CGFloat(brightness) / 100.0
        let a = CGFloat(alpha) / 100.0
        
        self.init(hue: Double(h), saturation: Double(s), brightness: Double(b), opacity: Double(a))
    }
    
    /**
     Initializes a `Color` from the given tuple of hue, saturation, brightness and alpha values where:
     
     * `hue` - Is a number between 0 and 360.
     * `saturation` - Is a percentage between 0 and 100.
     * `brightness` - Is a percentage between 0 and 100.
     * `alpha` - Is a percentage between 0 and 100.
     
     ## Example:
     ```swift
     let red = Color(fromHSBA: (hue: 0, saturation: 100, brightness: 100, alpha: 100))
     ```
     
     - Parameter hsbComponents: A tuple of hue, saturation, brightness and alpha values.
    */
    public init(fromHSBA hsbComponents: (hue: Int, saturation: Int, brightness: Int, alpha: Int)) {
        let h = CGFloat(hsbComponents.hue) / 360.0
        let s = CGFloat(hsbComponents.saturation) / 100.0
        let b = CGFloat(hsbComponents.brightness) / 100.0
        let a = CGFloat(hsbComponents.alpha) / 100.0
        
        self.init(hue: Double(h), saturation: Double(s), brightness: Double(b), opacity: Double(a))
    }
    
    // MARK: - Computed Properties
    /**
     Holds the color scheme defined by the frontend UI.
     */
    public nonisolated(unsafe) static var colorScheme: ColorScheme = .light
    
    /**
     Returns the system gray level 1 color.
     
     ## Example:
     ```swift
     let background = Color.systemGray
     ```
     - Remark: Used to support multiplatform development in SwiftUI on macOS.
    */
    public static var systemGray:Color {
        
        switch colorScheme {
        case .dark:
            return Color(fromHex: "8E8E93FF")!
        default:
            return Color(fromHex: "8E8E93FF")!
        }
    }
    
    /**
     Returns the system gray level 2 color.
     
     ## Example:
     ```swift
     let background = Color.systemGray2
     ```
     - Remark: Used to support multiplatform development in SwiftUI on macOS.
    */
    public static var systemGray2:Color {
        
        switch colorScheme {
        case .dark:
            return Color(fromHex: "636366FF")!
        default:
            return Color(fromHex: "AEAEB2FF")!
        }
        
    }
    
    /**
     Returns the system gray level 3 color.
     
     ## Example:
     ```swift
     let background = Color.systemGray3
     ```
     - Remark: Used to support multiplatform development in SwiftUI on macOS.
    */
    public static var systemGray3:Color {
        
        switch colorScheme {
        case .dark:
            return Color(fromHex: "48484AFF")!
        default:
            return Color(fromHex: "C7C7CCFF")!
        }
    }
    
    /**
     Returns the system gray level 4 color.
     
     ## Example:
     ```swift
     let background = Color.systemGray4
     ```
     - Remark: Used to support multiplatform development in SwiftUI on macOS.
    */
    public static var systemGray4:Color {
        
        switch colorScheme {
        case .dark:
            return Color(fromHex: "3A3A3CFF")!
        default:
            return Color(fromHex: "D1D1D6FF")!
        }
    }
    
    /**
     Returns the system gray level 5 color.
     
     ## Example:
     ```swift
     let background = Color.systemGray5
     ```
     - Remark: Used to support multiplatform development in SwiftUI on macOS.
    */
    public static var systemGray5:Color {
        
        switch colorScheme {
        case .dark:
            return Color(fromHex: "2C2C2EFF")!
        default:
            return Color(fromHex: "E5E5EAFF")!
        }
    }
    
    /**
     Returns the system gray level 6 color.
     
     ## Example:
     ```swift
     let background = Color.systemGray6
     ```
     - Remark: Used to support multiplatform development in SwiftUI on macOS.
    */
    public static var systemGray6:Color {
        
        switch colorScheme {
        case .dark:
            return Color(fromHex: "1C1C1EFF")!
        default:
            return Color(fromHex: "F2F2F7FF")!
        }
    }
    
    /**
     Returns the red, green, blue and alpha components of the given color where:
     
     * `red` - Is a number between 0.0 and 1.0.
     * `green` - Is a number between 0.0 and 1.0.
     * `blue` - Is a number between 0.0 and 1.0.
     * `alpha` - Is a percentage between 0 and 1.0.
     
     ## Example:
     ```swift
     let components = Color.red.baseComponents
     print(components.red)
     ```
    */
    public var baseComponents: (red: Float, green: Float, blue: Float, alpha: Float) {
        var (red, green, blue, alpha) = (Float(0.0), Float(0.0), Float(0.0), Float(0.0))
        
        guard let components = cgColor?.components, components.count >= 3 else {
            // Default to black
            return (red, green, blue, alpha)
        }
        
        red = Float(components[0])
        green = Float(components[1])
        blue = Float(components[2])
        alpha = Float(1.0)
        
        if components.count >= 4 {
            alpha = Float(components[3])
        }
        
        return (red, green, blue, alpha)
    }
    
    /**
     Returns the red, green, blue and alpha components of the given color where:
     
     * `red` - Is a number between 0 and 255.
     * `green` - Is a number between 0 and 255.
     * `blue` - Is a number between 0 and 255.
     * `alpha` - Is a percentage between 0 and 100.
     
     ## Example:
     ```swift
     let components = Color.red.rgbComponents
     print(components.red)
     ```
    */
    public var rgbComponents: (red: Int, green: Int, blue: Int, alpha: Int) {
        get {
            let (red, green, blue, alpha) = self.baseComponents
            
            let r = round(red * Float(255.0))
            let g = round(green * Float(255.0))
            let b = round(blue * Float(255.0))
            let a = round(alpha * Float(100.0))
            
            return (red: Int(r), green: Int(g), blue: Int(b), alpha: Int(a))
        }
    }
    
    /**
     Returns the alpha value of the color as a percentage between 0 and 100.
     
     ## Example:
     ```swift
     let alpha = Color.red.alphaValue
     ```
    */
    public var alphaValue: Int {
        get {return rgbComponents.alpha}
    }
    
    /**
     Returns the red value of the color as a number between 0 and 255.
     
     ## Example:
     ```swift
     let red = Color.red.redValue
     ```
    */
    public var redValue: Int {
        get {return rgbComponents.red}
    }
    
    /**
     Returns the green value of the color as a number between 0 and 255.
     
     ## Example:
     ```swift
     let green = Color.red.greenValue
     ```
    */
    public var greenValue: Int {
        get {return rgbComponents.green}
    }
    
    /**
     Returns the blue value of the color as a number between 0 and 255.
     
     ## Example:
     ```swift
     let blue = Color.red.blueValue
     ```
     */
    public var blueValue: Int {
        get {return rgbComponents.blue}
    }
    
    /**
     Returns the hue, saturation, brightness (value) and alpha component of the given color where:
     
     * `hue` - Is a number between 0 and 360.
     * `saturation` - Is a percentage between 0 and 100.
     * `brightness` - Is a percentage between 0 and 100.
     * `alpha` - Is a percentage between 0 and 100.
     
     ## Example:
     ```swift
     let components = Color.red.hsbComponents
     print(components.hue)
     ```
    */
    public var hsbComponents: (hue: Int, saturation: Int, brightness: Int, alpha: Int) {
        get {
            let (red, green, blue, alpha) = self.baseComponents
            
            let cmin = min(red, green, blue)
            let cmax = max(red, green, blue)
            let delta = cmax - cmin
            
            var h = Float(0.0)
            var s = Float(0.0)
            var l = Float(0.0)
            
            // Calculate color
            if delta == Float(0.0) {
                h = Float(0.0)
            } else if (cmax == red) {
                h = ((green - blue) / delta).truncatingRemainder(dividingBy: Float(6.0))
            } else if (cmax == green) {
                h = (blue - red) / delta + Float(2.0)
            } else {
                h = (red - green) / delta + Float(4.0)
            }
            
            // Make negative hues positive behind 360°
            if h < 0 {
                h += Float(360.0)
            }
            
            // Calculate lightness
            l = (cmax + cmin) / Float(2.0)
            
            // Calculate saturation
            s = (delta == Float(0.0)) ? Float(0.0) : delta / (Float(1.0) - abs(Float(2.0) * l - Float(1.0)))
            
            // Multiply l and s by 100
            s = +(s * Float(100.0))
            l = +(l * Float(100.0))
            
            // Cleanup
            h = round(h)
            s = round(s)
            l = round(l)
            let a = round(alpha * Float(100.0))
            
            return (hue: Int(h), saturation: Int(s), brightness: Int(l), alpha: Int(a))
        }
    }
    
    /**
     Returns the hue value of the color as a number between 0 and 360.
     
     ## Example:
     ```swift
     let hue = Color.red.hueValue
     ```
     */
    public var hueValue: Int {
        get { return hsbComponents.hue}
    }
    
    /**
     Returns the saturation value of the color as a percentage between 0 and 100.
     
     ## Example:
     ```swift
     let saturation = Color.red.saturationValue
     ```
    */
    public var saturationValue: Int {
        get {return hsbComponents.saturation}
    }
    
    /**
     Returns the brightness value of the color as a percentage between 0 and 100.
     
     ## Example:
     ```swift
     let brightness = Color.red.brightnessValue
     ```
    */
    public var brightnessValue: Int {
        get {return hsbComponents.brightness}
    }
    
    /**
     Returns the shade and alpha of a given gray scale color where:
     
     * `shade` - Is a number between 0 and 255.
     * `alpha` - Is a percentage between 0 and 100.
     
     ## Example:
     ```swift
     let components = Color.gray.grayScaleComponents
     print(components.shade)
     ```
     
     - remarks: This property assumes that the color is actually a shade of gray. Internally the `red` component is returned as the `shade` value.
    */
    public var grayScaleComponents: (shade: Int, alpha: Int) {
        get {
            let (red, _, _, alpha) = self.baseComponents
            
            let r = round(red * Float(255.0))
            let a = round(alpha * Float(100.0))
            
            return (shade: Int(r), alpha: Int(a))
        }
    }
    
    /**
     Returns the gray scale shade of the color as a number between 0 and 255.
     
     ## Example:
     ```swift
     let shade = Color.gray.shadeValue
     ```
    */
    public var shadeValue: Int {
        get { return grayScaleComponents.shade}
    }
    
    /// Returns `true` if the color is bright, else returns `false`.
    public var isBrightColor: Bool {
        let (red, green, blue, _) = self.baseComponents
        
        let r = CGFloat(red)
        let g = CGFloat(green)
        let b = CGFloat(blue)
        var brightness: CGFloat = 0.0
        
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000;
        if (brightness < 0.5) {
            return false
        }
        else {
            return true
        }
    }
    
    // MARK: - Public Functions
    /**
     Converts a `Color` to a hex string in the format `rrggbb` or `rrggbbaa` where:
     
     * `rr` - Specifies the red component as a hex value in the range 00 to FF.
     * `gg` - Specifies the green component as a hex value in the range 00 to FF.
     * `bb` - Specifies the blue component as a hex value in the range 00 to FF.
     * `aa` - Specifies the alpha component as a hex value in the range 00 to FF.
     
     The hex string can optionally start with the prefix of `#`.
     
     ## Examples:
     ```swift
     // Assign a color from a string in iOS, tvOS or watchOS
     let colorHex = Color.red.toHex();
     let colorHexShort = Color.red.toHex(withPrefix: false, includeAlpha: false);
     ```
     
     - Parameters:
         - hash: If `true`, the string will be prefixed with the `#` character.
         - alpha: If `true`, the string will include the alpha information.
     - Returns: The `UIColor` represented as a hex string.
     */
    public func toHex(withPrefix hash: Bool = true, includeAlpha alpha: Bool = true) -> String {
        let prefix = hash ? "#" : ""
        
        guard let components = cgColor?.components, components.count >= 3 else {
            // Default to white
            return prefix + "FFFFFF"
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return prefix + String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255.0), lroundf(g * 255.0), lroundf(b * 255.0), lroundf(a * 255.0))
        } else {
            return prefix + String(format: "%02lX%02lX%02lX", lroundf(r * 255.0), lroundf(g * 255.0), lroundf(b * 255.0))
        }
    }
    
    /**
     Returns a color based off of this color with the given alpha value.
     
     ## Example:
     ```swift
     let color = Color.white.withAlphaValue(50)
     ```
     
     - Parameter alpha: A percentage between 0 and 100.
    */
    public func withAlphaValue(_ alpha: Int) -> Color {
        var components = rgbComponents
        components.alpha = alpha
        return Color(fromRGBA: components)
    }
    
    /**
     Returns a color based off of this color with the given red value.
     
     ## Example:
     ```swift
     let color = Color.white.withRedValue(255)
     ```
     
     - Parameter red: A number between 0 and 255.
     */
    public func withRedValue(_ red: Int) -> Color {
        var components = rgbComponents
        components.red = red
        return Color(fromRGBA: components)
    }
    
    /**
     Returns a color based off of this color with the given green value.
     
     ## Example:
     ```swift
     let color = Color.white.withGreenValue(255)
     ```
     
     - Parameter green: A number between 0 and 255.
     */
    public func withGreenValue(_ green: Int) -> Color {
        var components = rgbComponents
        components.green = green
        return Color(fromRGBA: components)
    }
    
    /**
     Returns a color based off of this color with the given blue value.
     
     ## Example:
     ```swift
     let color = Color.white.withBlueValue(255)
     ```
     
     - Parameter blue: A number between 0 and 255.
     */
    public func withBlueValue(_ blue: Int) -> Color {
        var components = rgbComponents
        components.blue = blue
        return Color(fromRGBA: components)
    }
    
    /**
     Returns a color based off of this color with the given hue value.
     
     ## Example:
     ```swift
     let color = Color.white.withHueValue(100)
     ```
     
     - Parameter hue: A number between 0 and 360.
    */
    public func withHueValue(_ hue: Int) -> Color {
        var components = hsbComponents
        components.hue = hue
        return Color(fromHSBA: components)
    }
    
    /**
     Returns a color based off of this color with the given saturation value.
     
     ## Example:
     ```swift
     let color = Color.white.withSaturationValue(100)
     ```
     
     - Parameter saturation: A percentage between 0 and 100.
     */
    public func withSaturationValue(_ saturation: Int) -> Color {
        var components = hsbComponents
        components.saturation = saturation
        return Color(fromHSBA: components)
    }
    
    /**
     Returns a color based off of this color with the given brightness value.
     
     ## Example:
     ```swift
     let color = Color.white.withBrightnessValue(100)
     ```
     
     - Parameter brightness: A percentage between 0 and 100.
     */
    public func withBrightnessValue(_ brightness: Int) -> Color {
        var components = hsbComponents
        components.brightness = brightness
        return Color(fromHSBA: components)
    }
    
    /**
     Given a background color, return a color that will be high contrast against it.
     
     - Parameters:
         - lightColor: The light contrast color. The default is white.
         - darkColor: The dark contrast color. The default is black.
     - Returns: A color that will be high contrast against the given background.
    */
    public func contrastingColor(lightColor:Color = Color.white, darkColor:Color = Color.black) -> Color {
        let (red, green, blue, _) = self.baseComponents
        
        let r = CGFloat(red)
        let g = CGFloat(green)
        let b = CGFloat(blue)
        var brightness: CGFloat = 0.0
        
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000;
        if (brightness < 0.5) {
            return lightColor
        }
        else {
            return darkColor
        }
    }
}
