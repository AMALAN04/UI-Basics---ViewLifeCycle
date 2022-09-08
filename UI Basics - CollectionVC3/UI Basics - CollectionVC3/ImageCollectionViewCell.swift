//
//  ImageCollectionViewCell.swift
//  UI Basics - CollectionVC3
//
//  Created by amalan-pt5585 on 08/09/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "Cell"

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        print("image loaded")
//        imageView.image = UIImage(named: "image1.jpeg")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.frame
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
}
