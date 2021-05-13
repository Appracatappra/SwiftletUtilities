//
//  Reachability.swift
//  ActionUtilities
//
//  Created by Kevin Mullins on 3/22/19.
//  From: https://stackoverflow.com/questions/30743408/check-for-internet-connection-with-swift

import Foundation
import SwiftUI
import Network

/**
 Class used to monitor network connection and return the status.
 
 There are two main properties that the user should be interested in:
 
 1) `isReachable` - If `true`, the device can reach the network.
 2) `isExpensiveConnection` - If `true`, the device is connected to a network that can be expensive for the user to use (such as cellular data). Therefore, the app should be careful with its data usage.
 
 ## Example:
 ```swift
 // Can connect to network?
 if Reachability.shared.isReachable {
    ...
 }
 ```
 
 - Remark: The static `isConnectedToNetwork` property has been deprecated and is provided as backward compatibility with older versions of the library. Please use `Reachability.shared.isReachable` going forward.
 */
public class Reachability: ObservableObject {
    
    // MARK: - Static Properties
    /// Holds a common shared instance of the Reachability class.
    public static var shared = Reachability()
    
    /**
     Returns `true` if the device is connected to the network, else returns `false`.
     - Remark: This property has been deprecated and is provided as backward compatibility with older versions of the library. Please use `Reachability.shared.isReachable` going forward.
     */
    @available(*, deprecated)
    public static var isConnectedToNetwork:Bool {
        return shared.isReachable
    }
    
    // MARK: - Properties
    /// If `true` the internet is reachable, else it is not.
    @Published public private(set) var isReachable:Bool = false
    
    /// If `true` the current network connection is expensive to use, else it is not.
    @Published public private(set) var isExpensiveConnection:Bool = false
    
    /// If `true` the current network connection uses an interface in Low Data Mode.
    @Published public private(set) var isConstrained:Bool = false
    
    /// If `true` the current network connection supports IP version 4.
    @Published public private(set) var supportsIPv4:Bool = false
    
    /// If `true` the current network connection supports IP version 6.
    @Published public private(set) var supportsIPv6:Bool = false
    
    /// If `true` the current network connection supports DNS lookup.
    @Published public private(set) var supportsDNS:Bool = false
    
    /// Returns a debugging description of the network path.
    @Published public private(set) var debugDescription:String = ""
    
    /// Holds an instance of the Path Monitor used to monitor network connection.
    private let monitor = NWPathMonitor()
    
    /// Holds the Dispatch Queue used to monitor network changes.
    private let queue:DispatchQueue = DispatchQueue(label: "Monitor")
    
    // MARK: - Initializers
    public init() {
        // Track changes to network status
        self.monitor.pathUpdateHandler = { path in
            // Take action based on the network status
            switch path.status {
            case .satisfied:
                self.isReachable = true
            default:
                self.isReachable = false
            }
            
            // Expose connection properties
            self.isExpensiveConnection = path.isExpensive
            self.isConstrained = path.isConstrained
            self.supportsIPv4 = path.supportsIPv4
            self.supportsIPv6 = path.supportsIPv6
            self.supportsDNS = path.supportsDNS
            self.debugDescription = path.debugDescription
        }
        
        // Start the monitor.
        self.monitor.start(queue: self.queue)
    }
}
