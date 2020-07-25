//
//  LoginViewModel.swift
//  LoginRxSwift
//
//  Created by Carlos Alcala on 7/25/20.
//  Copyright © 2020 Carlos Alcala. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let usernamePublishSubject = PublishSubject<String>()
    let passwordPublishSubject = PublishSubject<String>()

    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(usernamePublishSubject.asObservable().startWith(""), passwordPublishSubject.asObservable().startWith("")).map { username, password in
            return username.count > 3 && password.count > 3
        }.startWith(false)
    }

}
