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
    
    lazy var courseCoverImage: UIImageView = {
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
    
    lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See all", for: .normal)
        button.setTitleColor( .systemPurple, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font =  UIFont(name:"GeezaPro-Bold", size: 20)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lastCell() {
        contentView.addSubview(seeMoreButton)
        prepareForReuse()
        let  constraints = [
            seeMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seeMoreButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func seeAllButtonTapped() {
        print("ooo")
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
    
    
    func viewConstraints() {
        contentView.addSubview(courseCoverImage)
        contentView.addSubview(courseLabelStack)
        
        courseLabelStack.addArrangedSubview(courseTitle)
        courseLabelStack.addArrangedSubview(instructorName)
        courseLabelStack.addArrangedSubview(ratingLabelStack)
        courseLabelStack.addArrangedSubview(price)
        
        ratingLabelStack.addArrangedSubview(courseRatingLabelInFloat)
        ratingLabelStack.addArrangedSubview(courseRatingLabelInStars)
        ratingLabelStack.addArrangedSubview(numberOfRaters)
        
        let constraints = [
            courseCoverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            courseCoverImage.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            courseCoverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            courseCoverImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            courseLabelStack.topAnchor.constraint(equalTo: courseCoverImage.bottomAnchor, constant: 2),
            courseLabelStack.leadingAnchor.constraint(equalTo: courseCoverImage.leadingAnchor),
            courseLabelStack.trailingAnchor.constraint(equalTo: courseCoverImage.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
