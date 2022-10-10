//
//  CourseListVCHelper.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 02/10/22.
//

import Foundation

class CourseListVCHelper: CourseListVCHelperProtocol {
    func applyFilter(filter: Filters, in courseData: [CourseDataModel]) -> [CourseDataModel] {
        switch filter {
        case .priceLowToHigh:
            return courseData.sorted(by:{$0.courseDetails.price < $1.courseDetails.price})
        case .priceHighToLow:
            return courseData.sorted(by:{$0.courseDetails.price > $1.courseDetails.price})
        case .rating:
            return courseData.sorted(by:{$0.rating > $1.rating})
        case .popurarity:
            return courseData.sorted(by:{$0.noOfRaters > $1.noOfRaters})
        case ._default:
            return courseData
        }
        
    }
}
