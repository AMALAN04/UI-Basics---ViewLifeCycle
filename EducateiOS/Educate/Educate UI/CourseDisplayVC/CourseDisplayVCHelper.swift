//
//  CourseDisplayVCHelper.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 03/10/22.
//

import Foundation

class CourseDisplayVCHelper {
    func fetchInstructorDetails(instructorId: String) -> InstructorDataModel? {
       return DatabaseHandler.dataBaseHandlerInstance.readDataOf(instructorId: instructorId)
    }
    
    func courseDetails(courseId: Int) -> CourseDataModel? {
        return DatabaseHandler.dataBaseHandlerInstance.readCourseDataOf(courseId: courseId)
    }
}
