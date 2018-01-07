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
    ///   - observer: Instance of Observer.
    ///   - disposable: Instance of Disposable.
    ///   - queries: Set of queries to perform.
    func start(observer: AnyObserver<ResultType>, disposable: Disposable, queries: [QueryType])
    
    /// Stops performing queries.
    func stop()
}
