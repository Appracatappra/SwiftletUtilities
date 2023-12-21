//
//  HardwareInformation.swift
//  ActionUtilities
//
//  Created by Kevin Mullins on 1/16/18.
//  Copyright © 2018 Appracatappra, LLC. All rights reserved.
//

import Foundation
import LogManager

#if os(watchOS)
import WatchKit
#else
import SystemConfiguration
#endif

#if os(iOS)
import UIKit
#endif

#if os(macOS)
import AppKit
#endif

#if os(tvOS)
import UIKit
#endif


/**
 Defines a set of convenience properties and functions when working on Apple devices, such as checking the device model name (`iPhone10,3`), getting the device type (`iPhoneX`), getting the OS version, the current device orientation and internet connection state.
 
 ## Examples:
 
 ```swift
 if HardwareInformation.deviceType == .iPhoneX {
 // The app is running on an iPhone X
 ...
 }
 
 if HardwareInformation.isConnectedToNetwork {
 // The device has an internet connection
 ...
 }
 ```
 */
open class HardwareInformation {
    
    /// Returns `true` if the app is running on an iPhone, else returns `false`.
    public static var isPhone: Bool {
        #if os(watchOS) || os(macOS)
            return false
        #else
            return UIDevice.current.userInterfaceIdiom == .phone
        #endif
    }
    
    /// Returns `true` if the app is running on an iPad, else returns `false`.
    public static var isPad: Bool {
        #if os(watchOS) || os(macOS)
            return false
        #else
            return UIDevice.current.userInterfaceIdiom == .pad
        #endif
    }
    
    /// Returns `true` if the app is runnin on an Apple TV, else returns `false`.
    public static var isTV: Bool {
        #if os(watchOS) || os(macOS)
            return false
        #else
            return UIDevice.current.userInterfaceIdiom == .tv
        #endif
    }
    
    /// Returns `true` if the app is running in Apple CarPlay, else returns `false`.
    public static var isCar: Bool {
        #if os(watchOS) || os(macOS)
            return false
        #else
            return UIDevice.current.userInterfaceIdiom == .carPlay
        #endif
    }
    
    /// Returns `true` if the app is running on an Apple Watch, else returns `false`.
    public static var isWatch: Bool {
        #if os(watchOS)
        return true
        #else
        return false
        #endif
    }
    
    /// Returns `true` if the app is running on an Mac, else returns `false`.
    public static var isMac: Bool {
        #if os(macOS)
            return true
        #else
            return false
        #endif
    }
    
    /// Returns `true` if the app is running on an Mac via the Catalyst envrionment, else returns `false`.
    public static var isMacCatalyst: Bool {
        #if targetEnvironment(macCatalyst)
          return true
        #else
          return false
        #endif
    }
    
    /// CTests to see if this is an iOS/iPadOS app running on an Apple Silicone Mac.
    /// - Returns: Returns `true` if running on an Apple Silicone Mac else returns `false`.
    public static func isiOSAppOnMac() -> Bool {
        if #available(iOS 14.0, *) {
            return ProcessInfo.processInfo.isiOSAppOnMac
        }
        
