//
//  LoginViewController.swift
//  mvvm-sample
//
//  Created by kuma on 2020/09/19.
//  Copyright © 2020 kuma. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let notificationCenter = NotificationCenter()
    
    // インスタンス変数の初期化時に、他のインスタンス変数の値を使用することはできない
    // lazyプロパティにすることで遅延して初期化するかviewDidload()で行えばエラーは発生しない
    private lazy var viewModel = LoginViewModel(notificationCenter: notificationCenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        idTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
//        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        notificationCenter.addObserver( self, selector: #selector(updateValidationText), name: viewModel.loginInvalid, object: nil)

    }
    
    
    @IBAction func tapLogin(_ sender: Any) {
        viewModel.idPasswordChanged(id: idTextField.text, password: passwordTextField.text)
    }
}

extension LoginViewController {
    
    @objc func textFieldEditingChanged(sender: UITextField) {
        viewModel.idPasswordChanged(id: idTextField.text, password: passwordTextField.text)
    }
    
    @objc func updateValidationText(notification: Notification) {
        guard let text = notification.object as? String else { return }
        let alert: UIAlertController = UIAlertController(title: "ログインエラー", message: text, preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
        })

        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
    }
}
