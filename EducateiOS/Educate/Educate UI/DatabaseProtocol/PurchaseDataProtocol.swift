//
//  PurchaseDataProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation

protocol PurchaseDataProtocol {
    func createPurchaseDataTable()
    func insertDataOf(purchase: PurchaseTemplate) -> Bool
    func reviewDetails(courseId: Int, userId: String ) -> (myReview: ReviewDataModel?, othersReview: [ReviewDataModel])
    func updateReviewOf(courseId: Int, studentId: String, as review: String, and rating: Int) -> Bool
}
