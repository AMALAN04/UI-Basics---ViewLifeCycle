//
//  StarViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 24/09/22.
//

import UIKit

class FiveStarHelper {
    
   static func statRating(ratingValue: Float) -> NSMutableAttributedString {
       var image1 = "star"
       var image2 = "star"
       var image3 = "star"
       var image4 = "star"
       var image5 = "star"
       
        let fullStars: Int = Int(ratingValue)

        switch fullStars {
        case 5:
            image5 = "star.fill"
            fallthrough
        case 4:
            image4 = "star.fill"
            fallthrough
        case 3:
            image3 = "star.fill"
            fallthrough
        case 2:
            image2 = "star.fill"
            fallthrough
        case 1:
            image1 = "star.fill"
            break
        default:
            break
        }

        if (ratingValue - Float(fullStars)) > 0.4 {
            let halfStar = fullStars + 1
            switch halfStar {
            case 5:
                image5 = "star.lefthalf.fill"
                break
            case 4:
                image5 = "star.lefthalf.fill"
                break
            case 3:
                image5 = "star.lefthalf.fill"
                break
            case 2:
                image5 = "star.lefthalf.fill"
                break
            case 1:
                image5 = "star.lefthalf.fill"
                break
            default:
                break
            }
        }
     
       
       let imageAttachment1 = NSTextAttachment()
       let largeConfig = UIImage.SymbolConfiguration(pointSize: 10 , weight: .bold, scale: .large)
       imageAttachment1.image = UIImage(systemName: image1, withConfiguration: largeConfig)?.withTintColor(.systemOrange)
       let imageAttachment2 = NSTextAttachment()
       imageAttachment2.image = UIImage(systemName: image2, withConfiguration: largeConfig)?.withTintColor(.systemOrange)
       let imageAttachment3 = NSTextAttachment()
       imageAttachment3.image = UIImage(systemName: image3, withConfiguration: largeConfig)?.withTintColor(.systemOrange)
       let imageAttachment4 = NSTextAttachment()
       imageAttachment4.image = UIImage(systemName: image4, withConfiguration: largeConfig)?.withTintColor(.systemOrange)
       let imageAttachment5 = NSTextAttachment()
       imageAttachment5.image = UIImage(systemName: image5, withConfiguration: largeConfig)?.withTintColor(.systemOrange)
       let fullString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 2.0)!])
//       let fullString = NSMutableAttributedString(string: "")
       fullString.append(NSAttributedString(attachment: imageAttachment1))
       fullString.append(NSAttributedString(attachment: imageAttachment2))
       fullString.append(NSAttributedString(attachment: imageAttachment3))
       fullString.append(NSAttributedString(attachment: imageAttachment4))
       fullString.append(NSAttributedString(attachment: imageAttachment5))
       
       return fullString
    }

}
