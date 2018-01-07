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

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable<String>.create(InternetEngine(HTTPMethod.post), { (o) -> Disposable in
            let query = TestInternetQuery()
            query.argument_name = "argument_value"
            query.__header__header_name = "header_value"

            o.onNext(query)
            o.onCompleted()
            return Disposables.create()
        }).subscribe(onNext: { (r) in
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

