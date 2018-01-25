//
//  RxEngine.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

/// Provides set of business logic that responds for executing of query set.
public protocol RxEngine {
    
    /// Defines type of query that is supported by engine.
    associatedtype QueryType: RxQuery
    
    /// Defines type that is a result of engine work.
    associatedtype ResultType
    
    /// Starts perforimng set of queries.
    ///
    /// - parameters:
    ///   - publisher: Instance of PublishSubject.
    ///   - queries: Set of queries to perform.
    func start(publisher: PublishSubject<ResultType>, queries: [QueryType])
    
    /// Stops performing queries.
    func stop()
}
