//
//  SecondViewController.swift
//  UI Basics - Element
//
//  Created by amalan-pt5585 on 26/08/22.
//

import UIKit

class SecondViewController: UIViewController {
    let displayLabel: UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        style()
        layout()

        
    }
 
}

extension SecondViewController {
    func style() {
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.font = .preferredFont(forTextStyle: .largeTitle)
        displayLabel.font = .systemFont(ofSize: 20)
        displayLabel.textColor = .white
    }
    
    func layout() {
        view.addSubview(displayLabel)
        
        displayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
