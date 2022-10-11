//
//  InstructorViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 04/10/22.
//

import UIKit

class InstructorViewController: UIViewController {
    
    var instructorDataModel: InstructorDataModel?
    var courseData: [CourseDataModel] = []
    let instructorVCHelper: InstructorVCHelperProtocol = InstructorVCHelper()
    
    var tableViewHeight: NSLayoutConstraint?
    let profileImageDimensions: Int = 100
    
    lazy var scrollView: UIScrollView = {
      let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints =  false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.alignment = .leading
        return stackView
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
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
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
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .systemOrange
        textLabel.font = .boldSystemFont(ofSize: 15)
        textLabel.text = "3.9"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var noOfStudentsForInstructor: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
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

    lazy var noOfCourses: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var noOfStudentsForInstructorLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "Students"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var noOfRatersForInstructorLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "Reviews"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    lazy var noOfCoursesLabbel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "Courses"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var instructorProfileStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var courseStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var ratingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var studentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var dataStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var instructorRatingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var aboutMeLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "About me"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var aboutMeDescription: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    lazy var aboutMeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var tableViewLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        textLabel.text = "My Courses"
        textLabel.numberOfLines = 1
        return textLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register( ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var seeAllCourses: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var tableViewStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Instructor"
        view.backgroundColor = .systemBackground
        courseData = instructorVCHelper.readCourseDatasOfInstructor(id: instructorDataModel?.instructorDetails.userId ?? "demo")
        loadInstructorData()
        viewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("Constant height \(tableView.contentSize.height)")
        self.view.layoutIfNeeded()
        tableViewHeight?.constant = tableView.contentSize.height  
        self.view.layoutIfNeeded()
//        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        tableViewHeight?.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func seeAllTapped() {
        let rootVC = CourseListViewController()
        rootVC.title = "Instructor"
        rootVC.courseData = courseData
        rootVC.courseDataSearchResult = courseData
        rootVC.filterData = courseData
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func loadInstructorData() {
        guard let instructorDataModel = instructorDataModel else {
            return
        }
        let instructorRating = instructorDataModel.instructorRating
        instructorProfileImage.load(urlString: instructorDataModel.instructorDetails.profife)
        instructorNameLabel.text = instructorDataModel.instructorDetails.name
        instructorRatingLabelInFloat.text = "\(instructorDataModel.instructorRating)"
        instructorRatingLabelInStars.attributedText = FiveStarHelper.statRating(ratingValue: instructorRating)
        noOfRatersForInstructor.text = "\(instructorDataModel.noOfRaters)"
        noOfStudentsForInstructor.text = "\(instructorDataModel.noOfStudents)"
        noOfCourses.text = "\(instructorDataModel.noOfCourses)"
        aboutMeDescription.text = instructorDataModel.instructorDetails.aboutMe
    }
    
    func viewConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(instructorProfileStack)
        contentStack.addArrangedSubview(aboutMeStack)
        contentStack.addArrangedSubview(tableViewStack)
        
        instructorProfileStack.addArrangedSubview(instructorProfileImage)
        instructorProfileStack.addArrangedSubview(instructorNameLabel)
        instructorProfileStack.addArrangedSubview(instructorRatingStack)
        instructorProfileStack.addArrangedSubview(dataStack)
        
        dataStack.addArrangedSubview(courseStack)
        dataStack.addArrangedSubview(studentStack)
        dataStack.addArrangedSubview(ratingStack)
        
//        instructorRatingStack.addArrangedSubview(instructorRatingLabelInFloat)
        instructorRatingStack.addArrangedSubview(instructorRatingLabelInStars)
        
        courseStack.addArrangedSubview(noOfCoursesLabbel)
        courseStack.addArrangedSubview(noOfCourses)
        
        studentStack.addArrangedSubview(noOfStudentsForInstructorLabel)
        studentStack.addArrangedSubview(noOfStudentsForInstructor)
        
        ratingStack.addArrangedSubview(noOfRatersForInstructorLabel)
        ratingStack.addArrangedSubview(noOfRatersForInstructor)
        
        aboutMeStack.addArrangedSubview(aboutMeLabel)
        aboutMeStack.addArrangedSubview(aboutMeDescription)
        
        tableViewStack.addArrangedSubview(tableViewLabel)
        tableViewStack.addArrangedSubview(tableView)
        tableViewStack.addArrangedSubview(seeAllCourses)
        
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 600)
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
        contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        instructorProfileStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        instructorProfileImage.widthAnchor.constraint(equalToConstant: CGFloat(profileImageDimensions)),
        instructorProfileImage.heightAnchor.constraint(equalToConstant: CGFloat(profileImageDimensions)),
        
        tableViewHeight!,
        tableView.widthAnchor.constraint(equalTo: contentStack.widthAnchor),

        seeAllCourses.heightAnchor.constraint(equalToConstant: 40),
        seeAllCourses.centerXAnchor.constraint(equalTo: contentStack.centerXAnchor),
        seeAllCourses.widthAnchor.constraint(equalToConstant: 200),
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
}

extension InstructorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if courseData.count < 3 {
            return courseData.count
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        loadData(courseDetails: courseData[indexPath.item], cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = CourseDisplayViewController()
        rootVC.courseData = (courseData[indexPath.item])
       navigationController?.pushViewController(rootVC, animated: true)
    }
    
}
