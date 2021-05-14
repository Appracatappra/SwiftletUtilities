# Swiftlet Extensions

**Swiftlet Extensions** provide several useful features to common, built-in SwiftUI and Swift data types such as converting `Color` to/from hex strings (for example `#FF0000`), creating `Image` instances from Base64 encoded strings stored in `Data` objects and encoding `Images` as Base64 strings or `Data` objects.

The following extensions are available:

* [Color Extensions](#Color-Extensions) - Extends `Color` to support the Action Data controls and adds convenience methods for working with colors in a `Codable`, `Encodable` or `Decodable` class.
* [Data Extensions](#Data-Extensions) - Extends `Data` to support the Action Data controls and adds convenience methods for working with data properties in a `Codable`, `Encodable` or `Decodable` class.
* [Image Extensions](#Image-Extensions) - Extends `Image` to support the Action Data controls and adds convenience methods for working with image properties in a `Codable`, `Encodable` or `Decodable` class.
* [String Extensions](#String-Extensions) - Extends `String` to support the Action Data controls and adds convenience methods for working with `UIImage` and `UIColor` properties in a `Codable`, `Encodable` or `Decodable` class.
* [Array Extensions](#Array-Extensions) - Extends `Array` with new functions for working with collections.
* [Double Extensions](#Double-Extensions) - Extends `Double` with several useful features.
* [Int Extensions](#Int-Extensions) - Extends `Int` with several useful features.
* [@Published Extensions](#Published-Extensions) - Allows properties that are marked `@Published` and allows them to be `Codable` with `Encode` and `Decode` conformance.
* [View Extensions](#View Extensions) - Conditionally apply modifiers depending on the target operating system.

<a name="Color-Extensions"></a>
## Color Extensions

Extends `Color` to support the Action Data controls and adds convenience methods for working with colors in a `Codable`, `Encodable` or `Decodable` class.

### Color as Hex String

Because `Color` is not `Codable`, it cannot directly be included in a data model object as a property. **Swiftlet Extensions** include several helper methods to work with color as a hex string to get around this limitation.

A hex string can be in either the `rrggbb` or `rrggbbaa` formats where:
     
* `rr` - Specifies the red component as a hex value in the range 00 to FF.
* `gg` - Specifies the green component as a hex value in the range 00 to FF.
* `bb` - Specifies the blue component as a hex value in the range 00 to FF.
* `aa` - Specifies the alpha component as a hex value in the range 00 to FF.
 
The hex string can optionally start with the prefix of `#`. 

#### Examples:

```swift
// Assign a color from a string
let color: Color ~= "#FF0000"

// Initialize a color from a hex string
let green = Color(fromHex: "00FF00")

// Convert color to a hex string
let white = Color.white.toHex()
```

<a name="Data-Extensions"></a>
## Data Extensions

Extends `Data` to support the Action Data controls and adds convenience methods for working with data properties in a `Codable`, `Encodable` or `Decodable` class.

### Working with Images

Because `Image` is not `Codable`, it cannot directly be included in a data model object as a property. **Swiftlet Extensions** include several helper methods to work with images as Base 64 encoded data to get around this limitation.

#### Examples:

```swift
// Assign data from an image
let icon: Data ~= Image(named: "Icon.png")

// Convert data to an image
let image = icon.image
```

<a name="Image-Extensions"></a>
## Image Extensions

Extends `Image` to support the Action Data controls and adds convenience methods for working with image properties in a `Codable`, `Encodable` or `Decodable` class.

### Working with Images

Because `Image` is not `Codable`, it cannot directly be included in a data model object as a property. **Swiftlet Extensions** include several helper methods to work with images as Base 64 encoded data to get around this limitation.

#### Examples:

```swift
// Assign data from an image
let icon: Data ~= Image(named: "Icon.png")
let icon2 = Image(named: "Icon2.png").toData()

// Assign image from data
let image: Image ~= icon

// Base 64 encode an image
let base64 = Image(named: "Icon.png").toString()

// Assign image from base 64 encoded string
let image2: Image ~= base64 

// Initialize an image from a base 64 encoded string
let image3 = Image(fromString: base64) 
```

<a name="String-Extensions"></a>
## String Extensions

Extends `String` to support the Action Data controls and adds convenience methods for working with `Image` and `Color` properties in a `Codable`, `Encodable` or `Decodable` class.

### Color as Hex String

Because `Color` is not `Codable`, it cannot directly be included in a data model object as a property. **Swiftlet Extensions** include several helper methods to work with color as a hex string to get around this limitation.

A hex string can be in either the `rrggbb` or `rrggbbaa` formats where:
     
* `rr` - Specifies the red component as a hex value in the range 00 to FF.
* `gg` - Specifies the green component as a hex value in the range 00 to FF.
* `bb` - Specifies the blue component as a hex value in the range 00 to FF.
* `aa` - Specifies the alpha component as a hex value in the range 00 to FF.
 
The hex string can optionally start with the prefix of `#`. 

#### Examples:

```swift
// Assign a string from a color
let red: String ~= "FF0000"

// Get a UIColor from a hex string
let uiRed = red.color

// Initialize a string from a color
let white = String(fromColor: Color.white)
```

### Working with Images

Because `Image` is not `Codable`, it cannot directly be included in a data model object as a property. **Swiftlet Extensions** include several helper methods to work with images as Base 64 encoded data to get around this limitation.

#### Examples:

```swift
// Get an image
let icon = Image(namde: "Icon.png")

// Assign a string from an image
let base64: String ~= icon

// Get a UIImage from a base 64 encoded string
let myIcon = base64.image

// Initialize a string from an image
let iconString = String(fromImage: icon)
```

<a name="Array-Extensions"></a>
## Array Extensions

Extends `Array` with new functions for working with collections.
 
### Examples:
 
```swift
// Build a sample array.
var values = ["One", "Two"]
 
// Add new values if they don't already exist
values.update(with: ["One", "Three"])
```

<a name="Double-Extensions"></a>
## Double Extensions

Extends `Double` with several useful features.
 
### Example:

```swift
let n:Double = 1000.00
 
// Returns 1,000
let text = n.formatted()
```

<a name="Int-Extensions"></a>
## Int Extensions

Extends `Int` with several useful features.
 
### Example:

```swift
let n:Int = 1000
 
// Returns 1,000
let text = n.formatted()
```

<a name="Published-Extensions"></a>
## @Published Extensions

Allows properties that are marked `@Published` and allows them to be `Codable` with `Encode` and `Decode` conformance.

<a name="View-Extensions"></a>
## View Extensions

Conditionally apply modifiers depending on the target operating system.

### Example:

```swift
struct ContentView: View {
	var body: some View {
	    Text("Unicorn")
	        .font(.system(size: 10))
	        .ifOS(.macOS, .tvOS) {
	            $0.font(.system(size: 20))
	        }
	}
}
```