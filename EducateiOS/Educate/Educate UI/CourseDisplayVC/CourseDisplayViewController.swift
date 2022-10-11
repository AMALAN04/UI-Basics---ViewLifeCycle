//
//  CourseDisplayViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 03/10/22.
//

import UIKit

class CourseDisplayViewController: UIViewController {
    var courseData: CourseDataModel?
    var courseId: Int?
    var instructorId: String?
    var instructorDataModel: InstructorDataModel?
    var courseDisplayVCHelper = CourseDisplayVCHelper()

    var compactConstraints: [NSLayoutConstraint] = []
    var regularConstraints: [NSLayoutConstraint] = []
    
    var courseCoverImageHeight: NSLayoutConstraint?
    let profileImageDimensions: Int = 100
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints =  false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var courseCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var courseTitle: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .boldSystemFont(ofSize: 18)
        textLabel.text = "Swift for life"
        textLabel.numberOfLines = 3
        return textLabel
    }()
    
    lazy var courseOutlook: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.textAlignment = .justified
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.text = "Swift for life"
        textLabel.numberOfLines = 4
        return textLabel
    }()
    
    lazy var instructor: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.text = "Allen Anish"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var instructorName: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("instructorName", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(viewProfileTapped), for: .touchUpInside)
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        button.titleLabel?.attributedText = underlineAttributedString
        return button
    }()
    
    lazy var courseRatingLabelInFloat: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .systemOrange
        textLabel.font = .boldSystemFont(ofSize: 15)
        textLabel.text = "3.9"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var noOfStudents: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var lastUpdatedLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        
        let imageAttachment1 = NSTextAttachment()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 11 , weight: .bold, scale: .large)
        imageAttachment1.image = UIImage(systemName: "exclamationmark.circle.fill", withConfiguration: largeConfig)?.withTintColor(.secondaryLabel)
        let fullString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 15)!])
        fullString.append(NSAttributedString(attachment: imageAttachment1))
        fullString.append(NSAttributedString(string:"  Last update 04/2022"))
        textLabel.attributedText = fullString
        
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var languageLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        
        let imageAttachment1 = NSTextAttachment()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 11 , weight: .bold, scale: .large)
        imageAttachment1.image = UIImage(systemName: "globe", withConfiguration: largeConfig)?.withTintColor(.secondaryLabel)
        let fullString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 15)!])
        fullString.append(NSAttributedString(attachment: imageAttachment1))
        fullString.append(NSAttributedString(string:"  English"))
        textLabel.attributedText = fullString
        
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var closedCaptionLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        
        let imageAttachment1 = NSTextAttachment()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 11 , weight: .bold, scale: .large)
        imageAttachment1.image = UIImage(systemName: "captions.bubble.fill", withConfiguration: largeConfig)?.withTintColor(.secondaryLabel)
        let fullString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 15)!])
        fullString.append(NSAttributedString(attachment: imageAttachment1))
        fullString.append(NSAttributedString(string:"  English"))
        textLabel.attributedText = fullString
        
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var price: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        textLabel.font = textLabel.font.bold()
        textLabel.text = "₹999"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var courseRatingLabelInStars: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.font = textLabel.font.bold()
        textLabel.text = "**"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var courseLabelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var instructorLabelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var ratingLabelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .bottom
        stackView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewReviewTapped))
        stackView.addGestureRecognizer(tap)
        return stackView
    }()
    
    lazy var ratingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var overAllRatingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var overLanguageLabelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var whatYouLearnLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "What you'll learn"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var whatYouLearnLabelDescription: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    lazy var requirementLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "Requirements"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var requirementDescription: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "Description"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var _description: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    lazy var instructorLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "Instructor"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var instructorProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(profileImageDimensions / 2)
        return imageView
    }()
    
    lazy var instructorNameLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var instructorRatingLabelInStars: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.font = textLabel.font.bold()
        textLabel.text = "**"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var instructorRatingLabelInFloat: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .systemOrange
        textLabel.font = .boldSystemFont(ofSize: 15)
        textLabel.text = "3.9"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var noOfStudentsForInstructor: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var noOfRatersForInstructor: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var viewProfile: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.systemPurple.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(viewProfileTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var noOfCourses: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var instructorDetailsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var overAllInstructorView: UIView = {
        let displayView = UILabel()
        displayView.translatesAutoresizingMaskIntoConstraints = false
        displayView.backgroundColor = .systemBackground
        displayView.clipsToBounds = true
        displayView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewProfileTapped))
        displayView.layer.cornerRadius = 10
        displayView.addGestureRecognizer(tap)
        return displayView
    }()
    
    lazy var instructorRatingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var instructorProfileStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var overAllInstructorStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var whatYouLearnStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var requirementStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var descriptionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var basicCourseDataStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.sizeToFit()
        fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name("UPDATE_REVIEW"), object: nil)
        dropShadowIfNeeded()
        viewConstraints()
        loadConstraints()
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        courseCoverImage.layer.cornerRadius = view.frame.width * 0.02
        courseCoverImageHeight?.constant = view.frame.width / 2
    }
    
    @objc func fetchData() {
        guard let instructorId = instructorId, let courseId = courseId else {
            return
        }
        instructorDataModel = courseDisplayVCHelper.fetchInstructorDetails(instructorId: instructorId)
            courseData = courseDisplayVCHelper.courseDetails(courseId: courseId)
        loadData()
        sendNotificationForUpdateReview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        dropShadowIfNeeded()
        layoutTrait(traitCollection: traitCollection)
    }
    
    func dropShadowIfNeeded() {
//        overAllInstructorView.addShadow(offset: CGSize.init(width: 0, height: 4), color: UIColor.label, radius: 2.0, opacity: 0.35)
        DispatchQueue.main.async {
            self.overAllInstructorView.applyShadowWithCornerRadius(color: .gray, opacity: 0.35, radius: 5, edge: AIEdge.All, shadowSpace: 15, cornerRadius: 10)
        }
    }
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    func loadData() {
        guard let courseData = courseData, let instructorDataModel = instructorDataModel else {
            return
        }
        let coursePrice =  round(Float((courseData.courseDetails.price) * 100) / 100.0)
        let courseRating = courseData.rating
        let instructorRating = instructorDataModel.instructorRating
        courseCoverImage.load(urlString: (courseData.courseDetails.courseCover))
        courseTitle.text = courseData.courseDetails.courseName
        courseOutlook.text = courseData.courseDetails.courseOutlook
        instructor.text =  "Created by"
        instructorName.setTitle("\(courseData.instructorName)", for: .normal)
        if courseRating == 0 {
            courseRatingLabelInFloat.text = "Not yet rated"
            courseRatingLabelInStars.attributedText = nil
            noOfStudents.text = nil
            if courseData.noOfStudents >= 1 {
                noOfStudents.text = "\(courseData.noOfStudents) \(Helper.pluralsProvider(for: "student", has: courseData.noOfStudents , 1))"
            }
        } else {
            courseRatingLabelInFloat.text = "\(courseData.rating)"
            courseRatingLabelInStars.attributedText = FiveStarHelper.statRating(ratingValue: courseData.rating)
            noOfStudents.text =  "(\(String(describing: courseData.noOfRaters)) \(Helper.pluralsProvider(for: "review", has: courseData.noOfRaters , 1))) \(courseData.noOfStudents) \(Helper.pluralsProvider(for: "student", has: courseData.noOfStudents , 1))"
        }
        price.text = "₹\(coursePrice)"
        whatYouLearnLabelDescription.text = courseData.courseDetails.whatYouLearn
        requirementDescription.text = courseData.courseDetails.prerequisite
        _description.text = courseData.courseDetails.description
        
        instructorProfileImage.load(urlString: instructorDataModel.instructorDetails.profife)
        instructorNameLabel.text = courseData.instructorName
        instructorRatingLabelInFloat.text = "\(instructorDataModel.instructorRating)"
        instructorRatingLabelInStars.attributedText = FiveStarHelper.statRating(ratingValue: instructorRating)
        noOfRatersForInstructor.text = "\(instructorDataModel.noOfRaters) \(Helper.pluralsProvider(for: "Review", has: instructorDataModel.noOfRaters , 1))"
        noOfStudentsForInstructor.text = "\(instructorDataModel.noOfStudents) \(Helper.pluralsProvider(for: "Student", has: instructorDataModel.noOfRaters , 1))"
        noOfCourses.text = "\(instructorDataModel.noOfCourses) \(Helper.pluralsProvider(for: "Course", has: instructorDataModel.noOfCourses , 1))"
    }
    
    func loadConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        compactConstraints = [
            instructorProfileStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            courseCoverImageHeight!,
        ]
        
        regularConstraints = [
            courseCoverImage.widthAnchor.constraint(equalToConstant: 1.6 * (screenWidth / 3.5)),
            courseCoverImage.heightAnchor.constraint(equalToConstant: (screenWidth / 3.5)),
        ]
    }

    func viewConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStack)
        contentStack.addArrangedSubview(basicCourseDataStack)
        contentStack.addArrangedSubview(whatYouLearnStack)
        contentStack.addArrangedSubview(requirementStack)
        contentStack.addArrangedSubview(descriptionStack)
        contentStack.addArrangedSubview(overAllInstructorView)
        
        basicCourseDataStack.addArrangedSubview(courseCoverImage)
        basicCourseDataStack.addArrangedSubview(courseLabelStack)
        
        courseLabelStack.addArrangedSubview(courseTitle)
        courseLabelStack.addArrangedSubview(courseOutlook)
        courseLabelStack.addArrangedSubview(overAllRatingStack)
        courseLabelStack.addArrangedSubview(noOfStudents)
        courseLabelStack.addArrangedSubview(instructorLabelStack)
        courseLabelStack.addArrangedSubview(overLanguageLabelStack)
        courseLabelStack.addArrangedSubview(price)
        
        overAllRatingStack.addArrangedSubview(ratingStack)
        
        ratingStack.addArrangedSubview(ratingLabelStack)
        ratingStack.addArrangedSubview(noOfStudents)
