# General Utilities

**General Utilities** provide several, general utility classes to handle thing such as network connectivity.

<a name="HTMLEntity"></a>
## HTMLEntity 

Decodes the given string converting any HTML Entity codes into their resulting characters.

### Examples:

```swift
let value = HTMLEntity.decode(text)
```

<a name="Reachability"></a>
## Reachability 

Test to see if we have an active network connection.

### Examples:

```swift
let isOnline = Reachability.isConnectedToNetwork
```
