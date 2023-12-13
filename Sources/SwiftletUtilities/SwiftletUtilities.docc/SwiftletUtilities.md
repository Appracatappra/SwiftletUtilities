# ``SwiftletUtilities``

Provides several useful functions that are common across many apps written in Swift, SwiftUI and Xcode.

## Overview

**Swiftlet Utilities** provides several useful functions that are common across many apps written in SwiftUI and Xcode. These include features such as testing to see if an app can connect to the internet, etc.

Additionally, many built-in types (such as `Color`, `String` and `Data`) have been extended with useful features such as converting a color to and from a hex string and moving images easily between `Data` and `String` types to support Swift's `Codable` protocol.

**Swiftlet Utilities** are support on iOS, tvOS, watchOS and macOS.

## General Extensions

**General Utilities** provide several, general utility classes to handle things such as network connectivity.

### Provided Extensions

The following extensions are provided:

* **HTMLEntity** - Decodes the given string converting any HTML Entity codes into their resulting characters.
* **Reachability** - Test to see if we have an active network connection.

## Hardware Extensions

**Hardware Utilities** provide commonly used information about the device an app is running on such as the device type (for example `iPhoneX`), the OS version (for example `iOS 11.1`) and if the app can connect to the internet.

### Provided Extensions

The following extensions are provided:

* **AppleHardwareType** - [Deprecated] Used to convert an Apple device model name (in the form `iPhone10,3`) to a human readable form (such as `iPhoneX`). This enum works with the `HardwareInformation` class to get the type of device the app is running on.
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
