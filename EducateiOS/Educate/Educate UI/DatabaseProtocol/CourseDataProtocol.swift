//
//  CourseDataProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation

protocol CourseDataProtocol {
    func createCourseTable()
    func insertData(course: Course) -> Bool
}
