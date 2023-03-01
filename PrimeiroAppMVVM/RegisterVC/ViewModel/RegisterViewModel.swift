//
//  LoginViewModel.swift
//  PrimeiroAppMVVM
//
//  Created by Igor Fortti on 17/02/23.
//

import UIKit
import Firebase

protocol RegisterViewModelProtocol: AnyObject {
    func successRegister()
    func errorRegister(errorMessage: String)
}

class RegisterViewModel {
    
    private weak var delegate: RegisterViewModelProtocol?
    private var auth = Auth.auth()
    
    public func delegate(delegate: RegisterViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func registerUser(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                self.delegate?.successRegister()
            } else {
                self.delegate?.errorRegister(errorMessage: error?.localizedDescription ?? "")
            }
        }
    }
}
