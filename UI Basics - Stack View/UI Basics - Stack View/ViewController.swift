//
//  ViewController.swift
//  UI Basics - Stack View
//
//  Created by amalan-pt5585 on 24/08/22.
//

import UIKit

class ViewController: UIViewController {
    let customView1: UIView = UIView()
    let customView2: UIView = UIView()
    let customView3: UIView = UIView()
    let stackView: UIStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        style()
        layout()
    }


}

extension ViewController {
    func style() {
        customView1.translatesAutoresizingMaskIntoConstraints = false
        customView1.backgroundColor = .purple
        
        customView2.translatesAutoresizingMaskIntoConstraints = false
        customView2.backgroundColor = .orange
        
        customView3.translatesAutoresizingMaskIntoConstraints = false
        customView3.backgroundColor = .green
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        //stackView.spacing = 1
        stackView.alignment = .center
        //.distribution = .fillEqually
        //stackView.distribution = .fill
        //stackView.distribution = .equalCentering
    }
    
    func layout() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(customView1)
        stackView.addArrangedSubview(customView2)
        stackView.addArrangedSubview(customView3)
        
        let constrains = [
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 3),
            
            
            customView1.widthAnchor.constraint(equalToConstant: 60),
            customView1.heightAnchor.constraint(equalToConstant: 60),

            customView2.widthAnchor.constraint(equalToConstant: 20),
            customView2.heightAnchor.constraint(equalToConstant: 20),

            customView3.widthAnchor.constraint(equalToConstant: 40),
            customView3.heightAnchor.constraint(equalToConstant: 40)
            
        ]
        NSLayoutConstraint.activate(constrains)
        
    }
}
