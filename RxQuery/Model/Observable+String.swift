//
//  Observable+SwiftyJSON.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift
import SwiftyJSON

public extension Observable where Element == Data {
    
    /// Creates Observable that convert data object to String object.
    ///
    /// - parameters:
    ///   - enc: The String encoding. `utf8` by default.
    /// - returns: Observable.
    public func string(encoding enc: String.Encoding = .utf8) -> Observable<String> {
        return flatMap { data -> Observable<String> in
            guard let result = String.init(data: data, encoding: enc) else {
                return .error(RxQueryError.dataToStringConvert(data))
            }
            
            return .just(result)
        }
    }
    
}