        return false
    }
    
    /// Returns the model name of the device the app is running on. For example, `iPhone10,3` or `iPhone10,6` for the `iPhone X`.
    public static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        if let value = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return value
        } else {
            return identifier
        }
    }
    
    /// Returns the human readable type of the device that the app is running on (for example `iPhoneX`) or `unknown` if the type cannot be discovered.
    @available(*, deprecated, message: "This property is out of date and will be removed in a future build.")
    public static var deviceType: AppleHardwareType {
        return AppleHardwareType(fromModel: modelName)
    }
    
    /// Returns the version number (for example `iOS 11.1`) of the OS installed on the device that the app is running on.
    public static var osVersion: String {
        #if os(watchOS)
            return "\(WKInterfaceDevice.current().systemName) \(WKInterfaceDevice.current().systemVersion)"
        #elseif os(macOS)
            return ProcessInfo.processInfo.operatingSystemVersionString
        #else
            return "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
        #endif
    }
    
    #if os(tvOS)
    /// Creates a fake orientation so I can ealisy maintain compatibility between the iOS/iPadOS version and the tvOS version of the SwiftUI code.
    public static var deviceOrientation: UIDeviceOrientation {
        return .landscapeLeft
    }
    #elseif os(iOS)
    /// This property returns the interface orientation of the apps main, active window.
    public static var windowOrientation: UIInterfaceOrientation {
        
        // Ensure that we are running on the main thread.
        guard Thread.isMainThread else {
            return .unknown
        }
        
        // Ensure that a scene has been connected.
        guard UIApplication.shared.connectedScenes.count > 0 else {
            return .unknown
        }
        
        // Ensure we can get a scene and that it is the foreground scene.
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, windowScene.activationState == .foregroundActive else {
            return .unknown
        }
        
        // Return the scene's orientation.
        return windowScene.interfaceOrientation
    }

    /// Returns the current orientation of the device.
    public static var deviceOrientation: UIDeviceOrientation {
        switch windowOrientation {
        case .unknown:
            // If the orientation is unknown, use the screen height and width to guess at the rotation.
            if screenWidth > screenHeight {
                return .landscapeLeft
            } else {
                return .portrait
            }
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        @unknown default:
            return .unknown
        }
    }
    #endif
    
    #if os(macOS)
    /// Simumates the device orientation on macOS to support cross-platform developement in a universal app.
    /// - Returns: Always returns the `.landscapeRight` for macOS.
    public static var deviceOrientation: UIDeviceOrientation {
        return .landscapeRight
    }
    
    /// This property returns a `String` containing the form `1024x786` that can be used to add customized "hints" to a SwiftUI view based on the screen vsize of the device being run on.
    ///  - Remark: I typically use this property with a `switch` statement to do things like adjust the font size, etc.
    public static var deviceDimentions:String {
        let screenSize:CGSize = NSScreen.main?.visibleFrame.size ?? CGSize(width: 1024, height: 800)
        
        let screenWidth = Int(screenSize.width)
        let screenHeight = Int(screenSize.height)
        
        return "\(screenWidth)x\(screenHeight)"
    }
    
    /// Returns the full width of the main screen of the device the app is running on.
    public static var screenWidth:Int {
        let screenSize:CGSize = NSScreen.main?.visibleFrame.size ?? CGSize(width: 1024, height: 800)
        return Int(screenSize.width)
    }
    
    /// Returns the height of the main screen of the device that the app is running on.
    public static var screenHeight:Int {
        let screenSize:CGSize = NSScreen.main?.visibleFrame.size ?? CGSize(width: 1024, height: 800)
        return Int(screenSize.height)
    }
    
    /// Returns the screen size for the main device screen that the app is running on.
    public static let screenSize = NSScreen.main?.visibleFrame.size ?? CGSize(width: 1024, height: 800)
    #endif
    
    #if os(iOS)
    /// This property returns a `String` containing the form `1024x786` that can be used to add customized "hints" to a SwiftUI view based on the screen vsize of the device being run on.
    ///  - Remark: I typically use this property with a `switch` statement to do things like adjust the font size, etc.
    public static var deviceDimentions:String {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = Int(screenSize.width)
        let screenHeight = Int(screenSize.height)
        
        return "\(screenWidth)x\(screenHeight)"
    }
    
    /// Returns the full width of the main screen of the device the app is running on.
    public static var screenWidth:Int {
        let screenSize: CGRect = UIScreen.main.bounds
        return Int(screenSize.width)
    }
    
    /// Returns the height of the main screen of the device that the app is running on.
    public static var screenHeight:Int {
        let screenSize: CGRect = UIScreen.main.bounds
        return Int(screenSize.height)
    }
    
    /// Returns the screen size for the main device screen that the app is running on.
    public static let screenSize = UIScreen.main.bounds.size
    
    /// Lists out all font family names and the name of every font variation in the family for use inside of a Font call in an app.
    /// - Remark: Based on https://codewithchris.com/common-mistakes-with-adding-custom-fonts-to-your-ios-app/
    public static func ListInstalledFonts(contains:String = "") {
        
        // Title
        Debug.log("-- INSTALLED FONTS --")
        
        // Cycle through all font families and variations
        for family: String in UIFont.familyNames
        {
            if contains == "" {
                Debug.log("\(family)")
            } else if family.lowercased().contains(contains) {
                Debug.log("\(family)")
            }
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                if contains == "" {
                    Debug.log("== \(names)")
                } else if names.lowercased().contains(contains) {
                    Debug.log("== \(names)")
                }
            }
        }
    }
    #endif
}
