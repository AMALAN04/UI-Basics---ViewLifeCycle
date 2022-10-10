//
//  InstructorVCHelper.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 05/10/22.
//

import Foundation

class InstructorVCHelper: InstructorVCHelperProtocol{
    
    func readCourseDatasOfInstructor(id: String) -> [CourseDataModel] {
        return DatabaseHandler.dataBaseHandlerInstance.readCourseDatasOfInstructor(id: id)
    }
    
}
