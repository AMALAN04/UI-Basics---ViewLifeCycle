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
    var buttonArray: [UIButton] = []
    let stackView: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
//        style()
//        layout()
        
        buttonStyle()
        layoutConstraints()
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
        //stackView.alignment = .center
        //.distribution = .fillEqually
        //stackView.distribution = .fill
        //stackView.distribution = .equalCentering
        stackView.alignment = .center
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
            
            
            //customView1.widthAnchor.constraint(equalToConstant: 60),
            customView1.heightAnchor.constraint(equalToConstant: 60),
            
            //customView2.widthAnchor.constraint(equalToConstant: 20),
            customView2.heightAnchor.constraint(equalToConstant: 20),
            
            //customView3.widthAnchor.constraint(equalToConstant: 40),
            customView3.heightAnchor.constraint(equalToConstant: 40)
            
        ]
        NSLayoutConstraint.activate(constrains)
        
    }
}

extension ViewController {
    func buttonStyle() {
        let noOfButtons = 5
        for index in 1...noOfButtons {
            let button: UIButton = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Button \(index)", for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 25
            button.widthAnchor.constraint(equalToConstant: 150).isActive = true
            buttonArray.append(button)
            stackView.addArrangedSubview(button)
        }
        buttonArray[0].addTarget(self, action: #selector(pressed), for: .touchUpInside)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
    }
    
    @objc func pressed() {
        buttonArray[0].removeFromSuperview()
    }
    
    func layoutConstraints() {
        view.addSubview(stackView)
         
        let constraints = [
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 3),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 3),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
