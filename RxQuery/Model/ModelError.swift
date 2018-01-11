//
//  IModelJson.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation

public enum ModelError: Swift.Error {
    
    /// Indicates a JSON structure failed to map to a object.
    case jsonMapping
    
    /// Indicates a model validation failed.
    case modelValidate
    
}

