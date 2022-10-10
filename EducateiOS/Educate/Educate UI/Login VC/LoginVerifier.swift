//
//  LoginVerifier.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 21/09/22.
//

import Foundation

class LoginVerifier: Verifier {
    func loginVerifier(userId: String, password: String) -> (status: Bool, name: String?) {
        print("enterd for verification")
        let student = DatabaseHandler.dataBaseHandlerInstance.readDataOf(studentId: userId)
        if student?.password == password {
            return (true, student?.name)
        } else {
            return (false, nil)
        }
    }
}

