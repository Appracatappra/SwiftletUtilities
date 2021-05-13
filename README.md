# Swiftlet Utilities

![](https://img.shields.io/badge/license-MIT-green) ![](https://img.shields.io/badge/maintained%3F-Yes-green) ![](https://img.shields.io/badge/swift-5.4-green) ![](https://img.shields.io/badge/iOS-13.0-red) ![](https://img.shields.io/badge/macOS-10.15-red) ![](https://img.shields.io/badge/tvOS-13.0-red) ![](https://img.shields.io/badge/watchOS-6.0-red) ![](https://img.shields.io/badge/release-v1.0.6-blue)

**Swiftlet Utilities** provides several useful functions that are common across many apps written in SwiftUI and Xcode. These include features such as testing to see if an app can connect to the internet, etc.

> NOTE: **Swiftlet Utilities** is a replacement for our [Action Utilities](https://github.com/Appracatappra/SwiftletUtilities) library specifically designed to work with **SwiftUI**. Several other features have been modernized and improved as well.

Additionally, many built-in types (such as `Color`, `String` and `Data`) have been extended with useful features such as converting a color to and from a hex string and moving images easily between `Data` and `String` types to support Swift's `Codable` protocol.

**Swiftlet Utilities** are support on iOS, tvOS, watchOS and macOS.

<a name="Installation"></a>
## Installation

**Swift Package Manager** (Xcode 11 and above)

1. Select **File** > **Swift Packages** > **Add Package Dependency…** from the **File** menu.
2. Paste `https://github.com/Appracatappra/SwiftletUtilities.git` in the dialog box.
3. Follow the Xcode's instruction to complete the installation.

> Why not CocoaPods, or Carthage, or blank?

Supporting multiple dependency managers makes maintaining a library exponentially more complicated and time consuming.

Since, the **Swift Package Manager** is integrated with Xcode 11 (and greater), it's the easiest choice to support going further.

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

