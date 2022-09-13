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
//        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.frame
//        print("Frame Reset")
    }
    
    func setImageContraints() {
        contentView.addSubview(imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    

}

