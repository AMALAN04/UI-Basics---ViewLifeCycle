//
//  CollectionViewCell.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 23/09/22.
//


import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    static let lastCellIdentifier = "LastCell"
    
    var categoryWisecourseDatas: [CourseDataModel] = []
    var rating: Float = 0
    var coursePrice: Float = 0
    var courseData: CourseDataModel?
    
    lazy var displayView: UIView = {
        let displayView = UILabel()
        displayView.translatesAutoresizingMaskIntoConstraints = false
        displayView.backgroundColor = .clear
        displayView.clipsToBounds = true
        displayView.layer.cornerRadius = 10
        return displayView
    }()
    
    lazy var courseCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //        imageView.layer.cornerRadius = 0.04 * contentView.frame.height
        //        imageView.roundCorners([.topLeft, .bottomRight], radius: 10)
        return imageView
    }()
    
    lazy var courseTitle: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .boldSystemFont(ofSize: 18)
        textLabel.text = "Swift for life"
        textLabel.numberOfLines = 3
        return textLabel
    }()
    
    lazy var instructorName: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .secondaryLabel
        textLabel.font = .systemFont(ofSize: 12)
        textLabel.text = "Allen Anish"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var courseRatingLabelInFloat: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .systemOrange
        textLabel.font = .boldSystemFont(ofSize: 15)
        textLabel.text = "3.9"
        textLabel.textAlignment = .left
        textLabel.sizeToFit()
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    lazy var numberOfRaters: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .tertiaryLabel
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.text = "(\(20))"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var price: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .boldSystemFont(ofSize: 18)
        textLabel.text = "₹999"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var courseRatingLabelInStars: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.font = textLabel.font.bold()
        textLabel.text = "**"
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
        dropShadowIfNeeded()
        viewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.courseCoverImage.image = nil
        self.courseTitle.text = nil
        self.instructorName.text = nil
        self.courseRatingLabelInFloat.text = nil
        self.courseRatingLabelInStars.attributedText = NSAttributedString()
        self.numberOfRaters.text = nil
        self.price.text = nil
        super.prepareForReuse()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        dropShadowIfNeeded()
    }
    
    func dropShadowIfNeeded() {
        displayView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.label, radius: 2.0, opacity: 0.35)
    }
    
    func viewConstraints() {
        contentView.addSubview(displayView)
        
        displayView.addSubview(courseCoverImage)
        displayView.addSubview(courseLabelStack)
        
        courseLabelStack.addArrangedSubview(courseTitle)
        courseLabelStack.addArrangedSubview(instructorName)
        courseLabelStack.addArrangedSubview(ratingLabelStack)
        courseLabelStack.addArrangedSubview(price)
        
        ratingLabelStack.addArrangedSubview(courseRatingLabelInFloat)
        ratingLabelStack.addArrangedSubview(courseRatingLabelInStars)
        ratingLabelStack.addArrangedSubview(numberOfRaters)
        
        let constraints = [
            displayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            displayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            displayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            displayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            
            courseCoverImage.topAnchor.constraint(equalTo: displayView.topAnchor),
            courseCoverImage.bottomAnchor.constraint(equalTo: displayView.centerYAnchor, constant: -2),
            courseCoverImage.leadingAnchor.constraint(equalTo: displayView.leadingAnchor),
            courseCoverImage.trailingAnchor.constraint(equalTo: displayView.trailingAnchor),
            
            courseLabelStack.topAnchor.constraint(equalTo: courseCoverImage.bottomAnchor, constant: 2),
            courseLabelStack.leadingAnchor.constraint(equalTo: courseCoverImage.leadingAnchor, constant: 5),
            courseLabelStack.trailingAnchor.constraint(equalTo: courseCoverImage.trailingAnchor, constant: -5),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
