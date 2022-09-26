//
//  HomeViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 22/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    var imageViewHeight:NSLayoutConstraint?
    
    lazy var  customizedHeaderView: UIView = {
        let customizedView = UIView()
        customizedView.translatesAutoresizingMaskIntoConstraints = false
        customizedView.backgroundColor =  .systemBackground
        return customizedView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.load(urlString: "https://aventislearning.com/wp-content/themes/thrive-theme-child/images/sf/0EM8400000079ml.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var headerViewTitle: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = UIFont(name: "Georgia", size: view.frame.width / 20)
        textLabel.font = textLabel.font.bold()
//        textLabel.font = .preferredFont(forTextStyle: .largeTitle)
        textLabel.text = "Find the right fit"
        textLabel.numberOfLines = 2
        return textLabel
    }()
    
    lazy var headerViewDefenition: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
//        textLabel.font = .preferredFont(forTextStyle: .largeTitle)
        textLabel.text = "Choose from 204,000 online video courses with new additions published every month"
        textLabel.numberOfLines = 2
        return textLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register( TableViewCell.self, forCellReuseIdentifier: TableViewCell.indentifier)
        tableView.separatorColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        setNavigationBarColour()
        tabelViewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageViewHeight?.constant = view.frame.width / 2
        headerViewTitle.font = UIFont(name: "Georgia", size: view.frame.width / 15)
        headerViewTitle.font = headerViewTitle.font.bold()
        headerViewDefenition.font =  UIFont(name: "Thonburi-Light", size: view.frame.width / 30)
    }

    func setNavigationBarColour() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func tabelViewConstraints() {
        view.addSubview(tableView)
        view.addSubview(customizedHeaderView)
        
        customizedHeaderView.addSubview(imageView)
        customizedHeaderView.addSubview(headerViewTitle)
        customizedHeaderView.addSubview(headerViewDefenition)
        
        imageViewHeight = imageView.heightAnchor.constraint(equalToConstant: view.frame.width / 2)
        guard let imageViewHeight = imageViewHeight else {
            return
        }

        let constraints = [
            customizedHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customizedHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            customizedHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: customizedHeaderView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: customizedHeaderView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: customizedHeaderView.trailingAnchor),
            imageViewHeight,
            
            headerViewTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            headerViewTitle.leadingAnchor.constraint(equalTo: customizedHeaderView.leadingAnchor, constant: 10),
            headerViewTitle.trailingAnchor.constraint(equalTo: customizedHeaderView.trailingAnchor, constant: -10),
            
            headerViewDefenition.topAnchor.constraint(equalTo: headerViewTitle.bottomAnchor, constant: 5),
            headerViewDefenition.leadingAnchor.constraint(equalTo: customizedHeaderView.leadingAnchor, constant: 10),
            headerViewDefenition.trailingAnchor.constraint(equalTo: customizedHeaderView.trailingAnchor, constant: -10),
            headerViewDefenition.bottomAnchor.constraint(equalTo: customizedHeaderView.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: customizedHeaderView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("in no of rows")
        return StaticData.sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.indentifier, for: indexPath) as! TableViewCell
        cell.tableViewSectionTitle.text = StaticData.sectionHeaders[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        return (5 * (screenHeight / 15) )
    }
    
    
}
