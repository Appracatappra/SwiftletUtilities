//
//  ViewDeviceRotation.swift
//  ReedWriteCycle
//
//  Created by Kevin Mullins on 12/13/22.
//  From: https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation

import Foundation
import SwiftUI

#if os(tvOS)
/// Recreates the `UIDeviceOrientation` enum for tvOS so I can ealisy maintain compatibility between the iOS/iPadOS version and the tvOS version of the SwiftUI code.
public enum UIDeviceOrientation : Int, @unchecked Sendable {
    
    case unknown = 0
    case portrait = 1 // Device oriented vertically, home button on the bottom
    case portraitUpsideDown = 2 // Device oriented vertically, home button on the top
    case landscapeLeft = 3 // Device oriented horizontally, home button on the right
    case landscapeRight = 4 // Device oriented horizontally, home button on the left
    case faceUp = 5 // Device oriented flat, face up
    case faceDown = 6 // Device oriented flat, face down
}

/// Extends `View` so I can ealisy maintain compatibility between the iOS/iPadOS version and the tvOS version of the SwiftUI code.
public extension View {
    /// Creates a fake rotation handler so I can ealisy maintain compatibility between the iOS/iPadOS version and the tvOS version of the SwiftUI code.
    /// - Parameter action: The action to take when the rotation changes.
    /// - Returns: Returns self.
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        
        // tvOS is always in the landscape orientation
        action(UIDeviceOrientation.landscapeLeft)
        
        // Return self
        return self
    }
}
#elseif !os(macOS)
// Our custom view modifier to track rotation and
// call our action
public struct DeviceRotationViewModifier: ViewModifier {
    public let action: (UIDeviceOrientation) -> Void
    
    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
public extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
#endif

