//
//  HomeViewController1.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 28/09/22.
//


import UIKit

class HomeViewController: UIViewController, HomeViewControllerDelegate {
    var imageViewHeight:NSLayoutConstraint?
    var categoryWiseCourseData: [[CourseDataModel]] = []
    var homeVCHelper: HomeVCHelperProtocol = HomeVCHelper()
    let courseListController = CourseListViewController()
    let tableViewLoader = HomeVCHelper()
    
    var filterButton: UIButton!
    
    //    lazy var searchController: UISearchController = {
    //
    //        let searchController = UISearchController(searchResultsController: courseListController)
    //        searchController.searchBar.sizeToFit()
    //        let textFieldInsideSearchBar = searchController.value(forKey: "searchField") as? UITextField
    //        courseListController.courseData =  categoryWiseCourseData[1]
    //        searchController.isActive = true
    //        searchController.showsSearchResultsController = true
    //        searchController.searchBar.delegate =  courseListController
    //        searchController.obscuresBackgroundDuringPresentation = false
    //        searchController.searchBar.enablesReturnKeyAutomatically = true
    //        filterButton =  textFieldInsideSearchBar?.value(forKey: "bookmark") as? UIButton
    //        searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .bookmark, state: .normal)
    //        return searchController
    //    }()
    
    lazy var  customizedAdView: UIView = {
        let customizedView = UIView()
        customizedView.translatesAutoresizingMaskIntoConstraints = false
        customizedView.backgroundColor =  .systemBackground
        return customizedView
    }()
    
    lazy var imageViewForAd: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.load(urlString: "https://aventislearning.com/wp-content/themes/thrive-theme-child/images/sf/0EM8400000079ml.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var adViewTitle: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = UIFont(name: "Georgia", size: 20)
        textLabel.font = textLabel.font.bold()
        textLabel.text = "Find the right fit"
        textLabel.numberOfLines = 2
        return textLabel
    }()
    
    lazy var adViewDefenition: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font =  UIFont(name: "Thonburi-Light", size: 15)
        textLabel.text = """
Choose from 204,000 online video courses with new additions published every month
"""
        textLabel.numberOfLines = 4
        return textLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register( HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.indentifier)
        tableView.separatorColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name("UPDATE_REVIEW"), object: nil)
//        tableViewLoader.loadCourseDataIn(homeViewController: self)
        fetchData()
        tableView.reloadData()
        title = "Home"
        view.backgroundColor = .systemBackground
        setNavigationBarColour()
        viewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageViewHeight?.constant = view.frame.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Home"
    }
    
    @objc func fetchData() {
        categoryWiseCourseData = []
        tableViewLoader.loadCourseDataIn(homeViewController: self)
        tableView.reloadData()
        print("reloaded in home view")
        
    }
    
    func setDelegate() {
        homeVCHelper.homeVCDelegate = self
    }
    
    func setNavigationBarColour() {
        let appearance = UINavigationBarAppearance()
        //        navigationItem.searchController = searchController
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = .clear
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func viewConstraints() {
        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func moveOnProductDetails(tableIndex: Int, collectionIndex: Int) {
        let rootVC = CourseDisplayViewController()
        rootVC.courseId = (categoryWiseCourseData[tableIndex])[collectionIndex].courseDetails.courseId
        rootVC.instructorId = (categoryWiseCourseData[tableIndex])[collectionIndex].courseDetails.instructorId
        navigationController?.pushViewController(rootVC, animated: true)
        print("\(tableIndex)")
        
    }
    
    @objc func showMoreArrowTapped(button: UIButton) {
        let rootVC = CourseListViewController()
        let section = button.tag
        rootVC.titleText =  Helper.sectionHeaders[section]
        rootVC.category = Helper.categoryProvider(categoryId: button.tag + 1)
        rootVC.courseData =  categoryWiseCourseData[section]
        rootVC.courseDataSearchResult =  rootVC.courseData
        rootVC.filterData = rootVC.courseDataSearchResult
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Helper.sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.indentifier, for: indexPath) as! HomeTableViewCell
        cell.tableViewRowNo =  indexPath.section
        cell.courseData = categoryWiseCourseData[indexPath.section]
        cell.didSelect = { tabIndex, colIndex in
            if let tableIndex = tabIndex, let collectionIndex = colIndex {
                self.moveOnProductDetails(tableIndex: tableIndex, collectionIndex: collectionIndex)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label:UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "Kailasa-Bold", size: 20)
            label.text = Helper.sectionHeaders[section]
            label.textColor = .label
            return label
        }()
        
        let arrowButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = section
            let imageAttachment1 = NSTextAttachment()
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 10 , weight: .bold, scale: .large)
            imageAttachment1.image = UIImage(systemName: "chevron.right", withConfiguration: largeConfig)?.withTintColor(.secondaryLabel)
            let fullString = NSMutableAttributedString(string: "Show all  ", attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 15)!])
            fullString.addAttributes([.baselineOffset : -2], range: NSRange(location: 0, length: fullString.length))
            fullString.append(NSAttributedString(attachment: imageAttachment1))
            
            button.setAttributedTitle(fullString, for: .normal)
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.addTarget(self, action: #selector(showMoreArrowTapped), for: .touchUpInside)  // add selector
            return button
        }()
        headerView.addSubview(label)
        headerView.addSubview(arrowButton)
        let basicHedderConstraints = [
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            arrowButton.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(basicHedderConstraints)
        if section == 0 {
            imageViewHeight = imageViewForAd.heightAnchor.constraint(equalToConstant: view.frame.width / 2)
            guard let imageViewHeight = imageViewHeight else {
                return headerView
            }
            headerView.addSubview(customizedAdView)
            NSLayoutConstraint.deactivate(basicHedderConstraints)
            customizedAdView.addSubview(imageViewForAd)
            customizedAdView.addSubview(adViewTitle)
            customizedAdView.addSubview(adViewDefenition)
            let adIncludedHeaderViewConstraints = [
                customizedAdView.topAnchor.constraint(equalTo: headerView.topAnchor),
                customizedAdView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                customizedAdView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                
                imageViewForAd.topAnchor.constraint(equalTo: customizedAdView.topAnchor),
                imageViewForAd.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor),
                imageViewForAd.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor),
                imageViewHeight,
                
                adViewTitle.topAnchor.constraint(equalTo: imageViewForAd.bottomAnchor, constant: 10),
                adViewTitle.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor, constant: 14),
                adViewTitle.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor, constant: -10),
                
                adViewDefenition.topAnchor.constraint(equalTo: adViewTitle.bottomAnchor, constant: 5),
                adViewDefenition.leadingAnchor.constraint(equalTo: customizedAdView.leadingAnchor, constant: 14),
                adViewDefenition.trailingAnchor.constraint(equalTo: customizedAdView.trailingAnchor, constant: -10),
                adViewDefenition.bottomAnchor.constraint(equalTo: customizedAdView.bottomAnchor),
                
                label.topAnchor.constraint(equalTo: adViewDefenition.bottomAnchor, constant: 30),
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
                arrowButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
                arrowButton.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: -6)
                
            ]
            NSLayoutConstraint.activate(adIncludedHeaderViewConstraints)
        }
        return headerView
    }
    
}
