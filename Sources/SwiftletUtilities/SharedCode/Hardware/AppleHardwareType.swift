//
//  AppleHardwareType.swift
//  ActionUtilities
//
//  Created by Kevin Mullins on 1/16/18.
//  Copyright © 2018 Appracatappra, LLC. All rights reserved.
//

import Foundation

/**
 Used to convert an Apple device model name (in the form "iPhone10,3") to a human readable form (such as "iPhoneX"). This enum works with the `HardwareInformation` class to get the type of device the app is running on.
 
 ## Example:
 
 ```swift
 // Get human-readable name (iPhoneX)
 let device = AppleHardwareType(fromModel: "iPhone10,3")
 ```
 */
public enum AppleHardwareType {
    case unknown
    
    // MARK: - iPhones
    /// An original iPhone.
    case iPhone
    
    /// An iPhone 3G.
    case iPhone3G
    
    /// An iPhone 3GS.
    case iPhone3GS
    
    /// An iPhone 4.
    case iPhone4
    
    /// An iPhone 4S.
    case iPhone4S
    
    /// An iPhone 5.
    case iPhone5
    
    /// An iPhone 5C.
    case iPhone5C
    
    /// An iPhone 5S.
    case iPhone5S
    
    /// An iPhone 6.
    case iPhone6
    
    /// An iPhone 6 Plus.
    case iPhone6Plus
    
    /// An iPhone 6S.
    case iPhone6S
    
    /// An iPhone 6S Plus.
    case iPhone6SPlus
    
    /// An iPhone SE.
    case iPhoneSE
    
    /// An iPhone 7.
    case iPhone7
    
    /// An iPhone 7 Plus.
    case iPhone7Plus
    
    /// An iPhone 8.
    case iPhone8
    
    /// An iPhone 8 Plus.
    case iPhone8Plus
    
    /// An iPhone X
    case iPhoneX
    
    // MARK: - iPads
    /// An original iPad.
    case iPad
    
    /// An iPad 2.
    case iPad2
    
    /// An iPad Mini
    case iPadMini
    
    /// An iPad 3.
    case iPad3
    
    /// An iPad 4.
    case iPad4
    
    /// An iPad Air.
    case iPadAir
    
    /// An iPad Mini 2.
    case iPadMini2
    
    /// An iPad Mini 3.
    case iPadMini3
    
    /// An iPad Mini 4.
    case iPadMini4
    
    /// An iPad Air 4
    case iPadAir2
    
    /// An iPad Pro 12".
    case iPadPro12In
    
    /// An iPad Pro 9".
    case iPadPro9In
    
    /// An iPad 4th Generation.
    case iPad5thGen
    
    /// An iPad Pro 12: 2nd Generation.
    case iPadPro12In2ndGen
    
    /// An iPad Pro 10".
    case iPadPro10In
    
    // MARK: - iPod Touches
    /// An original iPodTouch.
    case iPodTouch
    
    /// An iPad Touch 2nd Generation.
    case iPodTouch2ndGen
    
    /// An iPad Touch 3rd Generation.
    case iPodTouch3rdGen
    
    /// An iPod Touch 4th Generation.
    case iPodTouch4thGen
    
    /// An iPod Touch 5th Generation.
    case iPodTouch5thGen
    
    /// An iPodTouch 6th Generation.
    case iPodTouch6thGen
    
    // MARK: - Apple TVs
    
    /// An Apple TV 2nd Generation.
    case appleTV2ndGen
    
    /// An Apple TV 3rd Generation.
    case appleTV3rdGen
    
    /// An Apple TV 4th Generation.
    case appleTV4thGen
    
    /// An Apple TV 4K.
    case appleTV4K
    
    // MARK: - AirPods
    /// An original AirPod.
    case airPods
    
    // Mark: - Apple Watches
    /// An original Apple Watch.
    case appleWatch
    
    /// An Apple Watch Series 1.
    case appleWatchSeries1
    
    /// An Apple Watch Series 2.
    case appleWatchSeries2
    
    /// An Apple Watch Series 3.
    case appleWatchSeries3
    
    // MARK: - HomePods
    /// An original HomePod.
    case homePod
    
    // MARK: - MacBooks
    // A 2017 MacBook 12" Retina Display.
    case macBookRetina12In2017
    
    /// A 2016 MacBook 12" Retina Display.
    case macBookRetina12In2016
    
    /// A 2015 MacBook 12" Retina Display.
    case macBookRetina12In2015
    
