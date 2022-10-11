//
//  DatabaseHandler.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 21/09/22.
//

import UIKit
import SQLite3

class DatabaseHandler: DbHandlerProtocol {
    
    static var dataBaseHandlerInstance = DatabaseHandler()
    var db : OpaquePointer?
    private var studentData: StudentData
    private var instructorData: InstructorData
    private var categoryData: CategoryData
    private var courseData: CourseData
    private var purchaseData: PurchaseData
    
    private init() {
        studentData = StudentData()
        instructorData = InstructorData()
        categoryData = CategoryData()
        courseData = CourseData()
        purchaseData = PurchaseData()
    }
    

    
    func createTables() {
        studentData.createStudentTable()
        instructorData.createInstructorTable()
        categoryData.createCategoryTable()
        courseData.createCourseTable()
        purchaseData.createPurchaseDataTable()
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
        print("rajesh loaded: \(studentData.insertDataOf(student: rajesh))")
        print("rajesh loaded: \(studentData.insertDataOf(student: ravi))")
        print("demo loaded: \(studentData.insertDataOf(student: demo))")
    }
    
    private func loadInstructorData() {
        let  model1 = Instructor(name: "Krish", dob: "11.10.2022", phoneNo: "9445567156", emailId: "rj@gmail.com", userId: "krish", password: "1124")
        let  model2 = Instructor(name: "Allen", dob: "11.10.2022", phoneNo: "9445567156", emailId: "rj@gmail.com", userId: "AA", password: "1124")
        let  model3 = Instructor(name: "Steve", dob: "11.10.2022", phoneNo: "9445567156", emailId: "rj@gmail.com", userId: "steve", password: "1124")
        print("krish loaded: \(instructorData.insertDataOf(instructor: model1))")
        print("Allen loaded: \(instructorData.insertDataOf(instructor: model2))")
        print("steve loaded: \(instructorData.insertDataOf(instructor: model3))")
    }
    
    private func loadCategoryDate() {
        let categories = ["Business", "Development", "Design", "Engineering", "LifeStyle", "Others"]
        for category in categories {
            print("krish loaded: \(categoryData.insertDataOf(category: category))")
        }
    }
    
