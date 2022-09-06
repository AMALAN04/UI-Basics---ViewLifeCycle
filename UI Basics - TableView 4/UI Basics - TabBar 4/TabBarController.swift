//
//  TabBarController.swift
//  UI Basics - TabBar 4
//
//  Created by amalan-pt5585 on 05/09/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Table View"
        configureNavBar() // not working ?
       
        view.backgroundColor = .green
        let vc2 =  UINavigationController(rootViewController: AdvancedViewController())
        let vc1 = UINavigationController(rootViewController: BasicViewController())
        setViewControllers([vc1,vc2], animated: false)
        vc1.title = "Star"
        vc2.title = "home"
        guard let items = self.tabBar.items else {return}
            items[0].image = UIImage(systemName: "star")
            items[1].image = UIImage(systemName: "house")
        
        self.selectedIndex = 0
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.gray // your colour here

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }


}
