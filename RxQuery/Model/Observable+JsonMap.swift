//
//  Observable+JsonMap.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift
import SwiftyJSON

public extension Observable where Element == SwiftyJSON.JSON {
    
    /// Maps JSON structure from the signal into an object which implements the IModelJson.
    ///
    /// - parameters:
    ///   - opt: The JSON serialization reading options. `[]` by default.
    /// - returns: Observable.
    public func map<T: IModelJson>(to type: T.Type) -> Observable<T> {
        return flatMap { jsonObject -> Single<T> in
            guard let obj = T(jsonData: JSON(jsonObject)) else {
                throw ModelError.jsonMapping
            }
            
            return .just(obj)
        }
    }
    
}
