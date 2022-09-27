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
        let query = "CREATE TABLE IF NOT EXISTS courseData (courseId INTEGER PRIMARY KEY, courseName TEXT, categoryId INTEGER, instructorId TEXT, description TEXT, price INTEGER, courseCover TEXT, courseVideo TEXT, FOREIGN KEY (categoryId) REFERENCES categoryData (categoryId), FOREIGN KEY (instructorId) REFERENCES instructorData (userId));"  //avg INTEGER
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(DatabaseHandler.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table creation success")
            }else {
                print("Table creation fail")
            }
        } else {
            print("Prepration fail")
        }
    }
    
    func insertData(course: Course) -> Bool {
        var status: Bool
        print("I am at insertion work")
        let query = "INSERT INTO courseData (courseName, categoryId, instructorId, description, price, courseCover, courseVideo) VALUES ('\(course.courseName)', '\(course.categoryId)', '\(course.instructorId)', '\(course.description)', '\(course.price)', '\(course.courseCover)', '\(course.courseVideo)')"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(DatabaseHandler.db, query, -1, &statement, nil) == SQLITE_OK {
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
    
}
