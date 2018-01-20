//
//  ViewController.swift
//  RxQuery
//
//  Created by gsagadyn on 01/06/2018.
//  Copyright (c) 2018 gsagadyn. All rights reserved.
//

import UIKit
import RxSwift
import RxQuery
import Alamofire

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable
            .create(HttpEngine(HTTPMethod.post), { observer -> Disposable in
                let query = TestHttpQuery()
                query.argument_name = "argument_value"
                query.__header__header_name = "header_value"
                
                observer.onCompleted(query)
                return Disposables.create()
            })
            .subscribe(onNext: { (r) in
                print("response \(r)")
            }, onError: { (e) in
                print("error \(e)")
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            }).disposed(by: disposeBag)
    }
}