//        ratingStack.addArrangedSubview(viewRating)
        
        overLanguageLabelStack.addArrangedSubview(lastUpdatedLabel)
        overLanguageLabelStack.addArrangedSubview(languageLabel)
        overLanguageLabelStack.addArrangedSubview(closedCaptionLabel)
        
        ratingLabelStack.addArrangedSubview(courseRatingLabelInFloat)
        ratingLabelStack.addArrangedSubview(courseRatingLabelInStars)
        
        instructorLabelStack.addArrangedSubview(instructor)
        instructorLabelStack.addArrangedSubview(instructorName)
        
        whatYouLearnStack.addArrangedSubview(whatYouLearnLabel)
        whatYouLearnStack.addArrangedSubview(whatYouLearnLabelDescription)
        
        requirementStack.addArrangedSubview(requirementLabel)
        requirementStack.addArrangedSubview(requirementDescription)
        
        descriptionStack.addArrangedSubview(descriptionLabel)
        descriptionStack.addArrangedSubview(_description)
        
        overAllInstructorView.addSubview(overAllInstructorStack)
        
        overAllInstructorStack.addArrangedSubview(instructorLabel)
        overAllInstructorStack.addArrangedSubview(instructorProfileStack)
        
        instructorProfileStack.addArrangedSubview(instructorProfileImage)
        instructorProfileStack.addArrangedSubview(instructorDetailsStack)
