//
//  User.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

import Foundation 

class User {
    var profife: String = "https://cdn.pixabay.com/photo/2020/12/11/11/33/training-5822607_1280.png"
    var name: String
    var dob: String
    var phoneNo: String
    var emailId: String
    var skillSet: String = "C, C++, JAVA, SWIFT"
    var userId: String
    var password: String
    
    init(name: String, dob: String, phoneNo: String, emailId: String, userId: String, password: String) {
        self.name = name
        self.dob = dob
        self.phoneNo = phoneNo
        self.emailId = emailId
        self.userId = userId
        self.password = password
    }
}
