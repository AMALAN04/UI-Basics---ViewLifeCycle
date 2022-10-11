//
//  ListTableViewCell.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 29/09/22.
//

import UIKit

class  ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListCell"
    
    var compactConstraints: [NSLayoutConstraint] = []
    var regularConstraints: [NSLayoutConstraint] = []
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
        textLabel.numberOfLines = 1
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
    
    lazy var courseDisplayStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: ListTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        //        loadConstraints()
        dropShadowIfNeeded()
        viewConstraints()
        //        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    //    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    //        super.traitCollectionDidChange(previousTraitCollection)
    //        layoutTrait(traitCollection: traitCollection)
    //    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        dropShadowIfNeeded()
    }
    
    func dropShadowIfNeeded() {
        displayView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.label, radius: 2.0, opacity: 0.25)
    }
    
    //    func loadConstraints() {
    //        regularConstraints = [
    //            courseCoverImage.heightAnchor.constraint(equalToConstant: 120),
    //            courseCoverImage.widthAnchor.constraint(equalToConstant: 120 * 1.8),
    //            courseDisplayStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
    //        ]
    //
    //        compactConstraints = [
    //            courseCoverImage.heightAnchor.constraint(equalToConstant: 60),
    //            courseCoverImage.widthAnchor.constraint(equalToConstant: 60),
    //            courseDisplayStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
    //        ]
    //    }
    
    func viewConstraints(){
        contentView.addSubview(displayView)
        
        displayView.addSubview(courseDisplayStack)
        
        courseDisplayStack.addArrangedSubview(courseCoverImage)
        courseDisplayStack.addArrangedSubview(courseLabelStack)
        
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
            
            courseDisplayStack.topAnchor.constraint(equalTo: displayView.topAnchor, constant: 10),
            courseDisplayStack.leadingAnchor.constraint(equalTo: displayView.leadingAnchor, constant: 5),
            courseDisplayStack.trailingAnchor.constraint(equalTo: displayView.trailingAnchor, constant: -5),
            courseDisplayStack.bottomAnchor.constraint(equalTo: displayView.bottomAnchor, constant: -5),
            
            courseCoverImage.heightAnchor.constraint(equalToConstant: 60),
            courseCoverImage.widthAnchor.constraint(equalToConstant: 60),
            
            courseCoverImage.leadingAnchor.constraint(equalTo: courseDisplayStack.leadingAnchor),
            courseCoverImage.topAnchor.constraint(equalTo: courseDisplayStack.topAnchor),
            courseLabelStack.topAnchor.constraint(equalTo: courseDisplayStack.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
    //    func layoutTrait(traitCollection:UITraitCollection) {
    //
    //        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
    //            if regularConstraints.count > 0 && regularConstraints[0].isActive {
    //                NSLayoutConstraint.deactivate(regularConstraints)
    //            }
    //            NSLayoutConstraint.activate(compactConstraints)
    //        } else {
    //            if compactConstraints.count > 0 && compactConstraints[0].isActive {
    //                NSLayoutConstraint.deactivate(compactConstraints)
    //            }
    //            NSLayoutConstraint.activate(regularConstraints)
    //        }
    //    }
    //
}
