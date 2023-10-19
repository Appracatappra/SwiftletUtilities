//
//  UIApplicationExtension.swift
//  ReedWriteCycle
//
//  Created by Kevin Mullins on 2/23/23.
//  From: https://www.avanderlee.com/swift/skstorereviewcontroller-app-ratings/
//

#if !os(macOS)
import Foundation
import UIKit

public extension UIApplication {
    var foregroundActiveScene: UIWindowScene? {
        connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}
#endif
