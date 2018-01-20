//
//  HttpQuery.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import Alamofire

/// Abstract internet query class.
open class HttpQuery: IHttpQuery {
    
    public required init() { }
    
    open func url() -> String {
        fatalError("Method should be implemented")
    }
    
    open func encoding() -> Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    open func parameters() -> Alamofire.Parameters? {
        let ignorePrefix = "__"
        let params =  self.encodeQuery()
        
        return params.filter { !$0.key.hasPrefix(ignorePrefix) }
    }
    
    open func headers() -> Alamofire.HTTPHeaders? {
        let headrePrefix = "__header__"
        let params =  self.encodeQuery()
        
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
