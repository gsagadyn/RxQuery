//
//  TestHttpQuery.swift
//  RxQuery_Example
//
//  Created by Grzegorz Sagadyn on 07.01.2018.
//

import Foundation
import RxQuery
import Alamofire

struct TestEncodable: Encodable {
    let name: String
}

class TestHttpQuery: HttpQuery {
    
    var argument_name: String?
    var argument_encodable: TestEncodable?
    var __header__header_name: String?
    
    override func url() -> String {
        return "http://httpbin.org/post"
    }
    
}

