//
//  Observable+RxEngine.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift

extension Observable {
    
    /// Defines subscribe closure.
    public typealias SubscribeClosure<T> = (AnyObserver<T>) -> Disposable
    
    /// Creates an observable sequence from a specified subscribe method implementation.
    ///
    /// - parameters:
    ///   - engine: Engine instance that will perform queries.
    ///   - subscribe: Implementation of the resulting observable sequence's `subscribe` method.
    /// - returns: The observable sequence with the specified implementation for the `subscribe` method.
    public static func create<T: RxEngine>(_ engine: T, _ subscribe: @escaping SubscribeClosure<T.QueryType>) -> Observable<E> where T.ResultType == E {
        return Observable<T.QueryType>
            .create(subscribe)
            .toArray()
            .flatMap { Observable.create(engine, $0) }
    }
    
    /// Creates an observable sequence from a specified subscribe method implementation.
    ///
    /// - parameters:
    ///   - engine: Engine instance that will perform queries.
    ///   - queries: Set of queries that will be performerd by engine.
    /// - returns: The observable sequence with the specified implementation for the `subscribe` method.
    private static func create<T: RxEngine>(_ engine: T, _ queries: [T.QueryType]) -> Observable<E> where T.ResultType == E {
        return .create { observer in
            let publisher = PublishSubject<T.ResultType>()
            let disposable = CompositeDisposable()
            
            _ = disposable.insert(publisher.subscribe(observer))
            _ = disposable.insert(Disposables.create { engine.stop() })
            engine.start(publisher: publisher, queries: queries)
            
            return disposable
        }
    }
}
