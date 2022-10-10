//
//  HomeViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

//import UIKit
//
//class HomeViewController: UIViewController {
//    var imageViewHeight:NSLayoutConstraint?
//    var tableViewHeight:NSLayoutConstraint?
//    
//    lazy var  customizedAdView: UIView = {
//        let customizedView = UIView()
//        customizedView.translatesAutoresizingMaskIntoConstraints = false
//        customizedView.backgroundColor =  .systemBackground
//        return customizedView
//    }()
//    
//    lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .clear
//        scrollView.showsHorizontalScrollIndicator =  false
//        scrollView.showsVerticalScrollIndicator = false
//        return scrollView
//    }()
//    
//    lazy var imageViewForAd: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.load(urlString: "https://aventislearning.com/wp-content/themes/thrive-theme-child/images/sf/0EM8400000079ml.jpg")
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//    
//    lazy var adViewTitle: UILabel = {
//        let textLabel = UILabel()
//        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.textColor = .label
//        textLabel.font = UIFont(name: "Georgia", size: 20)
//        textLabel.font = textLabel.font.bold()
//        textLabel.text = "Find the right fit"
//        textLabel.numberOfLines = 2
//        return textLabel
//    }()
//    
//    lazy var adViewDefenition: UILabel = {
//        let textLabel = UILabel()
//        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.textColor = .label
//        textLabel.font =  UIFont(name: "Thonburi-Light", size: 15)
//        textLabel.text = """
//Choose from 204,000 online video courses with new additions published every month
//"""
//        textLabel.numberOfLines = 4
//        return textLabel
//    }()
//    
//    lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register( TableViewCell.self, forCellReuseIdentifier: TableViewCell.indentifier)
//        tableView.separatorColor = .systemBackground
//        tableView.backgroundColor = .systemBackground
//        tableView.showsHorizontalScrollIndicator = false
//        tableView.showsVerticalScrollIndicator = false
//        tableView.isScrollEnabled = false
//        tableView.delegate = self
//        tableView.dataSource = self
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Home"
//        view.backgroundColor = .systemBackground
//        setNavigationBarColour()
//        viewConstraints()
//        tableView.reloadData()
//    }
//    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        imageViewHeight?.constant = view.frame.width / 2
//        tableView.reloadData()
//        tableView.layoutIfNeeded()
//        tableViewHeight!.constant = tableView.contentSize.height
//        print(tableView.contentSize.height)
//    }
//    
//    func setNavigationBarColour() {
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = UIColor.systemBackground
//        navigationController?.navigationBar.compactAppearance = appearance
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//    }
//    
//    func viewConstraints() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(customizedAdView)
//        scrollView.addSubview(tableView)
//        
//        customizedAdView.addSubview(imageViewForAd)
//        customizedAdView.addSubview(adViewTitle)
//        customizedAdView.addSubview(adViewDefenition)
//        
//        imageViewHeight = imageViewForAd.heightAnchor.constraint(equalToConstant: view.frame.width / 2)
//        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 2000)
//        guard let imageViewHeight = imageViewHeight else {
//            return
//        }
//        
//        let constraints = [
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            customizedAdView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            customizedAdView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            customizedAdView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            
//            imageViewForAd.topAnchor.constraint(equalTo: customizedAdView.topAnchor),
//            imageViewForAd.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor),
//            imageViewForAd.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor),
//            imageViewHeight,
//            
//            adViewTitle.topAnchor.constraint(equalTo: imageViewForAd.bottomAnchor, constant: 10),
//            adViewTitle.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor, constant: 10),
//            adViewTitle.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor, constant: -10),
//            
//            adViewDefenition.topAnchor.constraint(equalTo: adViewTitle.bottomAnchor, constant: 5),
//            adViewDefenition.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor, constant: 10),
//            adViewDefenition.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor, constant: -10),
//            adViewDefenition.bottomAnchor.constraint(equalTo: customizedAdView.bottomAnchor),
//            
//            tableView.topAnchor.constraint(equalTo: customizedAdView.bottomAnchor, constant: 10),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableViewHeight!,
//            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            
//        ]
//        NSLayoutConstraint.activate(constraints)
//    }
//    
//}
//
//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return CategoryHelper.sectionHeaders.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.indentifier, for: indexPath) as! TableViewCell
//        cell.tableViewSectionTitle.text = CategoryHelper.sectionHeaders[indexPath.item]
//        cell.tableViewRowNo = indexPath.item
//        print("Table View cell row no =  \(indexPath.item)")
//        let category: Category = CategoryHelper.categoryProvider(categoryId: indexPath.row)
//        let courseData = InstanceProvider.courseDataReader.readCourseDatasOf(category: category)
//        print("Table View cell count =  \(courseData.count)")
//            CategoryHelper.loadData(courseDetails: courseData, category: category)
//        cell.noOfItemsInSection = courseData.count
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//}



