//
//  SelectedCourseController.swift
//  UI Basics - TabBar 4
//
//  Created by amalan-pt5585 on 05/09/22.
//

import UIKit

class SelectedCourseController: UIViewController {
    var sharedConstraints: [NSLayoutConstraint] = []
    var compactConstraints: [NSLayoutConstraint] = []
    var regularConstraints: [NSLayoutConstraint] = []
    
    static var courseDescriptionTemplate: String =
"""
Be student-centered, rather than teacher-centered or course-centered.
Use brief, outcomes-based, descriptive phrases that begin with an imperative or active verb (e.g., design,create, plan, analyze).
Be clear, concise, and easy to understand (< 80 words).
Detail significant learning experiences and benefits students can expect.
"""
    
    var courseDescriptionList: [Int: String] =
    [0: "0 \(courseDescriptionTemplate)", 1: "1\(courseDescriptionTemplate)", 2: "2\(courseDescriptionTemplate)", 3: "3\(courseDescriptionTemplate)", 4:"4\(courseDescriptionTemplate)", 5:"5 \(courseDescriptionTemplate)", 6: "6\(courseDescriptionTemplate)", 7: "7\(courseDescriptionTemplate)", 8: "8\(courseDescriptionTemplate)", 9: "9\(courseDescriptionTemplate)"]
    
    let courseDescription: UITextView = {
        let courseDescription = UITextView()
        courseDescription.translatesAutoresizingMaskIntoConstraints = false
        courseDescription.isEditable = false
//        courseDescription.isScrollEnabled = false
        courseDescription.backgroundColor = .green
        courseDescription.font = UIFont(name: "Avenir-Light" , size: 20)
        courseDescription.textAlignment = .left
        courseDescription.textContainer.lineBreakMode = .byWordWrapping
        
        return courseDescription
    }()
    
    let courseDetailsStack: UIStackView = {
        let courseDetailsStack = UIStackView()
        courseDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        courseDetailsStack.axis = .vertical
        courseDetailsStack.alignment = .leading
        courseDetailsStack.spacing = 3
        return courseDetailsStack
    }()
    
    let courseImage: UIImageView = {
        let courseIamge = UIImageView()
        courseIamge.translatesAutoresizingMaskIntoConstraints = false
        courseIamge.contentMode = .scaleAspectFit
        courseIamge.clipsToBounds = true
        return courseIamge
    }()
    
    let courseLabel: UILabel = {
        let courseLabel = UILabel()
        courseLabel.translatesAutoresizingMaskIntoConstraints = false
        courseLabel.font = .systemFont(ofSize: 20)
        courseLabel.backgroundColor = .orange
        return courseLabel
    }()
    
    //    let courseLabel: UITextView = {
    //        let courseLabel = UITextView()
    //        courseLabel.translatesAutoresizingMaskIntoConstraints = false
    //        courseLabel.font = .systemFont(ofSize: 20)
    //        courseLabel.backgroundColor = .orange
    //        courseLabel.isEditable = false
    //        courseLabel.isScrollEnabled = false
    ////        courseLabel.textContainerInset = .zero
    //        courseLabel.textContainer.lineFragmentPadding = CGFloat(0.0)
    //        courseLabel.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //        courseLabel.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    //        return courseLabel
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //        layoutCourseImage()
        constrains()
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }
    
    func setDetails(image: String, courseID: Int) {
        courseImage.image = UIImage(systemName: image)
        courseLabel.text = "Course Id \(courseID)"
        courseDescription.text = courseDescriptionList[courseID] ?? "nil"
    }
    
    func constrains() {
        view.addSubview(courseImage)
        view.addSubview(courseDetailsStack)
        
        courseDetailsStack.addArrangedSubview(courseLabel)
        courseDetailsStack.addArrangedSubview(courseDescription)
        
        sharedConstraints.append(contentsOf: [
            courseImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            courseLabel.heightAnchor.constraint(equalToConstant: 20),
            courseImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            courseDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            courseDetailsStack.bottomAnchor.constraint(equalTo: courseDescription.bottomAnchor),
            courseDescription.heightAnchor.constraint(equalToConstant: courseDescription.contentSize.height),
            //            courseDescription.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        compactConstraints.append(contentsOf: [
            courseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            courseImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            courseImage.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2),
            courseDetailsStack.topAnchor.constraint(equalTo: courseImage.bottomAnchor),
            courseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
        ])
        
        regularConstraints.append(contentsOf: [
            //            courseImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            courseImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            courseImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //            courseDetailsStack.topAnchor.constraint(equalTo: courseImage.topAnchor),
            courseDetailsStack.leadingAnchor.constraint(equalTo: courseImage.trailingAnchor, constant: 2),
            courseDetailsStack.centerYAnchor.constraint(equalTo: courseImage.centerYAnchor)
        ])
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
            NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}

//func layoutCourseImage() {
//    view.addSubview(courseImage)
//    view.addSubview(courseDetailsStack)
////        view.addSubview(courseLabel)
////        view.addSubview(courseDescription)
//    courseDetailsStack.addArrangedSubview(courseLabel)
//    courseDetailsStack.addArrangedSubview(courseDescription)
////        let courseDescriptionHeight: NSLayoutConstraint = courseDescription.heightAnchor.constraint(equalToConstant: .greatestFiniteMagnitude)
//    print("courseDescription - \(courseDescription.contentSize.height)")
////        print("courseDescription - \(courseDescription.visibleSize.height)")
////        print("courseDescription - \(courseDescription.frame.height)")
////        courseDescriptionHeight.constant = courseDescription.contentSize.height
//    let contraints = [
//        courseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//        courseImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//        courseImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//        courseImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
////            courseImage.widthAnchor.constraint(equalToConstant: view.frame.size.width ),
//        courseImage.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2),
//        courseDetailsStack.topAnchor.constraint(equalTo: courseImage.bottomAnchor),
////            courseDetailsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
////            courseLabel.topAnchor.constraint(equalTo: courseImage.bottomAnchor, constant: 2),
//        courseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
////            courseLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 ),
////            courseDescription.widthAnchor.constraint(equalToConstant: 200),
////            courseDescription.heightAnchor.constraint(equalToConstant: 200),
////            courseDescription.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 2),
////            courseDescription.forFirstBaselineLayout.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor, constant: 20),
////            courseDescription.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor),
//        courseDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
////            courseDescriptionHeight,
//        courseDescription.heightAnchor.constraint(equalToConstant: courseDescription.contentSize.height),
////            courseDescription.heightAnchor.constraint(equalToConstant: 200)
//    ]
//    NSLayoutConstraint.activate(contraints)
//
//}
