//
//  MainTabBarController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .systemBackground
        
        let homeVc = UINavigationController(rootViewController: HomeViewController())
        let categoryVc = UINavigationController(rootViewController: SearchViewController())
        let myLearningVc = UINavigationController(rootViewController: MyLearningViewController())
        let wishlistVc = UINavigationController(rootViewController: WishListViewController())
        let profileVc = UINavigationController(rootViewController: ProfileViewController())
        
        
        homeVc.title = "Home"
        categoryVc.title = "Search"
        myLearningVc.title = "My learning"
        wishlistVc.title = "Wishlist"
        profileVc.title = "Profile"
        
        setViewControllers([homeVc, categoryVc, myLearningVc, wishlistVc, profileVc], animated: false)
                guard let items = self.tabBar.items else {return}
                let images = ["house.fill", "magnifyingglass", "play.fill", "heart.fill", "person.fill"]
                var index = 0
                for item in items {
                    item.image = UIImage(systemName: images[index])
                    index += 1
                }
        self.selectedIndex = 0

//        tabBarController?.addSubviewToLastTabItem(UIImage(named: "educateLogo.png")!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(true)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    
 
}
