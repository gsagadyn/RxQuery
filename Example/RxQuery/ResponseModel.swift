//
//  ResponseModel.swift
//  RxQuery_Example
//
//  Created by Grzegorz Sagadyn on 11.01.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RxQuery

struct ResponseModel: Codable, IModelValidation {
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
    
    func validate() -> Error? {
        return form.argumentName == "argument_value" ? nil : RxQueryError.modelValidation(self)
    }
    
}

struct Form: Codable {
    let argumentName: String

    enum CodingKeys: String, CodingKey {
        case argumentName = "argument_name"
    }
}













//class ResponseModel: Codable, IModelValidation, CustomStringConvertible {
//
//    let argumentName: String
//
//    var description: String {
//        return argumentName
//    }
////
////    required init?(jsonData: JSON) {
////        argumentName = jsonData
////            .dictionaryValue["form"]?
////            .dictionaryValue["argument_name"]?
////            .stringValue ?? ""
////    }
////
//    func validate() -> Error? {
//        return argumentName == "argument_value" ? nil : RxQueryError.modelValidation(self)
//    }
//
//}

