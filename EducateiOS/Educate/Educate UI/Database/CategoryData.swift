//
//  CategoryData.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

import Foundation
import SQLite3

class CategoryData: CategoryDataProtocol {
    
    let sqlite_transient = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    func createCategoryTable() {
        let query = "CREATE TABLE IF NOT EXISTS categoryData (categoryId INTEGER PRIMARY KEY AUTOINCREMENT,categoryName TEXT);"  //avg INTEGER
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
    
    func insertDataOf(category: String) -> Bool {
        var status: Bool
        print("I am at insertion work")
        let query = "INSERT INTO categoryData (categoryName) VALUES ('\(category)')"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(DatabaseHandler.dataBaseHandlerInstance.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("category inserted")
                status = true
            }
            else {
                print("category not inserted")
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
