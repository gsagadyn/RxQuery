//
//  HttpEngine.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift
import Alamofire

/// Executes internet requests
open class HttpEngine: RxEngine {
    
    public typealias QueryType = HttpQuery
    public typealias ResultType = Foundation.Data
    
    private var request: DataRequest?
    private var method: HTTPMethod = HTTPMethod.get
    private var observer: AnyObserver<ResultType>!
    private var disposable: Disposable!
    private var query: HttpQuery? { return queries.last }
    
    /// Set of queries
    public private(set) var queries: [HttpQuery]!
    
    /// Initializes Internet Engine
    ///
    /// - parameters:
    ///   - method: Request method.
    public init(_ method: HTTPMethod = HTTPMethod.get) {
        self.method = method
    }
    
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: - Implementation of RxEngine.
    // ----------------------------------------------------------------------------------------------------------------
    
    public func start(observer: AnyObserver<ResultType>, disposable: Disposable, queries: [HttpQuery]) {
        self.observer = observer
        self.disposable = disposable
        self.queries = queries
        
        if let _ = query { performInternetRequest() }
        else { observer.onCompleted() }
    }
    
    public func stop() {
        request?.cancel()
    }
    
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: - Internet request performing.
    // ----------------------------------------------------------------------------------------------------------------
    
    /// Performs internet requests
    open func performInternetRequest() {
        let u = query?.url() ?? ""
        let p = query?.parameters()
        let e = query?.encoding() ?? URLEncoding.default
        let h = query?.headers()
        
        request = Alamofire.request(u, method: method, parameters: p, encoding: e, headers: h)
        request!.validate().responseData(completionHandler: { [weak self] in self?.handleInternetResponse($0) })
    }
    
    /// Handles internet request response.
    ///
    /// - parameters:
    ///   - dataResponse: Response representation.
    open func handleInternetResponse(_ dataResponse: Alamofire.DataResponse<Data>) {
        if let error = dataResponse.error {
            observer.onError(error)
        } else {
            observer.onCompleted(dataResponse.data ?? Data())
            observer.onCompleted()
        }
    }
    
}