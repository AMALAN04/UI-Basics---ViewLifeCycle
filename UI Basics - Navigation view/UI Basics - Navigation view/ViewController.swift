//
//  ViewController.swift
//  UI Basics - Navigation view
//
//  Created by amalan-pt5585 on 26/08/22.
//

import UIKit

class ViewController: UIViewController {
    let button: UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        navigationItem.title = "Home"
        buttonStyle()
        buttonLayout()
        // Do any additional setup after loading the view.
    }
}

extension ViewController {
    func buttonStyle() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Move", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 220, height: 40)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc func pressed() {
        let rootC = SecondViewController()
        navigationController?.pushViewController(rootC, animated: true)
    }
    
    func buttonLayout() {
        view.addSubview(button)
        
        let contraints = [
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(contraints)
    }
}

class SecondViewController: UIViewController {
//    let button: UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        // Do any additional setup after loading the view.
    }


}
