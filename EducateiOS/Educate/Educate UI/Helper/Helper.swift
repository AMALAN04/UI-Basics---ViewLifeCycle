//
//  staticData.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 26/09/22.
//

import Foundation

class Helper {
    static let sectionHeaders: [String] = ["Recommended", "Business", "Development", "Design", "Engineering", "Life Style", "Others"]
    
    static func categoryProvider(categoryId: Int) -> Category {
        switch categoryId {
        case 1:
            return .business
        case 2:
            return .development
        case 3:
            return .design
        case 4:
            return .engineering
        case 5:
            return .lifeStyle
        case 6:
            return .others
        default:
            return .others             //result as per search has to be implemented
        }
    }
    
    static func pluralsProvider<T: Comparable>(for word: String, has quantity: T, _ base: T) -> String {
        if quantity > base {
            return "\(word)s"
        } else {
            return "\(word)"
        }
    }
     
}
