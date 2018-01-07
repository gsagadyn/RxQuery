//
//  InternetEngine.swift
//  RxQuery
//
//  Created by Grzegorz Sagadyn on 06.01.2018.
//

import Foundation
import RxSwift
import Alamofire

/// Executes internet requests
open class InternetEngine<T>: RxEngine {
    
    public typealias QueryType = InternetQuery
    public typealias ResultType = T
    
    private var request: DataRequest?
    private var method: HTTPMethod = HTTPMethod.get
    private var observer: AnyObserver<ResultType>!
    private var disposable: Disposable!
    private var query: InternetQuery? { return queries.last }
    
    /// Set of queries
    public var queries: [InternetQuery]!
    
    private init() { }
    
    // ----------------------------------------------------------------------------------------------------------------
    //MARK: - Implementation of RxEngine.
    // ----------------------------------------------------------------------------------------------------------------
    
    public func start(observer: AnyObserver<ResultType>, disposable: Disposable, queries: [InternetQuery]) {
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
    //MARK: - Internet request performing.
    // ----------------------------------------------------------------------------------------------------------------
    
    /// Performs internet requests
    open func performInternetRequest() {
        let u = query?.url() ?? ""
        let p = query?.parameters()
        let e = query?.encoding() ?? URLEncoding.default
        let h = query?.headers()
        
        request = Alamofire.request(u, method: method, parameters: p, encoding: e, headers: h)
        request?.response(completionHandler: { [weak self] in self?.handleInternetResponse($0) } )
    }
    
    /// Handles internet request response.
    ///
    /// - parameters:
    ///   - dataResponse: Response representation.
    open func handleInternetResponse(_ dataResponse: DefaultDataResponse) {
        let r = dataResponse.response
        let d = dataResponse.data
        let e = dataResponse.error
        
        if let err = dataResponse.error {
            observer.onError(err)
            return
        }
        
        switch ResultType.self {
        case is String.Type:
            let result = Request.serializeResponseString(encoding: nil, response: r, data: d, error: e)
            observer.onNext((result.value ?? "") as! T)
            break
        case is Data.Type:
            let result = Request.serializeResponseData(response: r, data: d, error: e)
            observer.onNext((result.value ?? Data()) as! T)
            break
        default:
            break
        }
        
        observer.onCompleted()
    }
    
}

public extension InternetEngine where T == String {
    
    /// Initializes Internet Engine
    ///
    /// - parameters:
    ///   - method: Request method.
    public convenience init(_ method: HTTPMethod = HTTPMethod.get) {
        self.init()
        self.method = method
    }
    
}

public extension InternetEngine where T == Data {
    
    /// Initializes Internet Engine
    ///
    /// - parameters:
    ///   - method: Request method.
    public convenience init(_ method: HTTPMethod = HTTPMethod.get) {
        self.init()
        self.method = method
    }
    
}

public extension InternetEngine where T == Void {
    
    /// Initializes Internet Engine
    ///
    /// - parameters:
    ///   - method: Request method.
    public convenience init(_ method: HTTPMethod = HTTPMethod.get) {
        self.init()
        self.method = method
    }
    
}

