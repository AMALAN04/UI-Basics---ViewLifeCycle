//
//  CourseDataLoader.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 26/09/22.
//

import Foundation
import SQLite3

class courseDataLoader {
    func readCourseData(categoryId: Int) -> [CourseDataModel] {
        let query = """
SELECT
courseId, courseName, categoryId, instructorId, description, price, courseCover, courseVideo,  instructorData.name as instructorName
FROM
courseData
INNER JOIN instructorData ON instructorData.userId = courseData.instructorId
where
courseData.categoryId = \(categoryId)
"""
        var statement : OpaquePointer?
        var overAllCourseDetails: [CourseDataModel] = []
        if sqlite3_prepare_v2(DatabaseHandler.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let courseId = sqlite3_column_int(statement, 0)
                let courseName = String(cString: sqlite3_column_text(statement, 1))
                let categoryId = sqlite3_column_int(statement, 2)
                let instructorId = String(cString: sqlite3_column_text(statement, 3))
                let description = String(cString: sqlite3_column_text(statement, 4))
                let price = sqlite3_column_int(statement, 5)
                let courseCover = String(cString: sqlite3_column_text(statement, 6))
                let courseVideo = String(cString: sqlite3_column_text(statement, 7))
                let instructorName = String(cString: sqlite3_column_text(statement, 8))
                let course = Course(courseId: Int(courseId), coutseName: courseName, categoryId: Int(categoryId), instructorId: instructorId, description: description, price: Int(price))
                course.courseCover = courseCover
                course.courseVideo = courseVideo
                let ratingDetails = calculateRating(courseId: Int(courseId))
                let courseData = CourseDataModel(courseDetails: course, instructorName: instructorName, rating: ratingDetails.avgRating, noOfRaters: ratingDetails.noOfRaters)
                overAllCourseDetails.append(courseData)

            }
        } else {
            print("Statement Not prepared!")
        }
        sqlite3_finalize(statement)
        return overAllCourseDetails
    }

}


func calculateRating(courseId: Int) -> (avgRating: Float, noOfRaters: Int) {
    let query = """
SELECT
purchaseData.rating
FROM
purchaseData
where purchaseData.courseId = \(courseId) and purchaseData.rating  > 0  ;
"""
    var statement : OpaquePointer?
    var totalRating: Int = 0
    var noOfRaters: Int = 0
    var avgRating: Float = 0
    if sqlite3_prepare_v2(DatabaseHandler.db, query, -1, &statement, nil) == SQLITE_OK {
        while sqlite3_step(statement) == SQLITE_ROW {
            let rating = sqlite3_column_int(statement, 0)
            totalRating = totalRating + Int(rating)
            noOfRaters = noOfRaters + 1
        }
    } else {
        print("Statement Not prepared!")
    }
    if noOfRaters > 0 {
        avgRating =  Float(totalRating / noOfRaters)
        if (avgRating - Float(Int(avgRating)) > 0.4) {
            avgRating = Float(Int(avgRating)) + 0.5
        } else {
            avgRating = Float(Int(avgRating))
        }
    }
    sqlite3_finalize(statement)
    return (avgRating, noOfRaters)
}
