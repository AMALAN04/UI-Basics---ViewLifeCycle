//
//  InstructorDataProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation

protocol InstructorDataProtocol {
    func createUserTable()
    func insertData(instructor: Instructor) -> Bool
}
