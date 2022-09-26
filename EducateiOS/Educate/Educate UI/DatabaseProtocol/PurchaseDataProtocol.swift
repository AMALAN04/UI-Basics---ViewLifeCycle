//
//  PurchaseDataProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation

protocol PurchaseDataProtocol {
    func createPurchaseTable()
    func insertData(purchase: PurchaseTemplate) -> Bool
}
