//
//  IModelJson.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import SwiftyJSON

/// Represents class which can be initialized using JSON.
public protocol IModelJson: class {
    
    /// Inits objec using JSON.
    init?(jsonData: SwiftyJSON.JSON)
    
}


