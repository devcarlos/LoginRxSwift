//
//  ViewController.swift
//  LoginRxSwift
//
//  Created by Carlos Alcala on 7/25/20.
//  Copyright © 2020 Carlos Alcala. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private var loginViewModel: LoginViewModel = LoginViewModel()
    private var disposeBag = DisposeBag()

    // MARK: Outlets
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: Actions
    @IBAction func loginAction(_ sender: UIButton) {
        print("Tapped Login...")
    }

    // MARK: VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        username.becomeFirstResponder()

        username.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.usernamePublishSubject).disposed(by: disposeBag)
        password.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.passwordPublishSubject).disposed(by: disposeBag)

        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map { $0 ? 1 : 0.1 }.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

