//  TableViewCell.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//
//import UIKit
//
//class  TableViewCell: UITableViewCell {
//    static let indentifier = "TableViewCell"
//    static var recommendedCourseData: [CourseDataModel] = []
//    static var businessCourseData: [CourseDataModel] = []
//    static var developmentCourseData: [CourseDataModel] = []
//    static var designCourseData: [CourseDataModel] = []
//    static var engineeringCourseData: [CourseDataModel] = []
//    static var lifeStyleCourseData: [CourseDataModel] = []
//    static var othersCourseData: [CourseDataModel] = []
//    
//    var tableViewRowNo: Int = 0
//    var noOfItemsInSection: Int = 7
//    var smallestCourseCollectionSize: Int = 7
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
//        collectionView.backgroundColor = UIColor.clear
//        return collectionView
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .systemBackground
//        collectionView.reloadData()
//        viewConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func viewConstraints() {
//        contentView.addSubview(collectionView)
//        let constraints = [
//            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: 285),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//            
//        ]
//        NSLayoutConstraint.activate(constraints)
//    }
//    
//    func loadData(courseDetails: CourseDataModel, cell: CollectionViewCell) {
//        cell.coursePrice =  round(Float(courseDetails.courseDetails.price * 100) / 100.0)
//        cell.courseTitle.text = courseDetails.courseDetails.courseName
//        cell.instructotName.text = courseDetails.instructorName
//        cell.courseCoverImage.load(urlString: "\(courseDetails.courseDetails.courseCover)")
//        cell.rating = courseDetails.rating
//        if cell.rating == 0 {
//            cell.courseRatingLabelInFloat.text = "Not yet rated"
//            cell.courseRatingLabelInStars.attributedText = NSAttributedString()
//            cell.numberOfRaters.text = ""
//        } else {
//            cell.courseRatingLabelInFloat.text = "\(courseDetails.rating)"
//            cell.courseRatingLabelInStars.attributedText = FiveStarHelper.statRating(ratingValue: courseDetails.rating)
//            cell.numberOfRaters.text =  "(\(courseDetails.noOfRaters))"
//        }
//        cell.price.text = "₹\(cell.coursePrice)"
//    }
//
//}
//
//extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if noOfItemsInSection < smallestCourseCollectionSize {
//             smallestCourseCollectionSize =  noOfItemsInSection
//        }
//        return smallestCourseCollectionSize
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let courseData = CategoryHelper.categoryLoder(categoryId: tableViewRowNo )
//        print("category  ID \(tableViewRowNo), \(courseData[0].courseDetails.courseName)")
////        if indexPath.item == smallestCourseCollectionSize - 1 {
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.lastCellIdentifier, for: indexPath) as! CollectionViewCell
////            cell.lastCell()
////            return cell
////        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
//            cell.backgroundColor = .clear
//            cell.courseData = courseData[indexPath.item]
////            cell.loadData(courseDetails: courseData[indexPath.item])
//            loadData(courseDetails: courseData[indexPath.item], cell: cell)
//            return cell
////        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 0.80 * (285)  , height: (285))
//    }
//}
