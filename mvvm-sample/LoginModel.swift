//
//  LoginModel.swift
//  mvvm-sample
//
//  Created by kuma on 2020/09/20.
//  Copyright © 2020 kuma. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum LoginModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

class LoginModel {
    func validate(idText: String?, passwordText: String?) -> Result<Void> {
        switch(idText, passwordText) {
            // 必要？
//        case (.none, .none):
//            return .failure(LoginModelError.invalidIdAndPassword)
//        case (.none, .some):
//            return .failure(LoginModelError.invalidId)
//        case (.some, .none):
//            return .failure(LoginModelError.invalidPassword)
        case (idText, passwordText):
            switch (idText?.isEmpty, passwordText?.isEmpty) {
            case (true, true):
                return .failure(LoginModelError.invalidIdAndPassword)
            case (false, false):
                return .success(())
            case (true, false):
                return .failure(LoginModelError.invalidId)
            case (false, true):
                return .failure(LoginModelError.invalidPassword)
            default:
                fatalError("Unexpected pattern")
            }
        default:
            fatalError("Unexpected pattern")
        }
    }
}
