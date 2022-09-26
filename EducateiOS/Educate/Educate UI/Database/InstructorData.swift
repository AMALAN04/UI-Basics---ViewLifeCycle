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
    
    func createUserTable() {
        let query = "CREATE TABLE IF NOT EXISTS instructorData (userId TEXT PRIMARY KEY,name TEXT, dob TEXT, phoneNo TEXT, emailId TEXT, aboutMe TEXT,skillSet TEXT, password TEXT, profilePhoto TEXT);"  //avg INTEGER
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
    
    func insertData(instructor: Instructor) -> Bool {
        var status: Bool
        print("I am at insertion work")
        let query = "INSERT INTO instructorData (userId, name, dob, phoneNo, emailId, aboutMe, skillSet, password, profilePhoto) VALUES ('\(instructor.userId)', '\(instructor.name)', '\(instructor.dob)', '\(instructor.phoneNo)', '\(instructor.emailId)', '\(instructor.aboutMe)', '\(instructor.skillSet)', '\(instructor.password)', '\(instructor.profife)')"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(DatabaseHandler.db, query, -1, &statement, nil) == SQLITE_OK {
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
    
}
