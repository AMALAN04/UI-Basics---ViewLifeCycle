//
//  RadioTableViewCell.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 02/10/22.
//

import Foundation


import UIKit

class  RadioTableViewCell: UITableViewCell {
    static let identifier = "RadioButton"
    
    lazy var cellSelected: Bool = false
    
    lazy var radioImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(systemName: "circle")
        imageView.layer.cornerRadius = 0.04 * contentView.frame.height
        return imageView
    }()
    
    lazy var radioButtomLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .boldSystemFont(ofSize: 15)
        textLabel.text = "Swift for life"
        textLabel.numberOfLines = 3
        return textLabel
    }()
    
    lazy var radioButtonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: ListTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .tertiarySystemFill
        viewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     
    func viewConstraints() {
        contentView.addSubview(radioButtonStack)
        
        radioButtonStack.addArrangedSubview(radioImage)
        radioButtonStack.addArrangedSubview(radioButtomLabel)
        let constraints = [
            radioButtonStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioButtonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    
}
