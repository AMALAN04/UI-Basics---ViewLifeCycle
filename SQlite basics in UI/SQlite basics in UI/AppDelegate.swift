//
//  AppDelegate.swift
//  SQlite basics in UI
//
//  Created by amalan-pt5585 on 16/09/22.
//

import UIKit
import SQLite3

var dbUrl = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
var dbPointer: OpaquePointer?
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        Override point for customization after application launch.
        dbPointer = createAndOpenDatabase()
        if createTable() {
            print("Table is created")
        } else {
            print("Table is not created something went wrong")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func createAndOpenDatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        let url = NSURL(fileURLWithPath: dbUrl) //converting string as url
        //folder name "Test.sqlite"
        if let pathComponent = url.appendingPathComponent( "Test.sqlite") {
            let filepath = pathComponent.path
            if sqlite3_open(filepath, &db) == SQLITE_OK {
                print("Successfully opened connection to database at \(filepath)")
                return db
            } else {
                print("Unable to open database.")
            }
        } else {
            print("path not available")
        }
        return db
    }
    
    func createTable() -> Bool {
        var tableStatus: Bool = false
        let createTable = sqlite3_exec(dbPointer, "CREATE TABLE IF NOT EXISTS TEMP (TEMPCOLUMN1 TEXT NULL, TEMPCOLUMN2 TEXT NULL)", nil, nil, nil)
        if createTable != SQLITE_OK {
            print("unable to create table")
            tableStatus = false
        } else {
            tableStatus = true
        }
        return tableStatus
    }
}

