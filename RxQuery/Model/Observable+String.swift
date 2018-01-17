//
//  Observable+String.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

public extension Observable where Element == [Any] {
    
    /// Creates Observable that convert JSON object to String object.
    ///
    /// - returns: Observable.
    public func string() -> Observable<String> {
        return flatMap { json -> Observable<String> in
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let result = String(data: data, encoding: .utf8) else {
                return .error(RxQueryError.dataToStringConvert(data))
            }
            
            return .just(result)
        }
    }
    
}

public extension Observable where Element == [String: Any] {
    
    /// Creates Observable that convert JSON object to String object.
    ///
    /// - returns: Observable.
    public func string() -> Observable<String> {
        return flatMap { json -> Observable<String> in
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let result = String(data: data, encoding: .utf8) else {
                return .error(RxQueryError.dataToStringConvert(data))
            }
            
            return .just(result)
        }
    }
    
}

public extension Observable where Element == Data {
    
    /// Creates Observable that convert data object to String object.
    ///
    /// - parameters:
    ///   - enc: The String encoding. `utf8` by default.
    /// - returns: Observable.
    public func string(encoding enc: String.Encoding = .utf8) -> Observable<String> {
        return flatMap { data -> Observable<String> in
            guard let result = String(data: data, encoding: enc) else {
                return .error(RxQueryError.dataToStringConvert(data))
            }
            
            return .just(result)
        }
    }
    
}

