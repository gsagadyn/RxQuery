//
//  HttpQuery.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import Alamofire

/// Abstract internet query class.
open class HttpQuery: HttpQueryType {
    public required init() {}

    open func url() -> String {
        fatalError("Method should be implemented")
    }

    open func encoding() -> Alamofire.ParameterEncoding {
        return URLEncoding.default
    }

    open func parameters() -> Alamofire.Parameters? {
        let ignorePrefix = "__"
        let strategy = parameterEncodingStrategy()
        
        return encodeQuery()
            .filter { !$0.key.hasPrefix(ignorePrefix) }
            .reduce(into: [:]) { $0[strategy.apply($1.key)] = $1.value }
    }

    open func parameterEncodingStrategy() -> HttpQueryParameterEncodingStrategy {
        .default
    }

    open func headers() -> Alamofire.HTTPHeaders? {
        let headrePrefix = "__header__"
        let params = encodeQuery()

        var headers = Alamofire.HTTPHeaders()
        params.forEach { key, value in
            if !key.hasPrefix(headrePrefix) { return }
            if !(value is String) { return }
            let k = key.replacingOccurrences(of: headrePrefix, with: "")
            headers[k] = (value as! String)
        }

        return headers
    }
}
