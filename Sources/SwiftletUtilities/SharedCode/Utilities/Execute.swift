//
//  Execute.swift
//  ReedWriteCycle (iOS)
//
//  Created by Kevin Mullins on 7/7/22.
//

import Foundation
import SwiftUI

/// A convenience class to execute a block of code on the main thread or on the main thread after a given number of seconds delay.
/// This class was designed to take the hard to remember `DispatchQueue.main.async {...}` and `DispatchQueue.main.asyncAfter(deadline: n) {...}` commands and wrap them in easy to remember and read "syntatic sugar".
open class Execute {
    /// Defines the type of function that will be called on the main UI thread.
    public typealias Perform = () -> Void
    
    /// Runs the given block of code on the main UI thread.
    /// - Parameter perform: The action to perform on the main thread.
    static public func onMain(perform: @escaping Perform) {
        DispatchQueue.main.async {
            perform()
        }
    }
    
    /// Executes the given block of code on the n=main UI thread after waiting for the given number of seconds.
    /// - Parameters:
    ///   - seconds: The number of seconds to wait before executing the code.
    ///   - perform: The given code to execute on the main thread
    static public func afterDelay(seconds:Double, perform:@escaping Perform) {
        // Wait the given amount of seconds and execute the function.
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            perform()
        }
    }
}
