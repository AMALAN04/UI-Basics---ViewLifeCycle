//
//  ImageCollectionViewCell.swift
//  UI Basics - XOX
//
//  Created by amalan-pt5585 on 09/09/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "Cell"
    var boxStatus:BoxStatus = .unownedPlace
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        print("image loaded")
        imageView.image = nil
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageContraints() {
        contentView.addSubview(imageView)
        let constraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