//import UIKit
//
//class HomeViewController: UIViewController {
//    var imageViewHeight:NSLayoutConstraint?
//    var tableViewHeight:NSLayoutConstraint?
//    var categoryWiseCourseData: [[CourseDataModel]] = []
//
//    lazy var  customizedAdView: UIView = {
//        let customizedView = UIView()
//        customizedView.translatesAutoresizingMaskIntoConstraints = false
//        customizedView.backgroundColor =  .systemBackground
//        return customizedView
//    }()
//
//    lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .clear
//        scrollView.showsHorizontalScrollIndicator =  false
//        scrollView.showsVerticalScrollIndicator = false
//        return scrollView
//    }()
//
//    lazy var imageViewForAd: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.load(urlString: "https://aventislearning.com/wp-content/themes/thrive-theme-child/images/sf/0EM8400000079ml.jpg")
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    lazy var adViewTitle: UILabel = {
//        let textLabel = UILabel()
//        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.textColor = .label
//        textLabel.font = UIFont(name: "Georgia", size: 20)
//        textLabel.font = textLabel.font.bold()
//        textLabel.text = "Find the right fit"
//        textLabel.numberOfLines = 2
//        return textLabel
//    }()
//
//    lazy var adViewDefenition: UILabel = {
//        let textLabel = UILabel()
//        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.textColor = .label
//        textLabel.font =  UIFont(name: "Thonburi-Light", size: 15)
//        textLabel.text = """
//Choose from 204,000 online video courses with new additions published every month
//"""
//        textLabel.numberOfLines = 4
//        return textLabel
//    }()
//
//    lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register( TableViewCell.self, forCellReuseIdentifier: TableViewCell.indentifier)
//        tableView.separatorColor = .systemBackground
//        tableView.backgroundColor = .systemBackground
//        tableView.showsHorizontalScrollIndicator = false
//        tableView.showsVerticalScrollIndicator = false
//        tableView.isScrollEnabled = false
//        tableView.delegate = self
//        tableView.dataSource = self
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let tableViewLoader =  HomeVCHelper()
//        tableViewLoader.loadCourseDataIn(homeViewController: self)
//        title = "Home"
//        view.backgroundColor = .systemBackground
//        setNavigationBarColour()
//        viewConstraints()
//        tableView.reloadData()
//    }
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        imageViewHeight?.constant = view.frame.width / 2
//        tableView.reloadData()
//        tableView.layoutIfNeeded()
//        tableViewHeight!.constant = tableView.contentSize.height
//        print(tableView.contentSize.height)
//    }
//
//    func setNavigationBarColour() {
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = UIColor.systemBackground
//        navigationController?.navigationBar.compactAppearance = appearance
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//    }
//
//    func viewConstraints() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(customizedAdView)
//        scrollView.addSubview(tableView)
//
//        customizedAdView.addSubview(imageViewForAd)
//        customizedAdView.addSubview(adViewTitle)
//        customizedAdView.addSubview(adViewDefenition)
//
//        imageViewHeight = imageViewForAd.heightAnchor.constraint(equalToConstant: view.frame.width / 2)
//        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 2000)
//        guard let imageViewHeight = imageViewHeight else {
//            return
//        }
//
//        let constraints = [
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            customizedAdView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            customizedAdView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            customizedAdView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//
//            imageViewForAd.topAnchor.constraint(equalTo: customizedAdView.topAnchor),
//            imageViewForAd.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor),
//            imageViewForAd.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor),
//            imageViewHeight,
//
//            adViewTitle.topAnchor.constraint(equalTo: imageViewForAd.bottomAnchor, constant: 10),
//            adViewTitle.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor, constant: 10),
//            adViewTitle.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor, constant: -10),
//
//            adViewDefenition.topAnchor.constraint(equalTo: adViewTitle.bottomAnchor, constant: 5),
//            adViewDefenition.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor, constant: 10),
//            adViewDefenition.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor, constant: -10),
//            adViewDefenition.bottomAnchor.constraint(equalTo: customizedAdView.bottomAnchor),
//
//            tableView.topAnchor.constraint(equalTo: customizedAdView.bottomAnchor, constant: 10),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableViewHeight!,
//            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//
//        ]
//        NSLayoutConstraint.activate(constraints)
//    }
//
//}
//
//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return CategoryHelper.sectionHeaders.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.indentifier, for: indexPath) as! TableViewCell
//        cell.courseData = categoryWiseCourseData[indexPath.section]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Kailasa-Bold", size: 20)
//        label.text = CategoryHelper.sectionHeaders[section]
//        label.textColor = .label
//        headerView.addSubview(label)
//        let constraints = [
//            label.topAnchor.constraint(equalTo: headerView.topAnchor),
//            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5),
//            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
//            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
//        ]
//        NSLayoutConstraint.activate(constraints)
//        return headerView
//    }
//
//}
