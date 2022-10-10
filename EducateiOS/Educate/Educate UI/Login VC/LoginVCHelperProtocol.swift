//
//  VerifierProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 21/09/22.
//

import Foundation
protocol LoginVCHelperProtocol {
    var loginVCDelegate: LoginViewControllerDelegate? {get set}
    func userInputValidator() -> Bool
    func loginVerifier(userId: String, password: String) -> Bool
}