    /// A 2010 MacBook 13" Display.
    case macBook13In2010
    
    /// A Late 2009 MacBook 13" Display.
    case macBook13InLate2009
    
    /// An Early-Mid 2009 MacBook 13" Display.
    case macBook13In2009
    
    // MARK: - MacBook Air
    /// A 2015-2017 MacBook Air 13" Display.
    case macBookAir13In2015To2017
    
    /// A 2015 MacBook Air 11" Display.
    case macBookAir11In2015
    
    /// A 2013-2014 MacBook Air 13" Display.
    case macBookAir13In2013To2014
    
    /// A 2013-2014 MacBook Air 11" Display.
    case macBookAir11In2013To2014
    
    /// A 2012 MacBook Air 13" Display.
    case macBookAir13In2012
    
    /// A 2012 MacBook Air 11" DIsplay.
    case macBookAir11In2012
    
    /// A 2011 MacBook Air 13" Display.
    case macBookAir13In2011
    
    /// A 2011 MacBook Air 11" Display.
    case macBookAir11In2011
    
    /// A 2010 MacBook Air 13" Display.
    case macBookAir13In2010
    
    /// A 2010 MacBook Air 11" Display.
    case macBookAir11In2010
    
    /// A 2009 MacBook Air.
    case macBookAir2009
    
    // MARK: - MacBook Pros
    /// A 2017 MacBook Pro 15" Display.
    case macBookPro15In2017
    
    /// A 2017 MacBook Pro 13" Display.
    case macBookPro13In2017
    
    /// A 2016 MacBook Pro 15" Display.
    case macBookPro15In2016
    
    /// A 2016 MacBook Pro 13" Display.
    case macBookPro13In2016
    
    /// A 2015 MacBook Pro 15" Retina Display.
    case macBookProRetina15In2015
    
    /// A 2015 MacBook Pro 13" Retina Display.
    case macBookProRetina13In2015
    
    /// A 2013-2014 MacBook Pro 15" Retina Display.
    case macBookProRetina15In2013To2014
    
    /// A 2013-2014 MacBook Pro 13" Retina Display.
    case macBookProRetina13In2013To2014
    
    /// A 2012-2013 MacBook Pro 13" Retina Display.
    case macBookProRetina13In2012To2013
    
    /// A 2012 MacBook Pro 15" Retina Display.
    case macBookProRetina15In2012
    
    /// A 2012 MacBook Pro 15" Display.
    case macBookPro15In2012
    
    /// A 2012 MacBook Pro 13" Display.
    case macBookPro13In2012
    
    /// A 2011 MacBook Pro 17" Display.
    case macBookPro17In2011
    
    /// A 2011 MacBook Pro 15" Display.
    case macBookPro15In2011
    
    /// A 2011 MacBook Pro 13" Display.
    case macBookPro13In2011
    
    /// A 2010 MacBook Pro 17" Display.
    case macBookPro17In2010
    
    /// A 2010 MacBook Pro 13" Display.
    case macBookPro13In2010
    
    /// A 2009 MacBook Pro 17" Display.
    case macBookPro17In2009
    
    /// A 2009 MacBook Pro 15" Display.
    case macBookPro15In2009
    
    /// A 2009 MacBook Pro 13" Display.
    case macBookPro13In2009
    
    // MARK: - Mac Minis
    /// A 2006 Mac Mini.
    case macMini2006
    
    /// A 2007 Mac Mini.
    case macMini2007
    
    /// A 2009 Mac Mini.
    case macMini2009
    
    /// A 2010 Mac Mini.
    case macMini2010
    
    /// A 2011 Mac Mini.
    case macMini2011
    
    /// A 2012 Mac Mini.
    case macMini2012
    
    /// A 2014 Mac Mini.
    case macMini2014
    
    // MARK: - Mac Pros
    /// A 2013 Mac Pro.
    case macPro2013
    
    /// A 2010-2012 Mac Pro.
    case macPro2010To2012
    
    /// A 2009 Mac Pro.
    case macPro2009
    
    // MARK: iMacs
    /// A 2017 iMac 21" Display.
    case iMac21In2017
    
    /// A 2017 iMac 21" 4K Retina Display.
    case iMacRetina4K21In2017
    
    /// A 2017 iMac 27" 5K Retina Display.
    case iMacRetina5K27In2017
    
    /// A 2015 iMac 21" Display.
    case iMac21In2015
    
