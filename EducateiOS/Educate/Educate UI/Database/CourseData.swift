//
//  CourseData.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation
import SQLite3

class CourseData: CourseDataProtocol {
    
    let sqlite_transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    func createCourseTable() {
        let query = "CREATE TABLE IF NOT EXISTS courseData (courseId INTEGER PRIMARY KEY, courseName TEXT, categoryId INTEGER, instructorId TEXT, description TEXT, price INTEGER, courseOutlook TEXT, whatYouLearn TEXT, prerequisite TEXT, courseCover TEXT, courseVideo TEXT, FOREIGN KEY (categoryId) REFERENCES categoryData (categoryId), FOREIGN KEY (instructorId) REFERENCES instructorData (userId));"  //avg INTEGER
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table creation success")
            }else {
                print("Table creation fail")
            }
        } else {
            print("Prepration fail")
        }
    }
    
    func insertDataOf(course: Course) -> Bool {
        var status: Bool
        print("I am at insertion work")
        let query = "INSERT INTO courseData (courseName, categoryId, instructorId, description, price, courseOutlook, whatYouLearn, prerequisite, courseCover, courseVideo) VALUES ('\(course.courseName)', '\(course.categoryId)', '\(course.instructorId)', '\(course.description)', '\(course.price)', '\(course.courseOutlook)', '\(course.whatYouLearn)', '\(course.prerequisite)', '\(course.courseCover)', '\(course.courseVideo)')"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("course inserted")
                status = true
            }
            else {
                print("course not inserted")
                status = false
            }
        }
        else {
            print("Event statement not prepared")
            status = false
        }
        sqlite3_finalize(statement)
        return status
    }
    
    func readCourseDatasOf(category: Category) -> [CourseDataModel] {
        let categoryId = category.rawValue
        let query = """
SELECT
courseId, courseName, categoryId, instructorId, description, price, courseCover, courseVideo,  instructorData.name as instructorName,courseOutlook, whatYouLearn, prerequisite
FROM
courseData
INNER JOIN instructorData ON instructorData.userId = courseData.instructorId
where
courseData.categoryId = \(categoryId)
"""
        var statement : OpaquePointer?
        var overAllCourseDetails: [CourseDataModel] = []
        if sqlite3_prepare_v2(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
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
                let courseOutlook = String(cString: sqlite3_column_text(statement, 9))
                let whatYouLearn = String(cString: sqlite3_column_text(statement, 10))
                let prerequisite = String(cString: sqlite3_column_text(statement, 11))
                let course = Course(courseId: Int(courseId), coutseName: courseName, categoryId: Int(categoryId), instructorId: instructorId, description: description, price: Int(price))
                course.courseCover = courseCover
                course.courseVideo = courseVideo
                course.courseOutlook = courseOutlook
                course.whatYouLearn = whatYouLearn
                course.prerequisite = prerequisite
                let ratingDetails = purchaseDetails(courseId: Int(courseId))
                let courseData = CourseDataModel(courseDetails: course, instructorName: instructorName, rating: ratingDetails.avgRating, noOfRaters: ratingDetails.noOfRaters, noOfStudents: ratingDetails.noOfStudents, purchasedStatus: ratingDetails.purchaseStatus)
                overAllCourseDetails.append(courseData)
            }
        } else {
            print("Statement Not prepared!")
        }
        sqlite3_finalize(statement)
        return overAllCourseDetails
    }
    
    func readCourseDatasOfInstructor(id: String) -> [CourseDataModel] {
        let query = """
SELECT
courseId, courseName, categoryId, instructorId, description, price, courseCover, courseVideo,  instructorData.name as instructorName,courseOutlook, whatYouLearn, prerequisite
FROM
courseData
INNER JOIN instructorData ON instructorData.userId = courseData.instructorId
where
courseData.instructorId = '\(id)'
"""
        var statement : OpaquePointer?
        var overAllCourseDetails: [CourseDataModel] = []
        if sqlite3_prepare_v2(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
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
                let courseOutlook = String(cString: sqlite3_column_text(statement, 9))
                let whatYouLearn = String(cString: sqlite3_column_text(statement, 10))
                let prerequisite = String(cString: sqlite3_column_text(statement, 11))
                let course = Course(courseId: Int(courseId), coutseName: courseName, categoryId: Int(categoryId), instructorId: instructorId, description: description, price: Int(price))
                course.courseCover = courseCover
                course.courseVideo = courseVideo
                course.courseOutlook = courseOutlook
                course.whatYouLearn = whatYouLearn
                course.prerequisite = prerequisite
                let ratingDetails = purchaseDetails(courseId: Int(courseId))
                let courseData = CourseDataModel(courseDetails: course, instructorName: instructorName, rating: ratingDetails.avgRating, noOfRaters: ratingDetails.noOfRaters, noOfStudents: ratingDetails.noOfStudents, purchasedStatus: ratingDetails.purchaseStatus)
                overAllCourseDetails.append(courseData)
            }
        } else {
            print("Statement Not prepared!")
        }
        sqlite3_finalize(statement)
        return overAllCourseDetails
    }
    
    private func purchaseDetails(courseId: Int) -> (avgRating: Float, noOfRaters: Int, noOfStudents: Int, purchaseStatus: Bool) {
        let query = """
    SELECT
    purchaseData.rating, purchaseData.studentId
    FROM
    purchaseData
    where purchaseData.courseId = \(courseId);
    """
        var statement : OpaquePointer?
        var totalRating: Int = 0
        var noOfRaters: Int = 0
        var noOfStudents: Int = 0
        var avgRating: Float = 0
        var purchasedStatus: Bool = false
        if sqlite3_prepare_v2(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let rating = sqlite3_column_int(statement, 0)
                let studentId = String(cString: sqlite3_column_text(statement, 1))
                if studentId == LoginVCHelper.userId {
                    purchasedStatus = true
                }
                if rating == 0 {
                    noOfStudents = noOfStudents + 1
                    continue
                }
                noOfStudents = noOfStudents + 1
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
        return (avgRating, noOfRaters, noOfStudents, purchasedStatus)
    }
}
