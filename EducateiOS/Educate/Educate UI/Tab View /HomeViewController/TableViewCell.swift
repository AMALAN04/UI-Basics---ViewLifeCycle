//
//  TableViewCell.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//

import UIKit

class  TableViewCell: UITableViewCell {
    static let indentifier = "TableViewCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    
    lazy var tableViewSectionTitle: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .boldSystemFont(ofSize: screenHeight / 40)
        textLabel.font = textLabel.font.bold()
//        textLabel.font = .preferredFont(forTextStyle: .largeTitle)
        textLabel.text = "Welcome"
        return textLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        collectionView.frame = contentView.bounds
    }
    
    func layout() {
        contentView.addSubview(collectionView)
        contentView.addSubview(tableViewSectionTitle)
        let constraints = [
            tableViewSectionTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableViewSectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            collectionView.topAnchor.constraint(equalTo: tableViewSectionTitle.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
   
     
}


 
extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .clear
        let courseData = courseDataLoader().readCourseData(categoryId: 2)
        if  courseData.count > indexPath.item {
        cell.loadData(courseDetails: courseData[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (6 * (screenWidth / 15) )  , height: (6 * (screenWidth / 15)))
        return CGSize(width: 0.75 * (collectionView.frame.height)  , height: (collectionView.frame.height))
    }
}
