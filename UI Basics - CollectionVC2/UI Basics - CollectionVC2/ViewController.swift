//
//  ViewController.swift
//  UI Basics - CollectionVC2
//
//  Created by amalan-pt5585 on 07/09/22.
//

import UIKit

class ViewController: UIViewController {
    let image: [String] = ["image1.jpeg", "image2.jpeg", "image3.jpeg"]
    
    var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionViewDesigned = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewDesigned.backgroundColor = .systemBackground
        collectionViewDesigned.translatesAutoresizingMaskIntoConstraints = false
        return collectionViewDesigned
    }()
//
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Grid View"
        view.backgroundColor = .orange
        configureColectionView()
        view.addSubview(collectionView)
        addconstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func configureColectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension:  .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension:  .fractionalHeight(2/5)),
            subitem: item,
            count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell
//        print("Instance at cell = \(cell)")
        guard let cell = cell else {return UICollectionViewCell()}
        print(indexPath.row)
        cell.imageView.image = UIImage(named:image[indexPath.row % 3])
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func addconstraints() {
        let constraints = [
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("Size activated")
//        return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width / 3) - 1, height: (view.safeAreaLayoutGuide.layoutFrame.width / 3) - 3)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        1
//    }
//
//}
