//
//  Observable+JSONEncoder.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

public extension Observable where Element: Encodable {
    
    /// Map Encodable object to Data representation.
    ///
    /// - parameters:
    ///   - encoder: Instance of encoder.
    /// - returns: Observable.
    public func encode(by encoder: JSONEncoder? = nil) -> Observable<Data> {
        return flatMap { model -> Single<Data> in
            let jsonEncoder = encoder ?? JSONEncoder()
            let obj = try jsonEncoder.encode(model)
            return .just(obj)
        }
    }
    
}
