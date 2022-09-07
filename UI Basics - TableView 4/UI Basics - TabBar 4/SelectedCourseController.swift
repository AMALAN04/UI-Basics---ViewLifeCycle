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
        courseDescription.isScrollEnabled = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
            courseImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            courseDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            courseDetailsStack.bottomAnchor.constraint(equalTo: courseDescription.bottomAnchor),
        ])
        
        compactConstraints.append(contentsOf: [
            courseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            courseImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            courseImage.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2),
            courseDetailsStack.topAnchor.constraint(equalTo: courseImage.bottomAnchor),
            courseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
        ])
        
        regularConstraints.append(contentsOf: [
            courseImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            courseImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            courseDetailsStack.centerYAnchor.constraint(equalTo: courseImage.centerYAnchor),
            courseDetailsStack.leadingAnchor.constraint(equalTo: courseImage.trailingAnchor, constant: 2),
            
        ])
        
        //        courseLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        //        courseDescription.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    func loadRegularConstraints() {
        regularConstraints.append(contentsOf: [
            courseImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            courseImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            courseDetailsStack.centerYAnchor.constraint(equalTo: courseImage.centerYAnchor),
            courseDetailsStack.leadingAnchor.constraint(equalTo: courseImage.trailingAnchor, constant: 2),
            
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

