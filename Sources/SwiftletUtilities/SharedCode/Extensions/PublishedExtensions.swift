//
//  PublishedExtensions.swift
//  SwiftletUtilities
//
//  Created by Kevin Mullins on 4/19/21.
//
//  Solution from:
//  https://stackoverflow.com/questions/57444059/how-to-conform-an-observableobject-to-the-codable-protocols
//

import Foundation
import struct Combine.Published

/**
 Enables `Encodable` for properties that are marked `@Published`.
 */
extension Published: Encodable where Value: Encodable {
    
    /**
    Encodes a property marked `@Published`.

    - Parameter encoder: The encoder used to incode the object.
    */
    public func encode(to encoder: Encoder) throws {
        guard
          let storageValue =
            Mirror(reflecting: self).descendant("storage")
            .map(Mirror.init)?.children.first?.value,
          let value =
            storageValue as? Value
            ??
            (storageValue as? Publisher).map(Mirror.init)?
            .descendant("subject", "currentValue")
            as? Value
        else { throw EncodingError.invalidValue(self, codingPath: encoder.codingPath) }

        try value.encode(to: encoder)
    }
}

/**
 Enables `Decodable` for properties that are marked `@Published`.
 */
extension Published: Decodable where Value: Decodable {
    
    /**
     Decodes a property marked `@Published`.
     
     - Parameter decoder: The decoder to use.
     */
    public init(from decoder: Decoder) throws {
        self.init(
          initialValue: try .init(from: decoder)
        )
    }
}

/**
 Extends `EncodingError` to support encoding of `@Published`.
 */
extension EncodingError {
    
    /// `invalidValue` without having to pass a `Context` as an argument.
    static func invalidValue(
        _ value: Any,
        codingPath: [CodingKey],
        debugDescription: String = .init()
        ) -> Self {
        .invalidValue(
          value,
          .init(
            codingPath: codingPath,
            debugDescription: debugDescription
          )
        )
    }
}
