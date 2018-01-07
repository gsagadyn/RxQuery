//
//  IInternetQuery.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import Alamofire

/// Represents internet query.
public protocol IInternetQuery: RxQuery {
    
    /// Initializes query.
    init()
    
    /// Defines request address.
    ///
    /// - returns: Request url.
    func url() -> String
    
    /// Defines parameters encoding.
    ///
    /// - returns: Parameter encoding type.
    func encoding() -> Alamofire.ParameterEncoding
    
    /// Defines request parameters.
    ///
    /// - returns: Request parameters.
    func parameters() -> Alamofire.Parameters?
    
    /// Defines request headers.
    ///
    /// - returns: Request headers.
    func headers() -> Alamofire.HTTPHeaders?
    
}
