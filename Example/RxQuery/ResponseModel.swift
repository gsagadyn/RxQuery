//
//  ResponseModel.swift
//  RxQuery_Example
//
//  Created by Grzegorz Sagadyn on 11.01.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import RxQuery
import SwiftyJSON

class ResponseModel: IModelJson, IModelValidation, CustomStringConvertible {
    
    let argumentName: String
    
    var description: String {
        return argumentName
    }
    
    required init?(jsonData: JSON) {
        argumentName = jsonData
            .dictionaryValue["form"]?
            .dictionaryValue["argument_name"]?
            .stringValue ?? ""
    }
    
    func validate() -> Error? {
        return argumentName == "argument_value" ? nil : RxQueryError.modelValidation(self)
    }
    
}
