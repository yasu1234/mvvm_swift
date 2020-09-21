//
//  LoginViewModel.swift
//  mvvm-sample
//
//  Created by kuma on 2020/09/19.
//  Copyright © 2020 kuma. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let changeText = Notification.Name("changeText")
    let loginInvalid = Notification.Name("loginInvalid")
    private let notificationCenter: NotificationCenter!
    
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
    let model = LoginModel()
    
    func idPasswordChanged(id: String?, password: String?) {
        let result = model.validate(idText: id, passwordText: password)
        
        switch result {
        case .success:
            notificationCenter.post(name: changeText, object: "OK!!!")
        case .failure(let error as LoginModelError):
            notificationCenter.post(name: changeText, object: error)
            notificationCenter.post(name: loginInvalid, object: error.errorText)
        default:
            fatalError("Unexpected pattern.")
        }
    }
}

extension LoginModelError {
    // なぜfileprivate?
    // fileprivateにしないとnotificationCenter.post(name: loginInvalid, object: error.errorText)でエラーになる
    fileprivate var errorText: String {
        switch self {
        case .invalidIdAndPassword:
            return "IDとPasswordが未入力です。"
        case .invalidId:
            return "IDが未入力です。"
        case .invalidPassword:
            return "Passwordが未入力です。"
        }
    }
}
