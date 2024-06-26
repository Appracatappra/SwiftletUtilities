//
//  ViewExtensions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 4/16/21.
//

import Foundation
import SwiftUI

// MARK: - Enumerations
/**
 Defines a list of available OS types that can be used with the SwitfUI extension `.ifOS`function.
 */
@available(*, deprecated, message: "This extension will be removed in a future build.")
public enum OperatingSystem {
    /// The app is running on a Mac.
    case macOS
    
    /// The app is running on an iOS device.
    case iOS
    
    /// The app is running on an AppleTV.
    case tvOS
    
    /// The app is running on an AppleWatch
    case watchOS

    // MARK: - Static Constants
    #if os(macOS)
    static nonisolated(unsafe) let current = macOS
    #elseif os(iOS)
    static nonisolated(unsafe) let current = iOS
    #elseif os(tvOS)
    static nonisolated(unsafe) let current = tvOS
    #elseif os(watchOS)
    static nonisolated(unsafe) let current = watchOS
    #else
    #error("Unsupported platform")
    #endif
}

/**
 Conditionally apply modifiers depending on the target operating system.
 
 ## Example:
 ```swift
 struct ContentView: View {
     var body: some View {
         Text("Unicorn")
             .font(.system(size: 10))
             .ifOS(.macOS, .tvOS) {
                 $0.font(.system(size: 20))
             }
     }
 }
 ```
*/
@available(*, deprecated, message: "This extension will be removed in a future build.")
extension View {
    
    /**
    Conditionally apply modifiers depending on the target operating system.

     ## Example:
    ```swift
    struct ContentView: View {
        var body: some View {
            Text("Unicorn")
                .font(.system(size: 10))
                .ifOS(.macOS, .tvOS) {
                    $0.font(.system(size: 20))
                }
        }
    }
    ```
     - Parameter operatingSystems: A list of operating systems where the given modifier should be applied.
     - Parameter modifier: The modifier to conditionally by applied to the view.
    */
    @available(*, deprecated, message: "This function will be removed in a future build.")
    @ViewBuilder
    public func ifOS<Content: View>(
        _ operatingSystems: OperatingSystem...,
        modifier: (Self) -> Content
    ) -> some View {
        if operatingSystems.contains(OperatingSystem.current) {
            modifier(self)
        } else {
            self
        }
    }
}
