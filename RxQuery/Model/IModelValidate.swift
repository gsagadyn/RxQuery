//
//  IModelValidate.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation

/// Represents model which can be validated.
public protocol IModelValidate: class {
    
    /// Performs validation.
    ///
    /// - returns: Validate status (if nil - success).
    func validate() -> Error?
    
}