    /// A 2015 iMac 21" 4K Retina Display.
    case iMacRetina4K21In2015
    
    /// A 2015 iMac 27" 5K Retina Display.
    case iMacRetina5K27In2014To2015
    
    /// A 2014 iMac 21" Display.
    case iMac21In2014
    
    /// A 2013 iMac 21" Display.
    case iMac21In2013
    
    /// A 2013 iMac 27" Display.
    case iMac27In2013
    
    /// A 2012 iMac 21" Display.
    case iMac21In2012
    
    /// A 2012 iMac 27" Display.
    case iMac27In2012
    
    /// A 2011 iMac 21" Display.
    case iMac21In2011
    
    /// A 2011 iMac 27" Display.
    case iMac27In2011
    
    /// A 2009-2010 iMac 21" Display.
    case iMac21In2009To2010
    
    /// A 2009-2010 iMac 27" Display.
    case iMac27In2009To2010
    
    /// A 2009 iMac 20" or 24" Display.
    case iMac20InOr24In2009
    
    // MARK: - Initializers
    /**
     Takes a device model name in the form "iPhone10,3" and sets the enum to its human readable counterpart "iPhoneX".
     
     - Parameter model: The given device model string to convert.
     - Returns: The human readable name or `unknown` if unable to convert.
    */
    public init(fromModel model: String) {
        switch model {
        case "iMac9,1":
            self = .iMac20InOr24In2009
        case "iMac11,3":
            self = .iMac27In2009To2010
        case "iMac11,2":
            self = .iMac21In2009To2010
        case "iMac12,2":
            self = .iMac27In2011
        case "iMac12,1":
            self = .iMac21In2011
        case "iMac13,2":
            self = .iMac27In2012
        case "iMac13,1":
            self = .iMac21In2012
        case "iMac14,2":
            self = .iMac27In2013
        case "iMac14,1":
            self = .iMac21In2013
        case "iMac14,3":
            self = .iMac21In2014
        case "iMac15,1", "iMac17,1":
            self = .iMacRetina5K27In2014To2015
        case "iMac16,2":
            self = .iMacRetina4K21In2015
        case "iMac16,1":
            self = .iMac21In2015
        case "iMac18,3":
            self = .iMacRetina5K27In2017
        case "iMac18,2":
            self = .iMacRetina4K21In2017
        case "iMac18,1":
            self = .iMac21In2017
        case "MacPro4,1":
            self = .macPro2009
        case "MacPro5,1":
            self = .macPro2010To2012
        case "MacPro6,1":
            self = .macPro2013
        case "Macmini7,1":
            self = .macMini2014
        case "Macmini6,1", "Macmini6,2":
            self = .macMini2012
        case "Macmini5,1", "Macmini5,2", "Macmini5,3":
            self = .macMini2011
        case "Macmini4,1":
            self = .macMini2010
        case "Macmini3,1":
            self = .macMini2009
        case "Macmini2,1":
            self = .macMini2007
        case "Macmini1,1":
            self = .macMini2006
        case "MacBookPro5,5":
            self = .macBookPro13In2009
        case "MacBookPro5,3":
            self = .macBookPro15In2009
        case "MacBookPro5,2":
            self = .macBookPro17In2009
        case "MacBookPro7,1":
            self = .macBookPro13In2010
        case "MacBookPro6,1", "MacBookPro6,2":
            self = .macBookPro17In2010
        case "MacBookPro8,1":
            self = .macBookPro13In2011
        case "MacBookPro8,2":
            self = .macBookPro15In2011
        case "MacBookPro8,3":
            self = .macBookPro17In2011
        case "MacBookPro9,2":
            self = .macBookPro13In2012
        case "MacBookPro9,1":
            self = .macBookPro15In2012
        case "MacBookPro10,1":
            self = .macBookProRetina15In2012
        case "MacBookPro10,2":
            self = .macBookProRetina13In2012To2013
        case "MacBookPro11,2", "MacBookPro11,3":
            self = .macBookProRetina15In2013To2014
        case "MacBookPro11,1":
            self = .macBookProRetina13In2013To2014
        case "MacBookPro11,4", "MacBookPro11,5":
            self = .macBookProRetina15In2015
        case "MacBookPro12,1":
            self = .macBookProRetina13In2015
        case "MacBookPro13,2", "MacBookPro13,1":
            self = .macBookPro13In2016
        case "MacBookPro13,3":
            self = .macBookPro15In2016
        case "MacBookPro14,2", "MacBookPro14,1":
            self = .macBookPro13In2017
        case "MacBookPro14,3":
            self = .macBookPro15In2017
        case "MacBookAir2,1":
            self = .macBookAir2009
        case "MacBookAir3,1":
            self = .macBookAir11In2010
        case "MacBookAir3,2":
            self = .macBookAir13In2010
        case "MacBookAir5,1":
            self = .macBookAir11In2012
        case "MacBookAir5,2":
            self = .macBookAir13In2012
        case "MacBookAir6,1":
            self = .macBookAir11In2013To2014
        case "MacBookAir6,2":
            self = .macBookAir13In2013To2014
        case "MacBookAir7,1":
            self = .macBookAir11In2015
        case "MacBookAir7,2":
            self = .macBookAir13In2015To2017
        case "MacBook10,1":
            self = .macBookRetina12In2017
        case "MacBook9,1":
            self = .macBookRetina12In2016
        case "MacBook8,1":
            self = .macBookRetina12In2015
        case "MacBook7,1":
            self = .macBook13In2010
        case "MacBook6,1":
            self = .macBook13InLate2009
        case "MacBook5,2":
            self = .macBook13In2009
        case "HomePod1,1":
            self = .homePod // TODO - Fix this when the real product code comes out
        case "Watch1,1", "Watch1,2":
            self = .appleWatch
        case "Watch2,6", "Watch2,7":
            self = .appleWatchSeries1
        case "Watch2,3", "Watch2,4":
            self = .appleWatchSeries2
        case "Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4":
            self = .appleWatchSeries3
        case "AirPods1,1":
            self = .airPods
        case "iPhone1,1":
            self = .iPhone
        case "iPhone1,2":
            self = .iPhone3G
        case "iPhone2,1":
            self = .iPhone3GS
        case "iPhone3,1", "iPhone3,3":
            self = .iPhone4
        case "iPhone4,1":
            self = .iPhone4S
        case "iPhone5,1", "iPhone5,2":
            self = .iPhone5
        case "iPhone5,3", "iPhone5,4":
            self = .iPhone5C
        case "iPhone6,1", "iPhone6,2":
            self = .iPhone5S
        case "iPhone7,1":
            self = .iPhone6Plus
        case "iPhone7,2":
            self = .iPhone6
        case "iPhone8,1":
            self = .iPhone6S
        case "iPhone8,2":
            self = .iPhone6SPlus
        case "iPhone8,4":
            self = .iPhoneSE
        case "iPhone9,1", "iPhone9,3":
            self = .iPhone7
        case "iPhone9,2", "iPhone9,4":
            self = .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":
            self = .iPhone8
        case "iPhone10,2", "iPhone10,5":
            self = .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":
            self = .iPhoneX
        case "iPad1,1":
            self = .iPad
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            self = .iPad2
        case "iPad2,5", "iPad2,6", "iPad2,7":
            self = .iPadMini
        case "iPad3,1", "iPad3,2", "iPad3,3":
            self = .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":
            self = .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":
            self = .iPadAir
        case "iPad4,4", "iPad4,5", "iPad4,6":
            self = .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":
            self = .iPadMini3
        case "iPad5,1", "iPad5,2":
            self = .iPadMini4
        case "iPad5,3", "iPad5,4":
            self = .iPadAir2
        case "iPad6,3", "iPad6,4":
            self = .iPadPro12In
        case "iPad6,7", "iPad6,8":
            self = .iPadPro9In
        case "iPad6,11", "iPad6,12":
            self = .iPad5thGen
        case "iPad7,1", "iPad7,2":
            self = .iPadPro12In2ndGen
        case "iPad7,3", "iPad7,4":
            self = .iPadPro10In
        case "iPod1,1":
            self = .iPodTouch
        case "iPod2,1":
            self = .iPodTouch2ndGen
        case "iPod3,1":
            self = .iPodTouch3rdGen
        case "iPod4,1":
            self = .iPodTouch4thGen
        case "iPod5,1":
            self = .iPodTouch5thGen
        case "iPod7,1":
            self = .iPodTouch6thGen
        case "AppleTV2,1":
            self = .appleTV2ndGen
        case "AppleTV3,1", "AppleTV3,2":
            self = .appleTV3rdGen
        case "AppleTV5,3":
            self = .appleTV4thGen
        case "AppleTV6,2":
            self = .appleTV4K
        default:
            self = .unknown
        }
    }
}
