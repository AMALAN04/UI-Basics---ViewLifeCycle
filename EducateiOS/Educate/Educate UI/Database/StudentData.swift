//
//  StudentData.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 21/09/22.
//

import Foundation
import SQLite3

class StudentData: StudentDataProtocol {
    
    let sqlite_transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    func createUserTable() {
        let query = "CREATE TABLE IF NOT EXISTS studentData (userId TEXT PRIMARY KEY,name TEXT, dob TEXT, phoneNo TEXT, emailId TEXT, skillSet TEXT, password TEXT, profilePhoto TEXT);"  //avg INTEGER
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
    
    func insertData(student: Student) -> Bool {
        var status: Bool
        print("I am at insertion work")
        let query = "INSERT INTO studentData (userId, name, dob, phoneNo, emailId, skillSet, password, profilePhoto) VALUES ('\(student.userId)', '\(student.name)', '\(student.dob)', '\(student.phoneNo)', '\(student.emailId)', '\(student.skillSet)', '\(student.password)', '\(student.profife)')"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(DatabaseHandler.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Event inserted")
                status = true
            }
            else {
                print("Event not inserted")
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
    
    func readDataOf(studentId: String) -> Student? {
        print("Argument value in readData" ,studentId)
        let query = "SELECT * FROM studentData WHERE userId = '\(studentId)';"
        var statement : OpaquePointer?
        var studentResult: Student?
        if sqlite3_prepare_v2(DatabaseHandler.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let userId = String(cString: sqlite3_column_text(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let dob = String(cString: sqlite3_column_text(statement, 2))
                let phoneNo = String(cString: sqlite3_column_text(statement, 3))
                let emailId = String(cString: sqlite3_column_text(statement, 4))
                let password = String(cString: sqlite3_column_text(statement, 6))
                let student = Student(name: name, dob: dob, phoneNo: phoneNo, emailId: emailId, userId: userId, password: password)
                student.skillSet = String(cString: sqlite3_column_text(statement, 5))
                student.profife = String(cString: sqlite3_column_text(statement, 7))
                studentResult = student
                
            }
        } else {
            print("Statement Not prepared!")
            studentResult = nil
        }
        sqlite3_finalize(statement)
        return studentResult
    }
    
    
}
