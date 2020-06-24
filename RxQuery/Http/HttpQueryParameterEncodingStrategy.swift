//
//  HttpQueryParameterEncodingStrategy.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 24/06/2020.
//

import Foundation

public enum HttpQueryParameterEncodingStrategy {
    case `default`
    case snakeCase
    case camelCase
}

// -----------------------------------------------------------------------------
// MARK: - Parameter Encoder
// -----------------------------------------------------------------------------

extension HttpQueryParameterEncodingStrategy {
    private static var uppercaseLetters = CharacterSet.uppercaseLetters

    internal func apply(_ value: String) -> String {
        switch self {
        case .snakeCase:
            return snakeCase(value)
        case .camelCase:
            return camelCase(value)
        default:
            return value
        }
    }

    private func snakeCase(_ value: String) -> String {
        value.unicodeScalars.reduce("") {
            let isUppercased = Self.uppercaseLetters.contains($1)
            let currentItem = isUppercased ? String($1).lowercased() : String($1)
            let separator = $0.isEmpty || !isUppercased ? "" : "_"
            return "\($0)\(separator)\(currentItem)"
        }
    }

    private func camelCase(_ value: String) -> String {
        value.components(separatedBy: "_")
            .enumerated()
            .map {
                guard $0.offset > 0 else { return $0.element }
                let prefix = $0.element.prefix(1).capitalized
                let suffix = $0.element.dropFirst()
                return prefix + suffix
            }
            .joined()
    }
}
