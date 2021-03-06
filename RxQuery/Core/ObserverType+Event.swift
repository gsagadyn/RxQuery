//
//  ObserverType+Event.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 11.01.2018.
//

import Foundation
import RxSwift

extension RxSwift.ObserverType {
    
    /// Convenience method equivalent to `on(.next(element: Element))` and `on(.completed)`
    ///
    /// - parameter element: Next element to send to observer(s)
    public func onCompleted(_ element: Element) {
        on(.next(element))
        on(.completed)
    }
    
}
