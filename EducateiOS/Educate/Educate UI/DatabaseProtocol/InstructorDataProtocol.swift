//
//  InstructorDataProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation

protocol InstructorDataProtocol {
    func createInstructorTable()
    func insertDataOf(instructor: Instructor) -> Bool
    func readDataOf(instructorId: String) -> InstructorDataModel?
}
