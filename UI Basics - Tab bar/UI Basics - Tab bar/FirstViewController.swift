//
//  FirstViewController.swift
//  UI Basics - Tab bar
//
//  Created by amalan-pt5585 on 29/08/22.
//

import UIKit

class FirstViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Purple"
        view.backgroundColor = .purple
    }
    
}

class secondViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mint"
        view.backgroundColor = .systemMint
    }
    
}
