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

struct GameSummary {
    var matchWonByX: Int = 0
    var matchWonByY: Int = 0
    var noOfMatchDraw: Int = 0
    var playerFlag: Bool = true
}

enum WinnerPossibilities {
    case horizontalTop
    case horizontalMiddle
    case horizontalBottom
    case verticalTop
    case verticalMiddle
    case verticalBottom
    case diagnolForwardBend
    case diagnolBackwardBend
}

enum MoveAnchor {
    case top
    case leading
}
