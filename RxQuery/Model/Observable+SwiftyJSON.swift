//
//  Observable+SwiftyJSON.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift
import SwiftyJSON

public extension Observable where Element == String {
    
    /// Creates Observable that convert data object to JSON object
    ///
    /// - parameters:
    ///   - opt: The JSON serialization reading options. `[]` by default.
    /// - returns: Observable.
    public func json(options opt: JSONSerialization.ReadingOptions = []) -> Observable<SwiftyJSON.JSON> {
        return flatMap { string -> Observable<SwiftyJSON.JSON> in
            let data = string.data(using: .utf8) ?? Data()
            return .just(try JSON(data: data, options: opt))
        }
    }
    
}

public extension Observable where Element == Data {
    
    /// Creates Observable that convert string string to JSON object
    ///
    /// - parameters:
    ///   - opt: The JSON serialization reading options. `[]` by default.
    /// - returns: Observable.
    public func json(options opt: JSONSerialization.ReadingOptions = []) -> Observable<SwiftyJSON.JSON> {
        return flatMap { data -> Observable<SwiftyJSON.JSON> in
            return .just(try JSON(data: data, options: opt))
        }
    }
    
}
