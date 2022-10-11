//
//  AddReviewViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 10/10/22.
//

import UIKit

class AddReviewViewController: UIViewController {
    var starNo: Int = 0
    var courseId: Int?
    var alreadyReviewed: Bool = false
    
    var reviewVCHelper = ReviewVCHelper()
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelTapped))
        return barButtonItem
    }()
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Post", style: UIBarButtonItem.Style.plain, target: self, action: #selector(postTapped))
        barButtonItem.isEnabled = false
        return barButtonItem
    }()
    
    lazy var starButton1: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(ratingTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var starButton2: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(ratingTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var starButton3: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(ratingTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var starButton4: UIButton = {
        let button = UIButton()
        button.tag = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(ratingTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var starButton5: UIButton = {
        let button = UIButton()
        button.tag = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(self, action: #selector(ratingTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var starButtonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .bottom
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    lazy var starRatingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    lazy var starRatingDescription: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .secondaryLabel
        textLabel.text = "Tap a star to rate"
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var separator: UIView = {
        let separator = UILabel()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .secondaryLabel
        separator.clipsToBounds = true
        return separator
    }()
    
    
    lazy var comment: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .label
        textView.font = .systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.text = "Review"
        textView.textColor = UIColor.secondaryLabel
        textView.delegate = self
        textView.isUserInteractionEnabled = true
        textView.allowsEditingTextAttributes = true
        textView.textContainer.heightTracksTextView = true
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        viewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    func configureNavBar() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func cancelTapped() {
        print("tapped")
        self.dismiss(animated: true)
    }
    
    @objc func postTapped() {
        if comment.textColor == .secondaryLabel || comment.text.isEmpty {
            comment.text = ""
        }
        guard let courseId = courseId, let userId = UserDefaults.standard.string(forKey: "UserId") else {
            return
        }
        print("\(courseId), \(userId),\(comment.text), \(starNo)" )
        if reviewVCHelper.updateReviewOf(courseId: courseId, userId: userId, as: comment.text, and: starNo) {
            sendNotificationForUpdateReview()
        }
        self.dismiss(animated: true)
    }
    
    func viewConstraints() {
        view.addSubview(starRatingStack)
        view.addSubview(comment)
        view.addSubview(separator)
        
        starRatingStack.addArrangedSubview(starButtonStack)
        starRatingStack.addArrangedSubview(starRatingDescription)
        
        starButtonStack.addArrangedSubview(starButton1)
        starButtonStack.addArrangedSubview(starButton2)
        starButtonStack.addArrangedSubview(starButton3)
        starButtonStack.addArrangedSubview(starButton4)
        starButtonStack.addArrangedSubview(starButton5)
        
        let constraints = [
            starRatingStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starRatingStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            separator.topAnchor.constraint(equalTo: starRatingStack.bottomAnchor, constant: 5),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            comment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            comment.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            comment.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8),
//            comment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func defaultStars() {
        starButton5.setImage(UIImage(systemName: "star"), for: .normal)
        starButton4.setImage(UIImage(systemName: "star"), for: .normal)
        starButton3.setImage(UIImage(systemName: "star"), for: .normal)
        starButton2.setImage(UIImage(systemName: "star"), for: .normal)
        starButton1.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    @objc func ratingTapped(_ button : UIButton) {
        defaultStars()
        starNo = button.tag
        addRating(starNo: starNo)
        rightBarButtonItem.isEnabled = true
    }
    
    func addRating(starNo: Int) {
        switch starNo {
        case 5:
            starButton5.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fallthrough
        case 4:
            starButton4.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fallthrough
        case 3:
            starButton3.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fallthrough
        case 2:
            starButton2.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fallthrough
        case 1:
            starButton1.setImage(UIImage(systemName: "star.fill"), for: .normal)
        default:
            break
        }
    }
    
    private func sendNotificationForUpdateReview() {
           print("Sending Data to Notification Center")
           NotificationCenter.default.post(name: NSNotification.Name("UPDATE_REVIEW"), object: nil)
       }


}

extension AddReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if comment.textColor == UIColor.secondaryLabel {
            comment.text = ""
            comment.textColor = UIColor.label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if comment.text == "" {
            comment.text = "Review"
            comment.textColor = UIColor.lightGray
        }
    }
}
