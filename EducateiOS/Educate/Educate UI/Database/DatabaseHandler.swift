//
//  DatabaseHandler.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 21/09/22.
//

import UIKit
import SQLite3

class DatabaseHandler: DbHandlerProtocol {
    
    static var db : OpaquePointer?
    var path : String = "EducateDataBase.sqlite"
    init() {
        DatabaseHandler.db = createDB()
        
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
            return nil
        }else {
            print("Database has been created with path \(filePath)")
            return db
        }
    }
    
    func createTables() {
        InstanceProvider.studentData.createUserTable()
        InstanceProvider.instructorData.createUserTable()
        InstanceProvider.categoryData.createCategoryTable()
        InstanceProvider.courseData.createCourseTable()
        InstanceProvider.purchaseData.createPurchaseTable()
    }
    
    func loadData() {
        loadStudentData()
        loadInstructorData()
        loadCategoryDate()
        loadCourseDate()
        loadPurchaseData()
    }
    
    private func loadStudentData() {
        let rajesh = Student(name: "Rajesh", dob: "11.10.2022", phoneNo: "9445567156", emailId: "rj@gmail.com", userId: "rj", password: "1124")
        let ravi = Student(name: "Ravi", dob: "11.10.2022", phoneNo: "9445567156", emailId: "rj@gmail.com", userId: "ravi", password: "1124")
        let demo = Student(name: "Demo", dob: "11.10.2022", phoneNo: "9445567156", emailId: "demo@gmail.com", userId: "demo", password: "1124")
        print("rajesh loaded: \(InstanceProvider.studentData.insertData(student: rajesh))")
        print("rajesh loaded: \(InstanceProvider.studentData.insertData(student: ravi))")
        print("demo loaded: \(InstanceProvider.studentData.insertData(student: demo))")
    }
    
    private func loadInstructorData() {
        let  model1 = Instructor(name: "Krish", dob: "11.10.2022", phoneNo: "9445567156", emailId: "rj@gmail.com", userId: "krish", password: "1124")
        let  model2 = Instructor(name: "Allen", dob: "11.10.2022", phoneNo: "9445567156", emailId: "rj@gmail.com", userId: "AA", password: "1124")
        let  model3 = Instructor(name: "Steve", dob: "11.10.2022", phoneNo: "9445567156", emailId: "rj@gmail.com", userId: "steve", password: "1124")
        print("krish loaded: \(InstanceProvider.instructorData.insertData(instructor: model1))")
        print("Allen loaded: \(InstanceProvider.instructorData.insertData(instructor: model2))")
        print("steve loaded: \(InstanceProvider.instructorData.insertData(instructor: model3))")
    }
    
    private func loadCategoryDate() {
        let categories = ["Business", "Development", "Design", "Engineering", "LifeStyle", "Others"]
        for category in categories {
            print("krish loaded: \(InstanceProvider.categoryData.insertData(category: category))")
        }
        
    }
    
    private func loadCourseDate() {
        var categoryId = 1
        let description = "Volunteerism not only benefits a community, it can broaden the worldview of the volunteer. Students who give their time and energy to a particular cause, gain an opportunity to reflect on the value of the volunteer in contemporary society. Through research and discussion, students consider different types of volunteer settings, trace the history of volunteer organizations, examine the various roles volunteers play within society, and reflect on ethical issues."
        for index in 1...50 {
            categoryId = (index % 6) + 1
            let course = Course(courseId: 1, coutseName: "Java \(index)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 100)
            print("courses loaded: \(InstanceProvider.courseData.insertData(course: course))")
        }
    }
    
    private func loadPurchaseData() {
        let purchase = PurchaseTemplate(courseId: 1, instructorId: "AA", studentId: "demo", price: 100)
        print("purchase loaded: \(InstanceProvider.purchaseData.insertData(purchase: purchase))")
    }
    
}

