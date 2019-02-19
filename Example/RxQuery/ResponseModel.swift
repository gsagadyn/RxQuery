//
//  ResponseModel.swift
//  RxQuery_Example
//
//  Created by Grzegorz Sagadyn on 11.01.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RxQuery

struct ResponseModel: Codable {
    let data: String
    let form: Form
    let origin: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case form
        case origin
        case url
    }
}

struct Form: Codable {
    let argumentName: String

    enum CodingKeys: String, CodingKey {
        case argumentName = "argument_name"
    }
}
