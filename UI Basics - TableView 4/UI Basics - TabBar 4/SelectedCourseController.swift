//
//  SelectedCourseController.swift
//  UI Basics - TabBar 4
//
//  Created by amalan-pt5585 on 05/09/22.
//

import UIKit

class SelectedCourseController: UIViewController {
    var sharedConstrains: [NSLayoutConstraint] = []
    var compactcontraints: [NSLayoutConstraint] = []
    
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
        return courseLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutCourseImage()

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

//        layoutTrait(traitCollection: traitCollection)
    }
    
    func setDetails(image: String, courseID: Int) {
        courseImage.image = UIImage(systemName: image)
        courseLabel.text = "Course Id \(courseID)"
        courseDescription.text = courseDescriptionList[courseID] ?? "nil"
    }
    
    func layoutCourseImage() {
        view.addSubview(courseImage)
        view.addSubview(courseDetailsStack)
        
        
//        view.addSubview(courseLabel)
//        view.addSubview(courseDescription)
        
        courseDetailsStack.addArrangedSubview(courseLabel)
        courseDetailsStack.addArrangedSubview(courseDescription)
        
        
//        let courseDescriptionHeight: NSLayoutConstraint = courseDescription.heightAnchor.constraint(equalToConstant: .greatestFiniteMagnitude)
        print("courseDescription - \(courseDescription.contentSize.height)")
        
//        print("courseDescription - \(courseDescription.visibleSize.height)")
//        print("courseDescription - \(courseDescription.frame.height)")
//        courseDescriptionHeight.constant = courseDescription.contentSize.height
       
        
        
        let contraints = [
            courseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            courseImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            courseImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            courseImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            courseImage.widthAnchor.constraint(equalToConstant: view.frame.size.width ),
            courseImage.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2),
            
            courseDetailsStack.topAnchor.constraint(equalTo: courseImage.bottomAnchor),
//            courseDetailsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            
            
//            courseLabel.topAnchor.constraint(equalTo: courseImage.bottomAnchor, constant: 2),
            courseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
//            courseLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 ),
            
//            courseDescription.widthAnchor.constraint(equalToConstant: 200),
//            courseDescription.heightAnchor.constraint(equalToConstant: 200),

//            courseDescription.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 2),
//            courseDescription.forFirstBaselineLayout.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor, constant: 20),
//            courseDescription.leadingAnchor.constraint(equalTo: courseLabel.leadingAnchor),
            
            
            courseDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            courseDescriptionHeight,
            courseDescription.heightAnchor.constraint(equalToConstant: courseDescription.contentSize.height),
//            courseDescription.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(contraints)
        
    }
    
    func constrains() {
        view.addSubview(courseImage)
        view.addSubview(courseDetailsStack)
        
        courseDetailsStack.addArrangedSubview(courseLabel)
        courseDetailsStack.addArrangedSubview(courseDescription)
        
        sharedConstrains.append(contentsOf: [
            courseImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            courseImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            courseDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            courseDescription.heightAnchor.constraint(equalToConstant: courseDescription.contentSize.height),
        ])
        
        compactcontraints.append(contentsOf: [
            courseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            courseImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
 
            courseImage.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2),
            
            courseDetailsStack.topAnchor.constraint(equalTo: courseImage.bottomAnchor),

            courseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
        ])
    }
}

