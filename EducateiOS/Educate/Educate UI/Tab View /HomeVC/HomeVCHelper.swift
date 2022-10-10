//
//  HomeVCHelper.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 28/09/22.
//

import Foundation

class HomeVCHelper: HomeVCHelperProtocol {
    
    var homeVCDelegate: HomeViewControllerDelegate?
    
    func loadCourseDataIn(homeViewController: HomeViewController) {
        var recommendedCourseData: [CourseDataModel] = []
        var businessCourseData: [CourseDataModel] = []
        var developmentCourseData: [CourseDataModel] = []
        var designCourseData: [CourseDataModel] = []
        var engineeringCourseData: [CourseDataModel] = []
        var lifeStyleCourseData: [CourseDataModel] = []
        var othersCourseData: [CourseDataModel] = []
        
        for index in 0...6 {
            let category: Category = Helper.categoryProvider(categoryId: index+1)
            let courseData = DatabaseHandler.dataBaseHandlerInstance.readCourseDatasOf(category: category)
            switch category {
            case .business:
                print("B loaded")
                businessCourseData = courseData
                print("Business course data: \(businessCourseData.count)")
                homeViewController.categoryWiseCourseData.append(businessCourseData)
            case .development:
                print("DE loaded")
                developmentCourseData = courseData
                print("Business course data: \(developmentCourseData.count)")
                homeViewController.categoryWiseCourseData.append(developmentCourseData)
            case .design:
                print("DS loaded")
                designCourseData = courseData
                print("Business course data: \(designCourseData.count)")
                homeViewController.categoryWiseCourseData.append(designCourseData)
            case .engineering:
                print("Eg loaded")
                engineeringCourseData = courseData
                print("Business course data: \(engineeringCourseData.count)")
                homeViewController.categoryWiseCourseData.append(engineeringCourseData)
            case .lifeStyle:
                print("Ly loaded")
                lifeStyleCourseData = courseData
                print("Business course data: \(lifeStyleCourseData.count)")
                homeViewController.categoryWiseCourseData.append(lifeStyleCourseData)
                
            case .others:
                print("Others REc loaded")
                othersCourseData = courseData
                
                recommendedCourseData = courseData        // as per search result
                homeViewController.categoryWiseCourseData.append(othersCourseData)
                homeViewController.categoryWiseCourseData.append(recommendedCourseData)
                print("Business course data: \(othersCourseData.count)")
                print("Business course data: \(recommendedCourseData.count)")
                
            }
        }
    }
}
