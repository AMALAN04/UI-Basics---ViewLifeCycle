//
//  studentDataProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation

protocol StudentDataProtocol {
    func createUserTable()
    func insertData(student: Student) -> Bool
    func readDataOf(studentId: String) -> Student?
}
