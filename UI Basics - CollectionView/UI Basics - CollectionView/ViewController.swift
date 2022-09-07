//
//  ViewController.swift
//  UI Basics - CollectionView
//
//  Created by amalan-pt5585 on 07/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    let button: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Collection VC", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTapped() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width / 3) - 1, height: (view.safeAreaLayoutGuide.layoutFrame.width / 3) - 3)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 1
        let rootVC = CollectionViewController(collectionViewLayout: layout)
        rootVC.title = "Grid View"
        navigationController?.pushViewController(rootVC, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.largeContentTitle = "kkk"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setContraints()
        view.backgroundColor = .systemMint
        // Do any additional setup after loading the view.
    }
    
    func setContraints() {
        view.addSubview(button)
        
        let constraints = [
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(constraints)
    }


}

