//
//  Course.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

import Foundation

class Course {
    var courseId: Int
    var courseName: String
    var categoryId: Int
    var instructorId: String
    var description: String
    var price: Int
    var courseCover: String = "https://cdn.pixabay.com/photo/2020/12/11/11/33/training-5822607_1280.png"
    var courseVideo: String = "https://youtu.be/OjdT2l-EZJA?list=PLfn3cNtmZdPOe3R_wO_h540QNfMkCQ0ho"
    init( courseId: Int, coutseName: String, categoryId: Int, instructorId: String, description: String, price: Int) {
        self.courseId = courseId
        self.courseName = coutseName
        self.categoryId = categoryId
        self.description = description
        self.price = price
        self.instructorId = instructorId
    }
}
