//
//  NetworkConnection.swift
//  ReedWriteCycle
//
//  Created by Kevin Mullins on 12/3/22.
//

#if !os(watchOS)
import Foundation
import SystemConfiguration
import Network

/// A utility to check if the device the app is running on has network connectivity.
open class NetworkConnection {
    /// Handler for the network connection statu changing.
    public typealias NetworkStatusChanged = (Bool) -> Void
    
    // MARK: - Public Static Properties
    public let shared:NetworkConnection = NetworkConnection()
    
    // MARK: - Properties
    /// Provides an instance of the Network path monitor.
    private let monitor = NWPathMonitor()
    
    // MARK: - Properties
    /// Handles the network status changing.
    public var statusChanged:NetworkStatusChanged? = nil
    
    /// If `true`, the device needs to be connected to a network.
    public var requiresConnection: Bool = false
    
    /// If `true` the device is connected to the network.
    public var isConnectedToNetwork: Bool = false
    
    /// If `true` the device is using a cellular network.
    public var isCellularConnection: Bool = false
    
    /// If `true` the device is using a WiFi network.
    public var isWifiConnection: Bool = false
    
    /// If `true` the device is using a Ethernet network.
    public var isEthernetConnection: Bool = false
    
    /// If `true` the device is using an unknown network type.
    public var isOtherConnection: Bool = false
    
    /// If `true` the device is using a Loop Back network.
    public var isLoopBackConnection: Bool = false
    
    /// If `true`, this is an expensive network connection.
    public var isExpensiveConnection: Bool = false
    
    /// If `true` this is a constrained network.
    public var isConstrainedConnection: Bool = false
    
    /// If `true` the connection supports IP version 4.
    public var supportsIPv4: Bool = false
    
    /// If `true` the connection support IP version 6.
    public var supportsIPv6: Bool = false
    
    /// If `true` the network supports DNS lookup.
    public var supportsDNS: Bool = false
    
    // MARK: - Initializers
    /// Creates a new instance.
    public init() {
        
        // Handle the network connection changing.
        self.monitor.pathUpdateHandler = { path in
            
            // Reset connection states
            self.resetStatus()
            
            // Take action based on the path's status.
            switch path.status {
            case .requiresConnection:
                // The path is not currently available, but establishing a new connection may activate the path.
                self.requiresConnection = true
                self.isConnectedToNetwork = false
            case .satisfied:
                // The path is available to establish connections and send data.
                self.requiresConnection = false
                self.isConnectedToNetwork = true
            case .unsatisfied:
                // The path is not available for use.
                self.requiresConnection = false
                self.isConnectedToNetwork = false
            @unknown default:
                // Default to not connected on unknown state.
                self.requiresConnection = false
                self.isConnectedToNetwork = false
            }
            
            // Test for the interface type.
            if path.usesInterfaceType(.cellular) {
                self.isCellularConnection = true
            } else if path.usesInterfaceType(.wifi) {
                self.isWifiConnection = true
            } else if path.usesInterfaceType(.wiredEthernet) {
                self.isEthernetConnection = true
            } else if path.usesInterfaceType(.other){
                self.isOtherConnection = true
            } else if path.usesInterfaceType(.loopback){
                self.isLoopBackConnection = true
            }
            
            // Set other statuses
            self.isExpensiveConnection = path.isExpensive
            self.isConstrainedConnection = path.isConstrained
            self.supportsIPv4 = path.supportsIPv4
            self.supportsIPv6 = path.supportsIPv6
            self.supportsDNS = path.supportsDNS
            
            // Is there a callback handler?
            if let statusChanged = self.statusChanged {
                // Yes, inform caller of status change.
                statusChanged(self.isConnectedToNetwork)
            }
        }
        
        // Start monitoring connection on a background thread.
        self.monitor.start(queue: DispatchQueue.global(qos: .background))
    }
    
    // MARK: - Functions
    /// Reset all of the connection statuses to `false`.
    private func resetStatus() {
        requiresConnection = false
        isConnectedToNetwork = false
        isCellularConnection = false
        isWifiConnection = false
        isEthernetConnection = false
        isOtherConnection = false
        isLoopBackConnection = false
        isExpensiveConnection = false
        isConstrainedConnection = false
        supportsIPv4 = false
        supportsIPv6 = false
        supportsDNS = false
    }
    
    /// Tests to see if the device is connected to the network.
    /// - Returns: Returns `true` if connected, else returns `false`.
    @available(*, deprecated, message: "isConnectedToNetwork function has been deprecated and will be removed in future builds. Use `NetworkConnection.shared.isConnectedToNetwork` instead.")
    class public func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
#endif
