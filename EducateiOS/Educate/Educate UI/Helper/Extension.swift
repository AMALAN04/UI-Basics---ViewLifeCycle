//
//  UrlToImage.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

import Foundation
import UIKit

struct CacheImage {
    static let chacheImages = NSCache<AnyObject,AnyObject>()
}

enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}

extension UIImageView {
    func load(urlString : String) {
        lazy var activityIndicator : UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.color = .blue
            indicator.hidesWhenStopped = true
            indicator.stopAnimating()
            return indicator
        }()
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 10),
            activityIndicator.widthAnchor.constraint(equalToConstant: 10)
        ])
        activityIndicator.startAnimating()
        let url = URL(string: urlString)!
        
        if let imageFromCache = CacheImage.chacheImages.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        
        
        let imgData = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data,response,error) in
            if error != nil {
                    DispatchQueue.main.async {
                      activityIndicator.stopAnimating()
                    }
                print("Error")
                  }
            else {
                if let data = data{
                    DispatchQueue.main.async {
                        let urlImage = UIImage(data: data)
                        activityIndicator.stopAnimating()
                        self?.image = urlImage
                        CacheImage.chacheImages.setObject(urlImage!, forKey: url as AnyObject)
                    }
                }
            }
        })
        
        imgData.resume()
    }
    
    func addIndex(index  : Int) {
        let label = UILabel()
        addSubview(label)
        label.text = "\(index)"
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            label.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment  = .center
    }
    
    
}

extension UITabBarController {
    
    func addSubviewToLastTabItem(_ image: UIImage) {
        
        if let lastTabBarButton = self.tabBar.subviews.last, let tabItemImageView = lastTabBarButton.subviews.first {
            if let accountTabBarItem = self.tabBar.items?.last {
                accountTabBarItem.selectedImage = nil
                accountTabBarItem.image = nil
            }
            let imgView = UIImageView()
            imgView.frame = tabItemImageView.frame
            imgView.layer.cornerRadius = tabItemImageView.frame.height/2
            imgView.layer.masksToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
            imgView.image = image
            self.tabBar.subviews.last?.addSubview(imgView)
            
            print("image updated")
        }
    }
}

extension UIFont {

    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}


extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = UIColor.secondarySystemBackground.cgColor    //backgoundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = UIColor.systemBackground.cgColor
    }
}

extension UIView {
        
    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat, cornerRadius: CGFloat)    {

        var sizeOffset:CGSize = CGSize.zero
        
        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)
            
            
        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)
            
            
        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }

        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true

        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false

        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
}

extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}

extension Locale {
    static let ptBR = Locale(identifier: "pt_BR")
}

extension Formatter {
    static let date = DateFormatter()
}

extension Date {
    func localizedDescription(date dateStyle: DateFormatter.Style = .medium,
                              time timeStyle: DateFormatter.Style = .medium,
                              in timeZone: TimeZone = .current,
                              locale: Locale = .current,
                              using calendar: Calendar = .current) -> String {
        Formatter.date.calendar = calendar
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    var localizedDescription: String { localizedDescription() }
}

extension Date {

    var fullDate: String { localizedDescription(date: .full, time: .none) }
    var longDate: String { localizedDescription(date: .long, time: .none) }
    var mediumDate: String { localizedDescription(date: .medium, time: .none) }
    var shortDate: String { localizedDescription(date: .short, time: .none) }

    var fullTime: String { localizedDescription(date: .none, time: .full) }
    var longTime: String { localizedDescription(date: .none, time: .long) }
    var mediumTime: String { localizedDescription(date: .none, time: .medium) }
    var shortTime: String { localizedDescription(date: .none, time: .short) }

    var fullDateTime: String { localizedDescription(date: .full, time: .full) }
    var longDateTime: String { localizedDescription(date: .long, time: .long) }
    var mediumDateTime: String { localizedDescription(date: .medium, time: .medium) }
    var shortDateTime: String { localizedDescription(date: .short, time: .short) }
}


extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
