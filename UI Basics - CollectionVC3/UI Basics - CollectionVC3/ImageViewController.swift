//
//  ImageViewController.swift
//  UI Basics - CollectionVC3
//
//  Created by amalan-pt5585 on 08/09/22.
//

import UIKit

class ImageViewController: UIViewController {
    var imageCount: Int?
    var selectedAlbum: [String] = []
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
  lazy var singleTap: UITapGestureRecognizer = {
      let singleTap = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        singleTap.numberOfTouchesRequired = 1
        singleTap.numberOfTapsRequired = 1
        
        return singleTap
    }()
    
    lazy var swipeRight: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeScreen))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .right
        return swipe
    }()
    
    lazy var swipeLeft: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeScreen))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .left
        return swipe
    }()
    

    @objc func selectImage() {
        let rootViewController = SelectedImageViewController()
        rootViewController.imageView.image = imageView.image
        let navView = UINavigationController(rootViewController: rootViewController)
        navView.modalPresentationStyle = .fullScreen
        present(navView, animated: false)
    }
    
    @objc func swipeScreen(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction {
        case .down:
            print("down")
        case .left:
            print("left")
            guard let _imageCount = imageCount else {
                return
            }
            print(_imageCount)
            if _imageCount < 11 {
                print("Image previous \(_imageCount) % \(selectedAlbum.count) = \(_imageCount % selectedAlbum.count)")
                print("album count \(selectedAlbum.count)")
                imageCount = _imageCount + 1
                print("Image previous \(_imageCount) % \(selectedAlbum.count) = \(_imageCount % selectedAlbum.count)")
                imageView.image = UIImage(named: selectedAlbum[imageCount! % selectedAlbum.count])
            }
        case .right:
            print("right")
            guard let _imageCount = imageCount else {
                return
            }
            print(_imageCount)
            if _imageCount > 0 {
                print(_imageCount)
                imageCount = _imageCount - 1
                imageView.image = UIImage(named: selectedAlbum[imageCount! % selectedAlbum.count])
            }
        case .up:
            print("up")
        default:
            print("unrecognized")
        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
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
