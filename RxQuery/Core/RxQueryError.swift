//
//  RxQueryError.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation

public enum RxQueryError: Swift.Error {
    
    /// Indicates a Data failed to map to a String object.
    case dataToStringConvert(Data)
    
    /// Indicates a model validation failed.
    case modelValidation(Any)
    
}
