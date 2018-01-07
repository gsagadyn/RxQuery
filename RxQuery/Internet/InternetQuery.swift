//
//  InternetQuery.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import Alamofire

/// Abstract internet query class.
open class InternetQuery: IInternetQuery {
    
    public required init() { }
    
    open func url() -> String {
        fatalError("Method should be implemented")
    }
    
    open func encoding() -> Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    open func parameters() -> Alamofire.Parameters? {
        let ignorePrefix = "__"
        let params =  self.serializeToDictionray()
        
        return params.filter { !$0.key.hasPrefix(ignorePrefix) }
    }
    
    open func headers() -> Alamofire.HTTPHeaders? {
        let headrePrefix = "__header__"
        let params =  self.serializeToDictionray()
        
        var headers = Alamofire.HTTPHeaders()
        params.forEach { (key, value) in
            if !key.hasPrefix(headrePrefix) { return }
            if !(value is String) { return }
            let k = key.replacingOccurrences(of: headrePrefix, with: "")
            headers[k] = (value as! String)
        }
        
        return headers
    }
    
}

// MARK - Query serialization
private extension InternetQuery {
    
    func serializeToDictionray() -> [String: Any] {
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
                case let childValue as InternetQuery:
                    queryModel[label] = childValue.serializeToDictionray() as [String: Any]
                default:
                    queryModel[label] = (value as Any?)!
                }
            }
            
            mirror = mirror?.superclassMirror
        }
        
        return queryModel
    }
}
