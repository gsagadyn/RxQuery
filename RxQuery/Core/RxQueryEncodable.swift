//
//  RxQuery.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation

public extension RxQuery {
    public func encodeQuery() -> [String: Any] {
        var queryModel = [String: Any]()
        
        var mirror: Mirror? = Mirror(reflecting: self)
        while mirror != nil {
            for case let (label?, value) in mirror!.children {
                switch value {
                case _ where value as AnyObject === NSNull():
                    continue
                case let childValue as String:
                    queryModel[label] = childValue
                case let childValue as NSNumber:
                    queryModel[label] = childValue
                case let childValue as RxQuery:
                    queryModel[label] = childValue.encodeQuery() as [String: Any]
                case let childValue as Encodable:
                    guard let encodedValue = childValue.toJSON() else { continue }
                    queryModel[label] = encodedValue
                default:
                    queryModel[label] = (value as Any?)!
                }
            }
            
            mirror = mirror?.superclassMirror
        }
        
        return queryModel
    }
}

// -----------------------------------------------------------------------------
// MARK: - Encode to JSON
// -----------------------------------------------------------------------------

fileprivate extension Encodable {
    fileprivate func toJSON() -> Any? {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return try? JSONSerialization.jsonObject(with: data, options: [])
    }
}