//        instructorProfileStack.addArrangedSubview(viewProfile)
        
        instructorDetailsStack.addArrangedSubview(instructorNameLabel)
        instructorDetailsStack.addArrangedSubview(instructorRatingStack)
        instructorDetailsStack.addArrangedSubview(noOfRatersForInstructor)
        instructorDetailsStack.addArrangedSubview(noOfStudentsForInstructor)
        instructorDetailsStack.addArrangedSubview(noOfCourses)
        
        instructorRatingStack.addArrangedSubview(instructorRatingLabelInFloat)
        instructorRatingStack.addArrangedSubview(instructorRatingLabelInStars)
        
        courseCoverImageHeight =  courseCoverImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            overAllInstructorView.topAnchor.constraint(equalTo: overAllInstructorStack.topAnchor, constant: -10),
            overAllInstructorView.leadingAnchor.constraint(equalTo: overAllInstructorStack.leadingAnchor, constant: -4),
            overAllInstructorView.bottomAnchor.constraint(equalTo: overAllInstructorStack.bottomAnchor, constant: 10),
            overAllInstructorView.trailingAnchor.constraint(equalTo: overAllInstructorStack.trailingAnchor, constant: 4),
            
            
            instructorProfileImage.widthAnchor.constraint(equalToConstant: CGFloat(profileImageDimensions)),
            instructorProfileImage.heightAnchor.constraint(equalToConstant: CGFloat(profileImageDimensions)),
            
            //            instructorProfileStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            overAllRatingStack.spacing = 20
            basicCourseDataStack.axis = .vertical
            overLanguageLabelStack.axis = .vertical
            ratingStack.axis = .vertical
            overAllRatingStack.axis = .horizontal
            instructorProfileStack.axis = .vertical
            instructorDetailsStack.alignment = .center
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            overAllRatingStack.spacing = 8
            basicCourseDataStack.axis = .horizontal
            overLanguageLabelStack.axis = .horizontal
            ratingStack.axis = .horizontal
            overAllRatingStack.axis = .vertical
            instructorProfileStack.axis = .horizontal
            instructorDetailsStack.alignment = .leading
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    @objc func viewProfileTapped() {
        let rootVC = InstructorViewController()
        rootVC.instructorDataModel = instructorDataModel
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc func viewReviewTapped() {
        let rootVC = ReviewViewController()
        rootVC.titleText = "Review"
        rootVC.courseId = courseData?.courseDetails.courseId
        rootVC.courseRating = courseData?.rating
        rootVC.courseName = courseData?.courseDetails.courseName
        rootVC.coursePurchased = courseData?.purchasedStatus ?? false
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    private func sendNotificationForUpdateReview() {
           print("Sending Data to Notification Center")
        NotificationCenter.default.post(name: NSNotification.Name("UPDATE_HEADER"), object: nil, userInfo: ["rating": courseData?.rating ?? 0])
       }
    
}

extension CourseDisplayViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.scrollView.contentOffset.y > self.basicCourseDataStack.frame.height / 2) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.topItem?.title = courseTitle.text
        } else {
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.navigationBar.topItem?.title = nil
        }
    }
}


