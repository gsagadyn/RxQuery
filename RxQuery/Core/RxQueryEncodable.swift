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
                default:
                    queryModel[label] = (value as Any?)!
                }
            }
            
            mirror = mirror?.superclassMirror
        }
        
        return queryModel
    }
}
