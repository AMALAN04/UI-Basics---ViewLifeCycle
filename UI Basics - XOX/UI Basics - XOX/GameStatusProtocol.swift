//
//  GameStatusProtocol.swift
//  UI Basics - XOX
//
//  Created by amalan-pt5585 on 12/09/22.
//

import Foundation
import UIKit
 
protocol GameStatusProtoCol {
    func gameCompleted(cells: [BoxStatus]) -> Bool
    func checkVictory(cells: [BoxStatus]) -> BoxStatus? 
}
