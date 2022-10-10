//
//  InstructorData.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

import Foundation
import SQLite3

class InstructorData: InstructorDataProtocol {
    
    let sqlite_transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    func createInstructorTable() {
        let query = "CREATE TABLE IF NOT EXISTS instructorData (userId TEXT PRIMARY KEY,name TEXT, dob TEXT, phoneNo TEXT, emailId TEXT, aboutMe TEXT,skillSet TEXT, password TEXT, profilePhoto TEXT);"  //avg INTEGER
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
    
    func insertDataOf(instructor: Instructor) -> Bool {
        var status: Bool
        print("I am at insertion work")
        let query = "INSERT INTO instructorData (userId, name, dob, phoneNo, emailId, aboutMe, skillSet, password, profilePhoto) VALUES ('\(instructor.userId)', '\(instructor.name)', '\(instructor.dob)', '\(instructor.phoneNo)', '\(instructor.emailId)', '\(instructor.aboutMe)', '\(instructor.skillSet)', '\(instructor.password)', '\(instructor.profife)')"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Instructor inserted")
                status = true
            }
            else {
                print("Instructor Event not inserted")
                status = false
            }
        }
        else {
            print("Instructor Event statement not prepared")
            status = false
        }
        sqlite3_finalize(statement)
        return status
    }
    
    func readDataOf(instructorId: String) -> InstructorDataModel? {
        print("Argument value in readData" ,instructorId)
        let query = "SELECT * FROM instructorData WHERE userId = '\(instructorId)';"
        var statement : OpaquePointer?
        var instructorResult: InstructorDataModel?
        if sqlite3_prepare_v2(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let userId = String(cString: sqlite3_column_text(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let dob = String(cString: sqlite3_column_text(statement, 2))
                let phoneNo = String(cString: sqlite3_column_text(statement, 3))
                let emailId = String(cString: sqlite3_column_text(statement, 4))
                let aboutMe = String(cString: sqlite3_column_text(statement, 5))
                let skillset = String(cString: sqlite3_column_text(statement, 6))
                let profilePhote = String(cString: sqlite3_column_text(statement, 8))
                let instructor = Instructor(name: name, dob: dob, phoneNo: phoneNo, emailId: emailId, userId: userId, password: "")
                instructor.skillSet = skillset
                instructor.aboutMe = aboutMe
                instructor.profife = profilePhote
                let instructorProfileData = instructorProfile(instructorId: instructorId)
                let instructorDetails = InstructorDataModel(instructorDetails: instructor, instructorRating: instructorProfileData.avgInstructorRating, noOfRaters: instructorProfileData.noOfRaters, noOfStudents: instructorProfileData.noOfStudents, noOfCourses: instructorProfileData.noOfcourses)
                instructorResult = instructorDetails
            }
        } else {
            print("Statement Not prepared!")
            instructorResult = nil
        }
        sqlite3_finalize(statement)
        return instructorResult
    }
    
    private func instructorProfile(instructorId: String) -> (avgInstructorRating: Float, noOfRaters: Int, noOfStudents: Int, noOfcourses: Int) {
        let query = """
    SELECT
    courseData.courseId
    FROM
    courseData
    where
    courseData.instructorId =  '\(instructorId)'
    """
        var statement : OpaquePointer?
        var totalRating: Int = 0
        var noOfRaters: Int = 0
        var noOfStudents: Int = 0
        var avgInstructorRating: Float = 0
        var noOfCourses: Int = 0
        if sqlite3_prepare_v2(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let courseId = sqlite3_column_int(statement, 0)
                noOfCourses = noOfCourses + 1
                let courseSummary = individualCourseRating(courseId: Int(courseId))
                noOfStudents = noOfStudents + courseSummary.noOfStudents
                totalRating = totalRating + courseSummary.totalRating
                noOfRaters = noOfRaters + courseSummary.noOfRaters
            }
        } else {
            print("Statement Not prepared!")
        }
        
        if noOfRaters > 0 {
            avgInstructorRating =  Float(totalRating / noOfRaters)
            if (avgInstructorRating - Float(Int(avgInstructorRating)) > 0.4) {
                avgInstructorRating = Float(Int(avgInstructorRating)) + 0.5
            } else {
                avgInstructorRating = Float(Int(avgInstructorRating))
            }
        }
        sqlite3_finalize(statement)
        return (avgInstructorRating, noOfRaters, noOfStudents, noOfCourses)
    }
    
    private func individualCourseRating(courseId: Int) -> (totalRating: Int, noOfRaters: Int, noOfStudents: Int) {
        let query = """
    SELECT
    purchaseData.rating
    FROM
    purchaseData
    where
    purchaseData.courseId = \(courseId)
    """
        var statement : OpaquePointer?
        var totalRating: Int = 0
        var noOfRaters: Int = 0
        var noOfStudents: Int = 0
        if sqlite3_prepare_v2(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let rating = sqlite3_column_int(statement, 0)
                if rating == 0 {
                    noOfStudents = noOfStudents + 1
                    continue
                }
                noOfStudents = noOfStudents + 1
                noOfRaters = noOfRaters + 1
                totalRating = totalRating + Int(rating)
                
            }
        } else {
            print("Statement Not prepared!")
        }
        sqlite3_finalize(statement)
        return (totalRating, noOfRaters, noOfStudents)
    }
    
}
