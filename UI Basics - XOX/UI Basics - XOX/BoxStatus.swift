//
//  File.swift
//  UI Basics - XOX
//
//  Created by amalan-pt5585 on 09/09/22.
//

import Foundation
enum BoxStatus: Int, CaseIterable {
    case unownedPlace = 0
    case playerX
    case playerO
}

struct gameSummary {
    var matchWonByX: Int = 0
    var matchWonByY: Int = 0
    var noOfMatchDraw: Int = 0
    var playerFlag: Bool = true
}
