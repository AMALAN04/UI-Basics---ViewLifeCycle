//
//  CollectionViewCell.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//


import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    var rating: Float = 0
    var coursePrice: Float = 0
    static var RecomandedData: [CourseDataModel] = []
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 0.04 * contentView.frame.height
        return imageView
    }()
    
    lazy var courseTitle: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .boldSystemFont(ofSize: screenHeight / 45)
        textLabel.text = "Swift for life"
        textLabel.numberOfLines = 2
        return textLabel
    }()
    
    lazy var instructotName: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .secondaryLabel
//        textLabel.font = .boldSystemFont(ofSize: screenHeight / 75)
//        textLabel.font = .preferredFont(forTextStyle: .footnote)
        textLabel.font = .systemFont(ofSize: screenHeight / 70)
        textLabel.text = "Allen Anish"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var courseRatingFloat: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .systemOrange
        textLabel.font = .boldSystemFont(ofSize: screenHeight / 60)
        textLabel.text = "3.9"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var numberOfRaters: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .tertiaryLabel
//        textLabel.font = .boldSystemFont(ofSize: screenHeight / 50)
        textLabel.font = .systemFont(ofSize: screenHeight / 60)
        textLabel.text = "(\(20))"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var price: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .boldSystemFont(ofSize: screenHeight / 40)
        textLabel.font = textLabel.font.bold()
        textLabel.text = "₹999"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    
    lazy var starRatingLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 0.1)
//        textLabel.font = .boldSystemFont(ofSize: 10)
        textLabel.font = textLabel.font.bold()
        textLabel.text = "**"
        textLabel.numberOfLines = 1
        return textLabel
    }()

    
    lazy var courseLabelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var ratingLabelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(courseDetails: CourseDataModel) {
        coursePrice =  round(Float(courseDetails.courseDetails.price * 100) / 100.0)
        CollectionViewCell.RecomandedData.append(courseDetails)
        courseTitle.text = courseDetails.courseDetails.courseName
        instructotName.text = courseDetails.instructorName
        courseRatingFloat.text = "\(courseDetails.rating)"
        imageView.load(urlString: "\(courseDetails.courseDetails.courseCover)")
        rating = courseDetails.rating
//        StarStackView = StarViewController().statRating(ratingValue: courseDetails.rating)
        starRatingLabel.attributedText = StarViewController.statRating(ratingValue: courseDetails.rating)
        numberOfRaters.text =  "(\(courseDetails.noOfRaters))"
        price.text = "₹\(coursePrice)"
        print("Function \(rating)")
        layout()
        rating = 0
    }
    
    
    func layout() {
        contentView.addSubview(imageView)
        contentView.addSubview(courseLabelStack)
        
        courseLabelStack.addArrangedSubview(courseTitle)
        courseLabelStack.addArrangedSubview(instructotName)
        courseLabelStack.addArrangedSubview(ratingLabelStack)
        courseLabelStack.addArrangedSubview(price)
        
        ratingLabelStack.addArrangedSubview(courseRatingFloat)
        ratingLabelStack.addArrangedSubview(starRatingLabel)
        ratingLabelStack.addArrangedSubview(numberOfRaters)
        
        let constraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            courseLabelStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            courseLabelStack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            courseLabelStack.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
