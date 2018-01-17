//
//  IModelValidation.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation

/// Represents model which can be validated.
public protocol IModelValidation {
    
    /// Performs validation.
    ///
    /// - returns: Validate status (if nil - success).
    func validate() -> Error?
    
}
