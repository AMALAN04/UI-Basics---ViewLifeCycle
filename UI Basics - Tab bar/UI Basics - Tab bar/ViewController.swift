//
//  ViewController.swift
//  UI Basics - Tab bar
//
//  Created by amalan-pt5585 on 29/08/22.
//

import UIKit

//class ViewController: UIViewController {
//    let button: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .systemBlue
//        button.setTitle("Tool Bar", for: .normal)
//        button.layer.cornerRadius = 25
//        button.addTarget(nil, action: #selector(buttonPressed), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Home"
//        view.backgroundColor = .gray
//        layout()
//        // Do any additional setup after loading the view.
//    }
//
//
//}
//
//extension ViewController {
//    func layout() {
//        view.addSubview(button)
//
//        let constraints = [
//            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            button.widthAnchor.constraint(equalToConstant: 120),
//            button.heightAnchor.constraint(equalToConstant: 40)
//        ]
//        NSLayoutConstraint.activate(constraints)
//
//    }
//
//    @objc func buttonPressed(){
//        let tabBar = TabBarController()
////        let vc1 = UINavigationController(rootViewController: FirstViewController())
////        let vc2 =  UINavigationController(rootViewController: secondViewController())
////        vc1.title = "Purple"
////        vc2.title = "Mint"
////        let images = tabBar.tabBar.items
////        tabBar.tabBar.items![0].image = UIImage(systemName: "house")!
////        tabBar.setViewControllers([vc1,vc2], animated: false)
//        let vc1 = UINavigationController(rootViewController: FirstViewController())
//        let vc2 =  UINavigationController(rootViewController: secondViewController())
//
//        guard let items = tabBar.tabBar.items else {return}
//        let images = ["house", "star"]
//        var index = 0
//        for item in items {
//            item.image = UIImage(systemName: images[index])
//            index += index + 1
//        }
//        vc1.title = "Purple"
//        vc2.title = "Mint"
//        tabBar.setViewControllers([vc1,vc2], animated: false)
//        tabBar.modalPresentationStyle = .fullScreen
//        present(tabBar, animated: true)
//    }
//}
//
//

class ViewController: UIViewController {
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Tool Bar", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(nil, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        view.backgroundColor = .gray
        layout()
    }
}

extension ViewController {
    func layout() {
        view.addSubview(button)

        let constraints = [
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func buttonPressed() {
        let rootView = TabBarController()
        navigationController?.pushViewController(rootView, animated: true)
    }
}
