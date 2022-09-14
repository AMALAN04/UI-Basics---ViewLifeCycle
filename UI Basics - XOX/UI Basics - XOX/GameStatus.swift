//
//  GameStatus.swift
//  UI Basics - XOX
//
//  Created by amalan-pt5585 on 12/09/22.
//

import Foundation
import UIKit

class GameStatus: GameStatusProtoCol {
    func gameCompleted(cells: [BoxStatus]) -> Bool {
        for cell in cells {
            if cell == .unownedPlace {
                return true
            }
        }
        return false
    }
    
    func checkVictory(cells: [BoxStatus]) -> (winnerTeam: BoxStatus?, possible: WinnerPossibilities?) {
        //horizontal case
        if checkAllAreSame(cells[0],  cells[1], cells[2]) {
            return (cells[0], .horizontalTop)
        }
        if checkAllAreSame(cells[3],  cells[4], cells[5]) {
            return (cells[3], .horizontalMiddle)
        }
        if checkAllAreSame(cells[6],  cells[7], cells[8]) {
            return (cells[6], .horizontalBottom)
        }
        
        //Vertical case
        if checkAllAreSame(cells[0],  cells[3], cells[6]) {
            return (cells[0], .verticalTop)
        }
        if checkAllAreSame(cells[1],  cells[4], cells[7]) {
            return (cells[1], .verticalMiddle)
        }
        if checkAllAreSame(cells[2],  cells[5], cells[8]) {
            return (cells[2], .verticalBottom)
        }
        
        //diagnol case
        if checkAllAreSame(cells[0],  cells[4], cells[8]) {
            return (cells[0], .diagnolBackwardBend)
        }
        if checkAllAreSame(cells[2],  cells[4], cells[6]) {
            return (cells[2], .diagnolForwardBend)
        }
        return (nil, nil)
    }
    
    func checkAllAreSame(_ case1: BoxStatus, _ case2: BoxStatus, _ case3: BoxStatus) -> Bool {
        guard case1 != .unownedPlace else {
            return false
        }
        if case1 == case2  && case1 == case3 {
            return true
        } else {
            return false
        }
    }
}