    private func loadCourseDate() {
        var categoryId = 1
        let description = "Volunteerism not only benefits a community, it can broaden the worldview of the volunteer. Students who give their time and energy to a particular cause, gain an opportunity to reflect on the value of the volunteer in contemporary society. Through research and discussion, students consider different types of volunteer settings, trace the history of volunteer organizations, examine the various roles volunteers play within society, and reflect on ethical issues."
            for index in 0...50 {
                categoryId = ((index) % 6) + 1
                let course1 = Course(courseId: 1, coutseName: "Learn Python: The Complete Python Programming Course \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 649)
                course1.courseCover = "https://www.trio.dev/hubfs/Imported_Blog_Media/python_logo.jpg"
                print("courses loaded: \(courseData.insertDataOf(course: course1))")
                let course2 = Course(courseId: 1, coutseName: "The Complete 2022 Web Development Bootcamp\(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 1400)
                course2.courseCover = "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20200203200336/13-Things-You-Should-Know-Before-You-Enter-In-Web-Development.png"
                print("courses loaded: \(courseData.insertDataOf(course: course2))")
                let course3 = Course(courseId: 1, coutseName: "Ultimate AWS Certified Solutions Architect Associate SAA-C03 \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 1000)
                course3.courseCover = "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_aws.jpg"
                print("courses loaded: \(courseData.insertDataOf(course: course3))")
                let course4 = Course(courseId: 1, coutseName: "The Complete Financial Analyst Course 2022 \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 1100)
                course4.courseCover = "https://cloudinary.hbs.edu/hbsit/image/upload/s--wx5D2ABw--/f_auto,c_fill,h_375,w_750,/v20200101/5393409F6FB391494111C5EC16653C89.jpg"
                print("courses loaded: \(courseData.insertDataOf(course: course4))")
                let course6 = Course(courseId: 1, coutseName: "Java \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 100)
                print("courses loaded: \(courseData.insertDataOf(course: course6))")
                let course5 = Course(courseId: 1, coutseName: "Forex Trading: Your Complete Guide to Get Started Like a Pro \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 100)
                course5.courseCover = "https://d3tl80hy6t5toy.cloudfront.net/wp-content/uploads/sites/3/2018/07/07134308/2018-07-09-WhatExpectEarnFinanceDegree-ThinkstockPhotos-494940062.jpg"
                print("courses loaded: \(courseData.insertDataOf(course: course5))")
                let course7 = Course(courseId: 1, coutseName: " \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 700)
                course7.courseCover = "https://w10.naukri.com/mailers/2022/naukri-learning/what-is/What-is-Finance.jpg"
                print("courses loaded: \(courseData.insertDataOf(course: course7))")
                let course8 = Course(courseId: 1, coutseName: "Java is up to extent \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 100)
                print("courses loaded: \(courseData.insertDataOf(course: course8))")
                course8.courseCover = "https://www.oracle.com/img/tech/cb88-java-logo-001.jpg"
                let course9 = Course(courseId: 1, coutseName: "Photoshop Master Course: From Beginner to Photoshop Pro \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 400)
                course9.courseCover = "https://fixthephoto.com/blog/UserFiles/Image/img/free-photoshop-interface.png"
                print("courses loaded: \(courseData.insertDataOf(course: course9))")
                let course10 = Course(courseId: 1, coutseName: "Painting Environments \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 500)
                course10.courseCover = "https://shotkit.com/wp-content/uploads/2020/08/photoshop-history.jpg"
                print("courses loaded: \(courseData.insertDataOf(course: course10))")
                let course11 = Course(courseId: 1, coutseName: "Machine Learning Courses \(categoryId)", categoryId: categoryId, instructorId: "krish", description: "\(description)", price: 100)
                course11.courseCover = "https://hackr.io/blog/machine-learning-courses/thumbnail/large"
                print("courses loaded: \(courseData.insertDataOf(course: course11))")
            }
    }
    
    private func loadPurchaseData() {
        var purchase1 = PurchaseTemplate(courseId: 1, instructorId: "krish", studentId: "demo", price: 100, date: Date().shortDateTime)
        purchase1.rating = 4
        purchase1.comment = "Good and intresting"
        var purchase2 = PurchaseTemplate(courseId: 2, instructorId: "krish", studentId: "ravi", price: 100, date: Date().shortDateTime)
        purchase2.rating = 5
        purchase2.comment = "Very Good, cost worthy"
        var purchase3 = PurchaseTemplate(courseId: 3, instructorId: "krish", studentId: "ravi", price: 100, date: Date().shortDateTime)
        purchase3.rating = 3
        purchase3.comment = "Need to be improved"
        var purchase4 = PurchaseTemplate(courseId: 4, instructorId: "krish", studentId: "demo", price: 100, date: Date().shortDateTime)
        purchase4.rating = 4
        
        var purchase5 = PurchaseTemplate(courseId: 1, instructorId: "krish", studentId: "ravi", price: 100, date: Date().shortDateTime)
        purchase5.rating = 2
        purchase5.comment = "Need to be improved"
        
        var purchase6 = PurchaseTemplate(courseId: 5, instructorId: "krish", studentId: "demo", price: 100, date: Date().shortDateTime)
        var purchase7 = PurchaseTemplate(courseId: 5, instructorId: "krish", studentId: "ravi", price: 100, date: Date().shortDateTime)
        purchase7.rating = 2
        purchase7.comment = "Need to be improved"
        print("purchase loaded: \(purchaseData.insertDataOf(purchase: purchase1))")
        print("purchase loaded: \(purchaseData.insertDataOf(purchase: purchase2))")
        print("purchase loaded: \(purchaseData.insertDataOf(purchase: purchase3))")
        print("purchase loaded: \(purchaseData.insertDataOf(purchase: purchase4))")
        print("purchase loaded: \(purchaseData.insertDataOf(purchase: purchase5))")
        print("purchase loaded: \(purchaseData.insertDataOf(purchase: purchase6))")
        print("purchase loaded: \(purchaseData.insertDataOf(purchase: purchase7))")
    }
    
    
    func  createStudentTable() {
        studentData.createStudentTable()
    }
    
    func insertDataOf(student: Student) -> Bool {
        return studentData.insertDataOf(student: student)
    }
    
    func readDataOf(studentId: String) -> Student? {
        return studentData.readDataOf(studentId: studentId)
    }
    
    func createInstructorTable() {
        instructorData.createInstructorTable()
    }
    
    func insertDataOf(instructor: Instructor) -> Bool {
        return instructorData.insertDataOf(instructor: instructor)
    }
    
    func readDataOf(instructorId: String) -> InstructorDataModel? {
        return instructorData.readDataOf(instructorId: instructorId)
    }
    
    func createCategoryTable() {
        categoryData.createCategoryTable()
    }
    
    func insertDataOf(category: String) -> Bool {
       return categoryData.insertDataOf(category: category)
    }
    
    func createCourseTable() {
        courseData.createCourseTable()
    }
    
    func insertDataOf(course: Course) -> Bool {
        return courseData.insertDataOf(course: course)
    }
    
    func readCourseDatasOf(category: Category) -> [CourseDataModel]  {
       return courseData.readCourseDatasOf(category: category)
    }
    
    func readCourseDatasOfInstructor(id: String) -> [CourseDataModel] {
        return courseData.readCourseDatasOfInstructor(id: id)
    }
    
    func readCourseDataOf(courseId: Int) -> CourseDataModel? {
        return courseData.readCourseDataOf(courseId: courseId)
    }
    
    func createPurchaseDataTable() {
        purchaseData.createPurchaseDataTable()
    }
    
    func insertDataOf(purchase: PurchaseTemplate) -> Bool {
        return purchaseData.insertDataOf(purchase: purchase)
    }
    
    func updateReviewOf(courseId: Int, studentId: String, as review: String, and rating: Int) -> Bool {
        return purchaseData.updateReviewOf(courseId: courseId, studentId: studentId, as: review, and: rating)
    }
    
    func reviewDetails(courseId: Int, userId: String ) -> (myReview: ReviewDataModel?, othersReview: [ReviewDataModel]) {
        return purchaseData.reviewDetails(courseId: courseId, userId: userId)
    }
    
}

