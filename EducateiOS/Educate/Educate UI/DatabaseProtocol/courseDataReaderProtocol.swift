//
//  courseDataReaderProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 27/09/22.
//

import Foundation

protocol courseDataReaderProtocol {
    func readCourseDatasOf(category: Category) -> [CourseDataModel]
    func readCourseDatasOfInstructor(id: String) -> [CourseDataModel]
}
