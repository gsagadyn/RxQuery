//
//  Observable+JSONDecoder.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

public extension Observable where Element == [Any] {
    
    /// Maps JSON structure from the signal into an object which implements the Decodable protocol.
    ///
    /// - parameters:
    ///   - type: The type of the value to decode.
    ///   - decoder: Instance of decoder.
    /// - returns: Observable.
    public func decode<T: Decodable>(to type: T.Type, by decoder: JSONDecoder? = nil) -> Observable<T> {
        return flatMap { json -> Single<T> in
            let jsonDecoder = decoder ?? JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let obj = try jsonDecoder.decode(type, from: data)
            return .just(obj)
        }
    }
    
}

public extension Observable where Element == [String: Any] {
    
    /// Maps JSON structure from the signal into an object which implements the Decodable protocol.
    ///
    /// - parameters:
    ///   - type: The type of the value to decode.
    ///   - decoder: Instance of decoder.
    /// - returns: Observable.
    public func decode<T: Decodable>(to type: T.Type, by decoder: JSONDecoder? = nil) -> Observable<T> {
        return flatMap { json -> Single<T> in
            let jsonDecoder = decoder ?? JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let obj = try jsonDecoder.decode(type, from: data)
            return .just(obj)
        }
    }
    
}

public extension Observable where Element == String {
    
    /// Maps JSON structure from the signal into an object which implements the Decodable protocol.
    ///
    /// - parameters:
    ///   - type: The type of the value to decode.
    ///   - decoder: Instance of decoder.
    /// - returns: Observable.
    public func decode<T: Decodable>(to type: T.Type, by decoder: JSONDecoder? = nil) -> Observable<T> {
        return flatMap { string -> Single<T> in
            let jsonDecoder = decoder ?? JSONDecoder()
            let data = string.data(using: .utf8) ?? Data()
            let obj = try jsonDecoder.decode(type, from: data)
            return .just(obj)
        }
    }
    
}

public extension Observable where Element == Data {
    
    /// Maps JSON structure from the signal into an object which implements the Decodable protocol.
    ///
    /// - parameters:
    ///   - type: The type of the value to decode.
    ///   - decoder: Instance of decoder.
    /// - returns: Observable.
    public func decode<T: Decodable>(to type: T.Type, by decoder: JSONDecoder? = nil) -> Observable<T> {
        return flatMap { data -> Single<T> in
            let jsonDecoder = decoder ?? JSONDecoder()
            let obj = try jsonDecoder.decode(type, from: data)
            return .just(obj)
        }
    }
    
}
