//
//  SelectedImageViewController.swift
//  UI Basics - CollectionVC3
//
//  Created by amalan-pt5585 on 08/09/22.
//

import UIKit

class SelectedImageViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var singleTap: UITapGestureRecognizer = {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dismissImage))
          singleTap.numberOfTouchesRequired = 1
          singleTap.numberOfTapsRequired = 1
          return singleTap
      }()
    
    lazy var pinchGesture: UIPinchGestureRecognizer = {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchActive(pinch:)))
        return pinchGesture
    }()
    
    @objc func dismissImage() {
        self.dismiss(animated: false)
        print("Dismiss")
    }
    
    @objc func pinchActive(pinch: UIPinchGestureRecognizer) {
        if pinchGesture.state == .changed {
            let scale = pinchGesture.scale
            print(scale)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
        view.addGestureRecognizer(pinchGesture)
        imageLayout()
        // Do any additional setup after loading the view.
    }
    
    func imageLayout() {
        view.addSubview(imageView)
        let constraints = [
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
