//
//  File.swift
//  
//
//  Created by Kevin Mullins on 12/21/23.
//

import Foundation

#if os(macOS)
/// A duplicate to the `UIKit` `UIDeviceOrientation` to support cross-platform development in macOS for universal apps.
public enum UIDeviceOrientation {
    /// The orientation is unknown
    case unknown
    
    /// Portrait orientation.
    case portrait
    
    /// Portrait upside down orientation.
    case portraitUpsideDown
    
    /// Ladscape Left orientation.
    case landscapeLeft
    
    /// Ladscape Right orientation.
    case landscapeRight
}
#endif
