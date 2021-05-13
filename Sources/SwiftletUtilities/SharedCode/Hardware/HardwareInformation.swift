//
//  HardwareInformation.swift
//  ActionUtilities
//
//  Created by Kevin Mullins on 1/16/18.
//  Copyright © 2018 Appracatappra, LLC. All rights reserved.
//

import Foundation

#if os(watchOS)
import WatchKit
#else
import SystemConfiguration
#endif

#if os(iOS)
import UIKit
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
}
