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
    
    func createPurchaseDataTable() {
        let query = "CREATE TABLE IF NOT EXISTS purchaseData (courseId INTEGER, instructorId TEXT, studentId TEXT, rating INTEGER, comment TEXT, favouriteFlag INTEGER, price INTEGER, date TEXT, FOREIGN KEY (courseId) REFERENCES courseData (courseId), FOREIGN KEY (instructorId) REFERENCES instructorData (userId), FOREIGN KEY (studentId) REFERENCES studentData (userId));"  //avg INTEGER
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
    
    func insertDataOf(purchase: PurchaseTemplate) -> Bool {
        var status: Bool
        print("I am at insertion work")
        let query = "INSERT INTO purchaseData (courseId, instructorId, studentId, rating, comment,  favouriteFlag, price, date) VALUES ('\(purchase.courseId)', '\(purchase.instructorId)', '\(purchase.studentId)', '\(purchase.rating)', '\(purchase.comment)', '\(purchase.favouriteFlag)', '\(purchase.price)', '\(purchase.date)')"
        var statement: OpaquePointer?
        if sqlite3_prepare(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
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
    
    func reviewDetails(courseId: Int, userId: String ) -> (myReview: ReviewDataModel?, othersReview: [ReviewDataModel]) {
        let query = """
    SELECT
    studentData.userId, studentData.profilePhoto, studentData.name,
    purchaseData.rating, purchaseData.comment, purchaseData.date
    FROM
    purchaseData
    INNER JOIN studentData ON studentData.userId = purchaseData.studentId
    where
    purchaseData.courseId = \(courseId)
    """
        var statement : OpaquePointer?
        var myReview: ReviewDataModel?
        var othersReview: [ReviewDataModel] = []
        if sqlite3_prepare_v2(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let studentId = String(cString: sqlite3_column_text(statement, 0))
                let profilePhoto = String(cString: sqlite3_column_text(statement, 1))
                let name = String(cString: sqlite3_column_text(statement, 2))
                let rating = sqlite3_column_int(statement, 3)
                let comment = String(cString: sqlite3_column_text(statement, 4))
                let date = String(cString: sqlite3_column_text(statement, 5))
                
                if studentId == userId {
                    let review = ReviewDataModel(userProfile: profilePhoto, userName: name, userId: studentId, userRating: Int(rating), date: date, comment: comment)
                    myReview = review
                } else {
                    if comment.isEmpty {
                        continue
                    } else {
                        let review = ReviewDataModel(userProfile: profilePhoto, userName: name, userId: studentId, userRating: Int(rating), date: date, comment: comment)
                        othersReview.append(review)
                    }
                }
            }
        } else {
            print("Statement Not prepared!")
        }
        sqlite3_finalize(statement)
        return (myReview, othersReview)
    }
    

}
