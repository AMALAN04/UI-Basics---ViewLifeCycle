//
//  ViewController.swift
//  UI Basics - CollectionVC3
//
//  Created by amalan-pt5585 on 08/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    let images: [String] = ["image1.jpeg", "image2.jpeg", "image3.jpeg"]
    
    let collectionView: UICollectionView = {
        //        let layout = UICollectionViewFlowLayout()
        let layout = createCompositeLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "CompositionalLayout"
        configureCollectionView()
        collectionViewLayout()
        
    }
    
    func collectionViewLayout() {
        view.addSubview(collectionView)
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    static func createCompositeLayout() -> UICollectionViewCompositionalLayout {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 5.0, bottom: 2.5, trailing: 2.5)
        
        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 5.0)
        
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)
        
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [leadingItem, trailingGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
 
//        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
//        section.orthogonalScrollingBehavior = .groupPaging
        
//        section.orthogonalScrollingBehavior = .groupPagingCentered
        
//        section.orthogonalScrollingBehavior = .continuous
        
//        section.orthogonalScrollingBehavior = .paging

        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell
        //        print("Instance at cell = \(cell)")
        guard let cell = cell else {return UICollectionViewCell()}
        print(indexPath.row)
        cell.imageView.image = UIImage(named:images[indexPath.row % 3])
        cell.backgroundColor = .systemBlue
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImgNo = indexPath.row % images.count
        let rootController = ImageViewController()
        rootController.imageCount = indexPath.row
        rootController.selectedAlbum = images
        rootController.imageView.image = UIImage(named: images[selectedImgNo])
        navigationController?.pushViewController(rootController, animated: true)
    }
    
}
