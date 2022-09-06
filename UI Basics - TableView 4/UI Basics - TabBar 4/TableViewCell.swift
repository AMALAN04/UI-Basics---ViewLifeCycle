//
//  TableViewCell.swift
//  UI Basics - TabBar 4
//
//  Created by amalan-pt5585 on 05/09/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "Cell"
    
    let imageViewOnRight: UIImageView = {
        let imageViewOnRight = UIImageView()
        imageViewOnRight.translatesAutoresizingMaskIntoConstraints = false
        return imageViewOnRight
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        layoutimageViewOnRight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutimageViewOnRight() {
        contentView.addSubview(imageViewOnRight)
        let constraints = [
            imageViewOnRight.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageViewOnRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
