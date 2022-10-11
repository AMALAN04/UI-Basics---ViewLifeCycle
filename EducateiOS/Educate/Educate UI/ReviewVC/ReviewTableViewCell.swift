//
//  ReviewTableViewCell.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 06/10/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    static var Identifier = "ReviewTableViewCell"
    let profileImageDimensions = 35
    var review: ReviewDataModel?
    
    var textChanged: ((String) -> Void)?
    
    lazy var displayView: UIView = {
        let displayView = UILabel()
        displayView.translatesAutoresizingMaskIntoConstraints = false
        displayView.backgroundColor = .clear
        displayView.clipsToBounds = true
        displayView.layer.cornerRadius = 10
//        displayView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.label, radius: 2.0, opacity: 0.35)
        return displayView
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(profileImageDimensions / 2)
        return imageView
    }()
    
    lazy var userName: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    lazy var ratingLabelInStars: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.font = textLabel.font.bold()
        textLabel.attributedText = FiveStarHelper.statRating(ratingValue: 5)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var date: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .secondaryLabel
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    lazy var comment: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .label
//        textView.delegate = self
        textView.font = .systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.allowsEditingTextAttributes = true
        textView.delegate = self
        return textView
    }()
    
    lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var profileStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var ratingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    
    func dropShadowIfNeeded() {
        displayView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.label, radius: 2.0, opacity: 0.35)
    }
    
    

    override init(style: ReviewTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        dropShadowIfNeeded()
        viewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewConstraints() {
        contentView.addSubview(displayView)

        displayView.addSubview(contentStack)
        contentStack.isUserInteractionEnabled = true
        contentStack.addArrangedSubview(profileStack)
        contentStack.addArrangedSubview(ratingStack)
        contentStack.addArrangedSubview(comment)
        
        profileStack.addArrangedSubview(profileImage)
        profileStack.addArrangedSubview(userName)

        ratingStack.addArrangedSubview(ratingLabelInStars)
        ratingStack.addArrangedSubview(date)
        
        let constraints = [

            displayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            displayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            displayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            displayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),

            contentStack.topAnchor.constraint(equalTo: displayView.topAnchor, constant: 10),
            contentStack.leadingAnchor.constraint(equalTo: displayView.leadingAnchor, constant: 10),
            contentStack.bottomAnchor.constraint(equalTo: displayView.bottomAnchor, constant: -10),
            contentStack.trailingAnchor.constraint(equalTo: displayView.trailingAnchor, constant: -10),

            profileImage.widthAnchor.constraint(equalToConstant: CGFloat(profileImageDimensions)),
            profileImage.heightAnchor.constraint(equalToConstant: CGFloat(profileImageDimensions)),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        dropShadowIfNeeded()
    }
    

}

extension ReviewTableViewCell: UITextViewDelegate {

 func textChanged(action: @escaping (String) -> Void) {
    self.textChanged = action
}

func textViewDidChange(_ textView: UITextView) {
    print("Iam active")
    textChanged?(textView.text)
}
}
