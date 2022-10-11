//
//  ReviewVCHelper.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 07/10/22.
//

import Foundation

class ReviewVCHelper {
    
    func reviewDetails(courseId: Int, userId: String ) -> (myReview: ReviewDataModel?, othersReview: [ReviewDataModel]) {
       return DatabaseHandler.dataBaseHandlerInstance.reviewDetails(courseId: courseId, userId: userId)
    }
    
    func updateReviewOf(courseId: Int, userId: String, as review: String, and rating: Int) -> Bool {
        return DatabaseHandler.dataBaseHandlerInstance.updateReviewOf(courseId: courseId, studentId: userId, as: review, and: rating)
    }
}
