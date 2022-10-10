//
//  CourseListVCHelperProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 03/10/22.
//

import Foundation

protocol CourseListVCHelperProtocol {
    func applyFilter(filter: Filters, in courseData: [CourseDataModel]) -> [CourseDataModel]
}
