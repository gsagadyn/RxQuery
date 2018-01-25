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
    
    private var sessionManager: SessionManager?
    private var request: DataRequest?
    private var method: HTTPMethod = HTTPMethod.get
    private var publisher: PublishSubject<ResultType>!
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
    
    public func start(publisher: PublishSubject<ResultType>, queries: [HttpQuery]) {
        self.publisher = publisher
        self.queries = queries

        if let _ = query { performInternetRequest() }
        else { publisher.onCompleted() }
    }
    
    public func stop() {
        request?.cancel()
    }
    
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: - Internet request performing.
    // ----------------------------------------------------------------------------------------------------------------
    
    /// Performs internet requests
    open func performInternetRequest() {
        let url = query?.url() ?? ""
        let parameters = query?.parameters()
        let encoding = query?.encoding() ?? URLEncoding.default
        let headers = query?.headers()
        
        sessionManager = SessionManager.default
        request = sessionManager!.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        request!.validate().response { [weak self] in self?.handleInternetResponse($0) }
    }
    
    /// Handles internet request response.
    ///
    /// - parameters:
    ///   - dataResponse: Response representation.
    open func handleInternetResponse(_ response: Alamofire.DefaultDataResponse) {
        if let error = response.error {
            publisher.onError(error)
        } else {
            publisher.onCompleted(response.data ?? Data())
        }
    }
    
}
