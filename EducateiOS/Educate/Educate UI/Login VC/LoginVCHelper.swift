//
//  LoginVCHelper.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 30/09/22.
//

import Foundation
import UIKit

class LoginVCHelper: LoginVCHelperProtocol {
    
    var loginVCDelegate: LoginViewControllerDelegate?
    static var userId = ""
    
    func userInputValidator() -> Bool {
        guard loginVCDelegate?.userTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 && loginVCDelegate?.passwordTextField.text?.count != 0 else {
            if loginVCDelegate?.userTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
                loginVCDelegate?.userTextField.layer.borderColor = UIColor.systemRed.cgColor
                loginVCDelegate?.userFieldWarning.text = "Please enter your user Id"
                loginVCDelegate?.userFieldWarning.isHidden = false
            } else {
                loginVCDelegate?.userTextField.layer.borderColor = UIColor.systemPurple.cgColor
            }
            
            if loginVCDelegate?.passwordTextField.text?.count == 0 {
                loginVCDelegate?.passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
                loginVCDelegate?.passwordFieldWarning.text = "Please enter your password"
                loginVCDelegate?.passwordFieldWarning.isHidden = false
            } else {
                loginVCDelegate?.passwordTextField.layer.borderColor = UIColor.systemPurple.cgColor
            }
            loginVCDelegate?.passwordFieldWarning.isHidden = false
            return false
        }
        loginVCDelegate?.userTextField.layer.borderColor = UIColor.systemPurple.cgColor
        loginVCDelegate?.passwordTextField.layer.borderColor = UIColor.systemPurple.cgColor
        loginVCDelegate?.passwordFieldWarning.isHidden = true
        let loginStatus = loginVerifier(userId: (loginVCDelegate?.userTextField.text) ?? "", password:  (loginVCDelegate?.passwordTextField.text) ?? "")
        print("login verified")
        return loginStatus
    }
    
    func loginVerifier(userId: String, password: String) -> Bool {
        print("enterd for verification")
        let student = DatabaseHandler.dataBaseHandlerInstance.readDataOf(studentId: userId)
        if student?.password == password {
            LoginVCHelper.userId = userId
            return true
        } else {
            loginVCDelegate?.loginFailPopUp()
            return false
        }
    }
}

