//
//  TableViewCell.swift
//  UI Basics - TabelView3
//
//  Created by amalan-pt5585 on 25/08/22.
//

import UIKit

class  UITaleCell: UITableViewCell {
    static let indentifier = "Cell"
    
    let _switch: UISwitch = UISwitch()
    let IImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 25
        styleV()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension  UITaleCell {
    func styleV(){
        _switch.tintColor = .black
        
        // IImageView.image = UIImage(systemName: "square")
        IImageView.contentMode = .scaleToFill
        IImageView.tintColor = .black
        
    }
    func configureImage(imageName:String) {
        IImageView.image = UIImage(systemName: imageName)
    }
    func layout(){
        contentView.addSubview(_switch)
        contentView.addSubview(IImageView)
        
        _switch.translatesAutoresizingMaskIntoConstraints = false
        IImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            _switch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            _switch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            _switch.widthAnchor.constraint(equalToConstant: 40),
            
            IImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            IImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            IImageView.widthAnchor.constraint(equalToConstant: 40),
            IImageView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


//class UITaleCell: UITableViewCell {
//    static let indentifier = "Cell"
//
//    let imageDisplay: UIImageView = UIImageView()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .systemMint
//        styleView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//extension UITaleCell {
//    func styleView() {
//        contentView.addSubview(imageDisplay)
//        imageDisplay.image = UIImage(systemName: "square")
//
//        imageDisplay.translatesAutoresizingMaskIntoConstraints = false
//        let constrains = [
//        imageDisplay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//        imageDisplay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//        imageDisplay.widthAnchor.constraint(equalToConstant: 40),
//        ]
//        NSLayoutConstraint.activate(constrains)
//    }
//}
