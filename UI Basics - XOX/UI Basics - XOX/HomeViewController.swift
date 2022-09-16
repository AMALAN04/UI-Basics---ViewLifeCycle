//
//  HomeViewController.swift
//  UI Basics - XOX
//
//  Created by amalan-pt5585 on 12/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var compactConstraints:[NSLayoutConstraint] = []
    var regularConstraints: [NSLayoutConstraint] = []
    
    lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = UIImage(named: "backImage.jpeg")
        return backgroundImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.image = UIImage(named: "x.png")?.withTintColor(.white)
        return logoImageView
    }()
    
    lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("START", for: .normal)
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        startButton.titleLabel?.minimumScaleFactor = 0.2
        startButton.titleLabel?.numberOfLines = 1
        startButton.titleLabel?.lineBreakMode = .byClipping
        startButton.backgroundColor = .systemRed
        //        startButton.titleLabel?.font = UIFont(name: "Helvetica", size: 50)
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return startButton
    }()
    
//    lazy var quitButton: UIButton = {
//        let quitButton = UIButton()
//        quitButton.translatesAutoresizingMaskIntoConstraints = false
//        quitButton.setTitle("QUIT", for: .normal)
//        quitButton.backgroundColor = .systemRed
//        quitButton.addTarget(self, action: #selector(exitPopUP), for: .touchUpInside)
//        //        quitButton.layer.cornerRadius = 25
//        return quitButton
//    }()
    
    lazy var logoStack: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.axis = .vertical
        stackview.spacing = 30
        return stackview
    }()
    
    lazy var buttonStack: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 3
        return stackview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backGroundImageLayout()
        logoStackLayout()
        loadLayoutConstraints()
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    func loadLayoutConstraints() {
        compactConstraints = [ startButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        regularConstraints = [ startButton.heightAnchor.constraint(equalToConstant: 80),
        ]
    }
    
    func backGroundImageLayout() {
        view.addSubview(backgroundImageView)
        let constraints = [
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func logoStackLayout() {
        view.addSubview(logoStack)
        view.addSubview(buttonStack)
        
        logoStack.addArrangedSubview(logoImageView)
        
        buttonStack.addArrangedSubview(startButton)
        print( (view.frame.width - 200) / 4)
        let constraints = [
            logoStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            logoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            startButton.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: logoImageView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                print("RC - deactive")
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            startButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
            startButton.layer.cornerRadius = 25
            print("CC - Active")
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                print("CC - deactive")
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            print("RC - Active")
            startButton.titleLabel?.font = UIFont(name: "Helvetica", size: 40)
            startButton.layer.cornerRadius = 40
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}

extension HomeViewController {

    @objc func exitPopUP() {
        print("HAPPY")
        let alert = UIAlertController(title: "Exit App", message: "Do you want to exit an App", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: {_ in
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            exit(0)
        }))
        present(alert, animated: true)
    }
    
    @objc func startTapped() {
        print("Start tapped")
        let rootVc = ViewController()
        let navController = UINavigationController(rootViewController: rootVc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
