//
//  PurchaseData.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation
import SQLite3

class PurchaseData: PurchaseDataProtocol {

    let sqlite_transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

    func createPurchaseTable() {
        let query = "CREATE TABLE IF NOT EXISTS purchaseData (courseId INTEGER, instructorId TEXT, studentId TEXT, rating INTEGER, favouriteFlag INTEGER, price INTEGER, FOREIGN KEY (courseId) REFERENCES courseData (courseId), FOREIGN KEY (instructorId) REFERENCES instructorData (userId), FOREIGN KEY (studentId) REFERENCES studentData (userId));"  //avg INTEGER
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

    func insertData(purchase: PurchaseTemplate) -> Bool {
        var status: Bool
        print("I am at insertion work")
        let query = "INSERT INTO purchaseData (courseId, instructorId, studentId, rating, favouriteFlag, price) VALUES ('\(purchase.courseId)', '\(purchase.instructorId)', '\(purchase.studentId)', '\(purchase.rating)', '\(purchase.favouriteFlag)', '\(purchase.price)')"
        var statement: OpaquePointer?
        if sqlite3_prepare(DatabaseHandler.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("purchase inserted")
                status = true
            }
            else {
                print("purchase not inserted")
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
