//
//  tabBarController.swift
//  UI Basics - Tab bar
//
//  Created by amalan-pt5585 on 29/08/22.
//

import UIKit

class TabBarController: UITabBarController {
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        let vc2 =  UINavigationController(rootViewController: secondViewController())
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        
        vc1.title = "Purple"
        vc2.title = "Mint"
        setViewControllers([vc1,vc2], animated: false)
                guard let items = self.tabBar.items else {return}
                let images = ["house", "star"]
                var index = 0
                for item in items {
                    item.image = UIImage(systemName: images[index])
                    index += index + 1
                }
        self.selectedIndex = 1
    }
    
}
