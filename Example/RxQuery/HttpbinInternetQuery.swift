//
//  TestInternetQuery.swift
//  RxQuery_Example
//
//  Created by Grzegorz Sagadyn on 07.01.2018.
//

import Foundation
import RxQuery
import Alamofire

class TestInternetQuery: InternetQuery {
    
    var argument_name: String?
    var __header__header_name: String?
    
    override func url() -> String {
        return "http://httpbin.org/post"
    }
    
}

