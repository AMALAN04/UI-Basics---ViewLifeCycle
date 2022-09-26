//
//  InstanceProvider.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation
class InstanceProvider {
    static let studentData: StudentDataProtocol = StudentData()
    static let instructorData: InstructorDataProtocol = InstructorData()
    static let categoryData: CategoryDataProtocol = CategoryData()
    static let courseData: CourseDataProtocol = CourseData()
    static let purchaseData: PurchaseDataProtocol = PurchaseData()
}
