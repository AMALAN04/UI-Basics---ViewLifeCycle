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
                businessCourseData = courseData
                homeViewController.categoryWiseCourseData.append(businessCourseData)
            case .development:
                developmentCourseData = courseData
                homeViewController.categoryWiseCourseData.append(developmentCourseData)
            case .design:
                designCourseData = courseData
                homeViewController.categoryWiseCourseData.append(designCourseData)
            case .engineering:
                engineeringCourseData = courseData
                homeViewController.categoryWiseCourseData.append(engineeringCourseData)
            case .lifeStyle:
                lifeStyleCourseData = courseData
                homeViewController.categoryWiseCourseData.append(lifeStyleCourseData)
                
            case .others:
                othersCourseData = courseData
                recommendedCourseData = courseData        // as per search result
                homeViewController.categoryWiseCourseData.append(othersCourseData)
                homeViewController.categoryWiseCourseData.append(recommendedCourseData)
                
            }
        }
    }
}
