//
//  CategoryDataProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import Foundation

protocol CategoryDataProtocol {
    func createCategoryTable()
    func insertData(category: String) -> Bool
}
