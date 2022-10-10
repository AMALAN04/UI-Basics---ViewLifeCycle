//
//  HomeVCHelperProtocol.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 30/09/22.
//

import Foundation

protocol HomeVCHelperProtocol {
    var homeVCDelegate: HomeViewControllerDelegate? {get set}
    func loadCourseDataIn(homeViewController: HomeViewController) 
}
