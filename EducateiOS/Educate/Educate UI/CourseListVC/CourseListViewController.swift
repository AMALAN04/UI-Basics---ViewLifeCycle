//
//  CourseListViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 28/09/22.
//

import UIKit

class CourseListViewController: UIViewController {
    var courseData: [CourseDataModel] = []
    var courseDataSearchResult: [CourseDataModel] = []
    var filterData: [CourseDataModel] = []
    let courseListVCHelper: CourseListVCHelperProtocol = CourseListVCHelper()
    var optionChoosed = Filters._default
    var titleText: String?
    
    lazy var filterButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Filter", image: nil, menu: addMenu())
        return barButton
    }()
    lazy var priceLowToHigh = UIAction(title: "Price: Low to High", handler: { [weak self] _  in
        let optionChoosed = Filters.priceLowToHigh
        self?.optionChoosed = .priceLowToHigh
        self?.changeMenuImage(optionChoosed: optionChoosed)
        self?.reloadTableView()
    })
    
    lazy var bagdge: UILabel = {
        let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 15, height: 15))
        lblBadge.backgroundColor = .red
        lblBadge.clipsToBounds = true
        lblBadge.layer.cornerRadius = 7
        lblBadge.textColor = UIColor.white
        lblBadge.font = .systemFont(ofSize: 10)
        lblBadge.textAlignment = .center
        return lblBadge
    }()
    
    lazy var priceHightoLow = UIAction(title: "Price: High to Low", handler:  { [weak self] _ in
        let optionChoosed = Filters.priceHighToLow
        self?.optionChoosed = .priceHighToLow
        self?.changeMenuImage(optionChoosed: optionChoosed)
        self?.reloadTableView()
    })
    
    lazy var rating = UIAction(title: "Rating",handler: { [weak self] _ in
        let optionChoosed = Filters.rating
        self?.optionChoosed = .rating
        self?.changeMenuImage(optionChoosed: optionChoosed)
        self?.reloadTableView()
    })
    
    lazy var popuraity = UIAction(title: "Popularity", handler: { [weak self] _ in
        let optionChoosed = Filters.popurarity
        self?.optionChoosed = .popurarity
        self?.changeMenuImage(optionChoosed: optionChoosed)
        self?.reloadTableView()
    })
    
    lazy var _default = UIAction(title: "Default", handler: { [weak self] _ in
        let optionChoosed = Filters._default
        self?.optionChoosed = ._default
        self?.changeMenuImage(optionChoosed: optionChoosed)
        self?.reloadTableView()
    })
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.sizeToFit()
        searchController.isActive = true
        searchController.searchBar.delegate =  self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.searchBar.returnKeyType = .search
        return searchController
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register( ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        configureNavigationBar()
        viewConstraints()
//        setupKeyboardHiding()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        tableView.reloadData()
    }
    
//    private func setupKeyboardHiding() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
//    @objc func keyboardWillShow(sender: NSNotification) {
//        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            print(-keyboardSize.height)
//            self.view.frame.origin.y = -keyboardSize.height * 2
//        }
//    }
//
//    @objc func keyboardWillHide() {
//        self.view.frame.origin.y = 0
//    }
    
    func configureNavigationBar() {
        navigationItem.searchController = searchController
        makeMenuImagesToDefault()
        _default.image = UIImage(systemName: "circle.circle.fill")
        filterButton = UIBarButtonItem(title: "Filter", image: nil, menu: addMenu())
        navigationItem.rightBarButtonItem = filterButton
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
    
    func makeMenuImagesToDefault() {
        priceLowToHigh.image = UIImage(systemName: "circle")
        priceHightoLow.image = UIImage(systemName: "circle")
        rating.image = UIImage(systemName: "circle")
        popuraity.image = UIImage(systemName: "circle")
        _default.image = UIImage(systemName: "circle")
    }
    
    func changeMenuImage(optionChoosed: Filters) {
        if optionChoosed != ._default {
            filterButton.tintColor = .systemRed
//            filterButton.customView?.addSubview(bagdge)
        } else {
            filterButton.tintColor = .systemBlue
        }
        makeMenuImagesToDefault()
        
        switch optionChoosed {
        case .priceLowToHigh:
            priceLowToHigh.image = UIImage(systemName: "circle.circle.fill")
        case .priceHighToLow:
            priceHightoLow.image = UIImage(systemName: "circle.circle.fill")
        case .rating:
            rating.image = UIImage(systemName: "circle.circle.fill")
        case .popurarity:
            popuraity.image = UIImage(systemName: "circle.circle.fill")
        case ._default:
            _default.image = UIImage(systemName: "circle.circle.fill")
        }
        
        navigationItem.rightBarButtonItem?.menu = addMenu()
    }
    
    func reloadTableView() {
        filterData = courseListVCHelper.applyFilter(filter: optionChoosed, in: courseDataSearchResult)
        self.tableView.reloadData()
        if tableView.numberOfRows(inSection: 0) != 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func addMenu() -> UIMenu {
        print("Add menu loading")
        let menuItems = UIMenu(title: "Sort by", options: .displayInline, children: [ priceLowToHigh, priceHightoLow, rating, popuraity, _default
        ])
        return menuItems
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let titleText = titleText {
            self.navigationItem.title = titleText
        } else {
            self.navigationItem.title = titleText ?? "Course List"
        }
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @objc func tappedSearch() {
        searchController.isActive =  true
        searchController.searchBar.becomeFirstResponder()
    }
    
}

extension CourseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        loadData(courseDetails: filterData[indexPath.item], cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = CourseDisplayViewController()
        rootVC.courseData = (filterData[indexPath.item])
       navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            return UITableView.automaticDimension
        }
    
}

extension CourseListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        courseDataSearchResult = []
        if searchText == "" {
            courseDataSearchResult =  courseData
            filterData = courseDataSearchResult
        } else {
            for course in courseData {
                if course.courseDetails.courseName.lowercased().contains(searchText.lowercased()) {
                    courseDataSearchResult.append(course)
                }
            }
            filterData = courseListVCHelper.applyFilter(filter: optionChoosed, in: courseDataSearchResult)
            self.tableView.reloadData()
            if tableView.numberOfRows(inSection: 0) != 0 {
                    tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}
