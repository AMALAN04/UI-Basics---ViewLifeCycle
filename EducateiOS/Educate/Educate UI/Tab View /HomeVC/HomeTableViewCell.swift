//
//  TableViewCell1.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 28/09/22.
//

import Foundation
import UIKit

typealias DidSelectClosure = ((_ tableIndex: Int?, _ collectionIndex: Int?) -> Void)

class  HomeTableViewCell: UITableViewCell {
    static let indentifier = "TableViewCell"
    var courseData: [CourseDataModel] = []
    var didSelect: DidSelectClosure?
    
    
    var tableViewRowNo: Int = 0
    var noOfItemsInSection: Int = 7
    var smallestCourseCollectionSize: Int = 7
    var collectionViewWidth: NSLayoutConstraint?
    
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
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        viewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewConstraints() {
        contentView.addSubview(collectionView)
        collectionViewWidth =  collectionView.widthAnchor.constraint(equalToConstant: collectionView.contentSize.width)
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 290),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func loadData(courseDetails: CourseDataModel, cell: HomeCollectionViewCell) {
        cell.coursePrice =  round(Float(courseDetails.courseDetails.price * 100) / 100.0)
        cell.courseTitle.text = courseDetails.courseDetails.courseName
        cell.instructorName.text = courseDetails.instructorName
        cell.courseCoverImage.load(urlString: "\(courseDetails.courseDetails.courseCover)")
        cell.rating = courseDetails.rating
        if cell.rating == 0 {
            cell.courseRatingLabelInFloat.text = "Not yet rated"
            cell.courseRatingLabelInStars.attributedText = NSAttributedString()
            cell.numberOfRaters.text = ""
        } else {
            cell.courseRatingLabelInFloat.text = "\(courseDetails.rating)"
            cell.courseRatingLabelInStars.attributedText = FiveStarHelper.statRating(ratingValue: courseDetails.rating)
            cell.numberOfRaters.text =  "(\(courseDetails.noOfRaters))"
        }
        cell.price.text = "₹\(cell.coursePrice)"
    }

}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if noOfItemsInSection < smallestCourseCollectionSize {
             smallestCourseCollectionSize =  noOfItemsInSection
        }
        return smallestCourseCollectionSize
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.backgroundColor = .clear
        print(courseData.count)
        loadData(courseDetails: courseData[indexPath.item], cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.inputViewController?.loadView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.80 * (285)  , height: (285))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Index path \(indexPath)")
        (didSelect)?(tableViewRowNo, indexPath.item)
    }
}
