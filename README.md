# Swiftlet Utilities

![](https://img.shields.io/badge/license-MIT-green) ![](https://img.shields.io/badge/maintained%3F-Yes-green) ![](https://img.shields.io/badge/swift-6.0-green) ![](https://img.shields.io/badge/iOS-18.0-red) ![](https://img.shields.io/badge/macOS-15.0-red) ![](https://img.shields.io/badge/tvOS-18.0-red) ![](https://img.shields.io/badge/watchOS-11.0-red) ![](https://img.shields.io/badge/dependency-LogManager-orange) 

**Swiftlet Utilities** provides several useful functions that are common across many apps written in SwiftUI and Xcode. These include features such as testing to see if an app can connect to the internet, etc.

> NOTE: **Swiftlet Utilities** is a replacement for our [Action Utilities](https://github.com/Appracatappra/SwiftletUtilities) library specifically designed to work with **SwiftUI**. Several other features have been modernized and improved as well.

Additionally, many built-in types (such as `Color`, `String` and `Data`) have been extended with useful features such as converting a color to and from a hex string and moving images easily between `Data` and `String` types to support Swift's `Codable` protocol.

**Swiftlet Utilities** are support on iOS, tvOS, watchOS and macOS.

## Support

If you find `SwiftletUtilities` useful and would like to help support its continued development and maintenance, please consider making a small donation, especially if you are using it in a commercial product:

<a href="https://www.buymeacoffee.com/KevinAtAppra" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

It's through the support of contributors like yourself, I can continue to build, release and maintain high-quality, well documented Swift Packages like `SwiftletUtilities` for free.


<a name="Installation"></a>
## Installation

**Swift Package Manager** (Xcode 11 and above)

1. In Xcode, select the **File** > **Add Package Dependency…** menu item.
2. Paste `https://github.com/Appracatappra/SwiftletUtilities.git` in the dialog box.
3. Follow the Xcode's instruction to complete the installation.

> Why not CocoaPods, or Carthage, or blank?

Supporting multiple dependency managers makes maintaining a library exponentially more complicated and time consuming.

Since, the **Swift Package Manager** is integrated with Xcode 11 (and greater), it's the easiest choice to support going further.

<a name="General-Extensions"></a>
## General Extensions

**General Utilities** provide several, general utility classes to handle things such as network connectivity.

### Provided Extensions

The following extensions are provided:

* **HTMLEntity** - Decodes the given string converting any HTML Entity codes into their resulting characters.
* **Reachability** - Test to see if we have an active network connection.

<a name="Hardware-Extensions"></a>
## Hardware Extensions

**Hardware Utilities** provide commonly used information about the device an app is running on such as the device type (for example `iPhoneX`), the OS version (for example `iOS 11.1`) and if the app can connect to the internet.

### Provided Extensions

The following extensions are provided:

* **AppleHardwareType** - Deprecated] Used to convert an Apple device model name (in the form `iPhone10,3`) to a human readable form (such as `iPhoneX`). This enum works with the `HardwareInformation` class to get the type of device the app is running on.
* **HardwareInformation** - Defines a set of convenience properties and functions when working on Apple devices, such as checking the device model name (`iPhone10,3`), getting the device type (`iPhoneX`), getting the OS version (`iOS 11.1`), the current device orientation and internet connection state:
	* **isPhone** - Returns `true` if the app is running on an iPhone, else returns `false`.
	* **isPad** - Returns `true` if the app is running on an iPad, else returns `false`. 
	* **isTV** - Returns `true` if the app is running on an Apple TV, else returns `false`.
	* **isCar** - Returns `true` if the app is running on a CarPlay connected device, else returns `false`.
	* **isWatch** - Returns `true` if the app is running on an Apple Watch, else returns `false`. 
	* **isMac** - Returns `true` if the app is running on a Mac laptop or desktop, else returns `false`.
	* **modelName** - Returns the model name of the device the app is running on. For example, `iPhone10,3` or `iPhone10,6` for the `iPhone X`.
	* **deviceType** - Returns the human-readable type of the device that the app is running on (for example `iPhoneX`) or `unknown` if the type cannot be discovered. 
	* **osVersion** - Returns the version number (for example `iOS 11.1`) of the OS installed on the device that the app is running on.

<a name="Swiftlet-Extensions"></a>
## Swiftlet Extensions

**Swiftlet Extensions** provide several useful features to common, built-in SwiftUI and Swift data types such as converting `Color` to/from hex strings (for example `#FF0000`), creating `Image` instances from Base64 encoded strings stored in `Data` objects and encoding `Images` as Base64 strings or `Data` objects.

#### SwiftUI Examples:

```swift
// Assign a color from a string
let color: Color ~= "#FF0000"

// Initialize a color from a hex string
let green = Color(fromHex: "00FF00")

// Convert color to a hex string
let white = Color.white.toHex()
```

### Provided Extensions

The following extensions are provided:

* **Color** - Extends `Color` to support the Action Data controls and adds convenience methods for working with colors in a `Codable`, `Encodable` or `Decodable` class.
* **Data** - Extends `Data` to support the Action Data controls and adds convenience methods for working with data properties in a `Codable`, `Encodable` or `Decodable` class.
* **Image** - Extends `Image` to support the Action Data controls and adds convenience methods for working with image properties in a `Codable`, `Encodable` or `Decodable` class.
* **String** - Extends `String` to support the Action Data controls and adds convenience methods for working with `Image` and `Color` properties in a `Codable`, `Encodable` or `Decodable` class.
* **Array** - Extends `Array` with new functions for working with collections.
* **Double** - Extends `Double` with several useful features.
* **Int** - Extends `Int` with several useful features.
* **@Published** - Allows properties that are marked `@Published` and allows them to be `Codable` with `Encode` and `Decode` conformance.
* **View** - Conditionally apply modifiers depending on the target operating system.

# Documentation

The **Package** includes full **DocC Documentation** for all features.
