//
//  ReviewViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 06/10/22.
//

import UIKit

class ReviewViewController: UIViewController {
    var titleText: String?
    var courseId: Int?
    var courseRating: Float?
    var courseName: String?
    var othersReview: [ReviewDataModel] = []
    var myReview: ReviewDataModel?
    let reviewVCHelper = ReviewVCHelper()
    var myReviewPresent: Bool = false

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register( ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.Identifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        guard let courseId = courseId, let userId = UserDefaults.standard.string(forKey: "UserId") else {
            return
        }
        let reviewData = reviewVCHelper.reviewDetails(courseId: courseId , userId: userId)
        myReview = reviewData.myReview
        othersReview = reviewData.othersReview
        print(myReview?.userName)
        viewConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        tableView.reloadData()
    }
    
    func viewConstraints() {
        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func loadData(courseDetails: CourseDataModel, cell: ListTableViewCell) {
        cell.coursePrice =  round(Float(courseDetails.courseDetails.price * 100) / 100.0)
        cell.courseTitle.text = courseDetails.courseDetails.courseName
        cell.instructorName.text = courseDetails.instructorName
        cell.courseCoverImage.load(urlString: "\(courseDetails.courseDetails.courseCover)")
        cell.rating = courseDetails.rating
        if cell.rating == 0 {
            cell.courseRatingLabelInFloat.text = "Not yet rated"
            cell.courseRatingLabelInStars.attributedText = NSAttributedString()
            cell.numberOfRaters.text = ""
        } else {
            cell.courseRatingLabelInFloat.text = "\(courseDetails.rating)"
            cell.courseRatingLabelInStars.attributedText = FiveStarHelper.statRating(ratingValue: courseDetails.rating)
            cell.numberOfRaters.text =  "(\(courseDetails.noOfRaters))"
        }
        cell.price.text = "₹\(cell.coursePrice)"
    }
    
    func loadData(cell: ReviewTableViewCell, review: ReviewDataModel?) {
        guard let review = review else {
            return
        }
        cell.profileImage.load(urlString:  review.userProfile)
        cell.ratingLabelInStars.attributedText = FiveStarHelper.statRating(ratingValue: Float(review.userRating))
        cell.date.text = review.date
        cell.comment.text = review.comment
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let titleText = titleText {
            self.navigationItem.title = titleText
        } else {
            self.navigationItem.title = titleText ?? "Course List"
        }
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
   lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageAttachment1 = NSTextAttachment()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 10 , weight: .bold, scale: .large)
        imageAttachment1.image = UIImage(systemName: "ellipsis.circle", withConfiguration: largeConfig)?.withTintColor(.systemBlue)
        let fullString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 15)!])
        fullString.append(NSAttributedString(attachment: imageAttachment1))
        button.setAttributedTitle(fullString, for: .normal)
        button.menu = addMenu()
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    lazy var saveButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitle("Save", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -7, right: 0)
        button.isHidden = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
         return button
     }()
    
    @objc func saveButtonTapped() {
        saveButton.isHidden = true
        let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! ReviewTableViewCell
        cell.displayView.isUserInteractionEnabled = false
        cell.comment.resignFirstResponder()
    }
    
    func addMenu() -> UIMenu {
        print("Add menu loading")
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Edit", handler:  { [weak self] _ in
                self?.edit()
        }),
            UIAction(title: "Delete", handler:  { [weak self] _ in
                self?.delete()
        }),
        ])
        return menuItems
    }
    
    func edit() {
        let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! ReviewTableViewCell
        cell.displayView.isUserInteractionEnabled = true
        cell.comment.becomeFirstResponder()
        saveButton.isHidden = false
    }
    
    func delete() {
        
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var noOfSection = 0
        if myReview != nil {
            noOfSection += 1
            myReviewPresent = true
            print("My rev \(noOfSection)")
        }
        if !othersReview.isEmpty {
            noOfSection += 1
            print("otherr re \(noOfSection)")
        }
        print("no of sec \(noOfSection)")
        return noOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.numberOfSections == 2 {
            if section == 0 {
                return 1
            } else {
                return othersReview.capacity
            }
        } else {
            if myReviewPresent {
                return 1
            } else {
                print(othersReview.count)
                return othersReview.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.Identifier, for: indexPath) as! ReviewTableViewCell
        cell.textChanged {[weak tableView] (_) in
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
        }
        if (indexPath == IndexPath(item: 0, section: 0)) && myReviewPresent {
            print("Im ready to load from my review")
            self.loadData(cell: cell, review: myReview)
        } else {
            print("Im ready to load")
            self.loadData(cell: cell, review: othersReview[indexPath.item])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let primaryHeaderView = UIView()
        let primaryLabel:UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "Kailasa-Bold", size: 15)
            label.textColor = .label
            return label
        }()
        primaryLabel.text = "Other reviews"
        primaryHeaderView.addSubview(primaryLabel)
        let secondaryHeaderConstraints = [
            primaryLabel.topAnchor.constraint(equalTo: primaryHeaderView.topAnchor),
            primaryLabel.leadingAnchor.constraint(equalTo: primaryHeaderView.leadingAnchor),
            primaryLabel.trailingAnchor.constraint(equalTo: primaryHeaderView.trailingAnchor),
            primaryLabel.bottomAnchor.constraint(equalTo: primaryHeaderView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(secondaryHeaderConstraints)

        if section == 0 {
            let ratingLabelFloat: UILabel = {
                let textLabel = UILabel()
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                textLabel.textColor = .systemOrange
                textLabel.font = .systemFont(ofSize: 30, weight: .heavy)
                textLabel.text = "\(courseRating!)"
                textLabel.numberOfLines = 1
                return textLabel
            }()
            lazy var courseRatingLabelInStars: UILabel = {
                let textLabel = UILabel()
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                textLabel.textColor = .label
                textLabel.font = .systemFont(ofSize: 15)
                textLabel.font = textLabel.font.bold()
                textLabel.attributedText = FiveStarHelper.statRating(ratingValue: courseRating!)
                textLabel.numberOfLines = 1
                return textLabel
            }()
            
            lazy var headerStack: UIStackView = {
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .vertical
                stackView.spacing = 4
                stackView.alignment = .center
                return stackView
            }()
            
            lazy var courseTitle: UILabel = {
                let textLabel = UILabel()
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                textLabel.textColor = .label
                textLabel.textAlignment = .center
                textLabel.font = .boldSystemFont(ofSize: 18)
                textLabel.text = courseName!
                textLabel.numberOfLines = 3
                return textLabel
            }()
            
            NSLayoutConstraint.deactivate(secondaryHeaderConstraints)
            if myReviewPresent {
                primaryLabel.text = "My review"
            }
            primaryHeaderView.addSubview(headerStack)
            
            headerStack.addArrangedSubview(ratingLabelFloat)
            headerStack.addArrangedSubview(courseRatingLabelInStars)
            headerStack.addArrangedSubview(courseTitle)
            
            let primaryHeaderConstraints = [
                headerStack.topAnchor.constraint(equalTo: primaryHeaderView.topAnchor),
                headerStack.leadingAnchor.constraint(equalTo: primaryHeaderView.leadingAnchor),
                headerStack.trailingAnchor.constraint(equalTo: primaryHeaderView.trailingAnchor),
                primaryLabel.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 20),
                primaryLabel.leadingAnchor.constraint(equalTo: primaryHeaderView.leadingAnchor),
                primaryLabel.trailingAnchor.constraint(equalTo: primaryHeaderView.trailingAnchor),
                primaryLabel.bottomAnchor.constraint(equalTo: primaryHeaderView.bottomAnchor),
            ]
            NSLayoutConstraint.activate(primaryHeaderConstraints)
            
            if myReviewPresent {
                NSLayoutConstraint.deactivate(primaryHeaderConstraints)
                primaryHeaderView.addSubview(headerStack)
                primaryHeaderView.addSubview(moreButton)
                primaryHeaderView.addSubview(saveButton)
                headerStack.addArrangedSubview(ratingLabelFloat)
                headerStack.addArrangedSubview(courseRatingLabelInStars)
                headerStack.addArrangedSubview(courseTitle)
                
                let primaryHeaderWithActionsConstraints = [
                    headerStack.topAnchor.constraint(equalTo: primaryHeaderView.topAnchor),
                    headerStack.leadingAnchor.constraint(equalTo: primaryHeaderView.leadingAnchor),
                    headerStack.trailingAnchor.constraint(equalTo: primaryHeaderView.trailingAnchor),
                    primaryLabel.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 20),
                    primaryLabel.leadingAnchor.constraint(equalTo: primaryHeaderView.leadingAnchor),
                    primaryLabel.trailingAnchor.constraint(equalTo: primaryHeaderView.trailingAnchor),
                    primaryLabel.bottomAnchor.constraint(equalTo: primaryHeaderView.bottomAnchor),
                    moreButton.trailingAnchor.constraint(equalTo: primaryHeaderView.trailingAnchor),
                    moreButton.centerYAnchor.constraint(equalTo: primaryLabel.centerYAnchor),
                    saveButton.widthAnchor.constraint(equalToConstant: 40),
                    saveButton.heightAnchor.constraint(equalToConstant: 10),
                    saveButton.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -10),
                    saveButton.centerYAnchor.constraint(equalTo: primaryLabel.centerYAnchor)
                ]
                NSLayoutConstraint.activate(primaryHeaderWithActionsConstraints)
            }
            
        }
        return primaryHeaderView
    }
}


