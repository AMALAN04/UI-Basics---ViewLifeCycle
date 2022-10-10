//
//  LoginViewControllerDelegate.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 30/09/22.
//

import Foundation
import UIKit

protocol LoginViewControllerDelegate {
    var passwordFieldWarning: UILabel {get set}
    var userTextField: UITextField {get set}
    var passwordTextField: UITextField {get set}
    var userFieldWarning: UILabel {get set}
    func loginFailPopUp()
}
