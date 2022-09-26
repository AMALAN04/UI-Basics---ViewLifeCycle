//
//  VerifierProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 21/09/22.
//

import Foundation
protocol Verifier {
    func loginVerifier(userId: String, password: String) -> (status: Bool, name: String?)
}
