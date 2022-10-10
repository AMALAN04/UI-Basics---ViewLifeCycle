//
//  FilterViewController.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 02/10/22.
//

import UIKit

class FilterViewController: UIViewController {
    lazy var sortByLabel: UILabel = {
        let textLabel = UILabel()
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .label
        textLabel.font = .boldSystemFont(ofSize: 18)
        textLabel.text = "Sort By"
        textLabel.numberOfLines = 3
        return textLabel
    }()
    
//        lazy var tableViewForFilterOptions: UITableView = {
//            let tableView = UITableView(frame: .zero, style: .grouped)
//            tableView.tag = 1
//            tableView.translatesAutoresizingMaskIntoConstraints = false
//            tableView.register( RadioTableViewCell.self, forCellReuseIdentifier: RadioTableViewCell.identifier)
//            tableView.separatorStyle = .singleLine
//            tableView.delegate = self
//            tableView.dataSource = self
//            return tableView
//        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .systemPurple
        viewConstraints()
    }
    
    lazy var filterView: FilterView = {
       let filterView = FilterView()
        filterView.translatesAutoresizingMaskIntoConstraints =  false
        return filterView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func viewConstraints() {
        view.addSubview(sortByLabel)
//        view.addSubview(tableViewForFilterOptions)
        view.addSubview(filterView)
        
        let constraints = [
            sortByLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            sortByLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
//            tableViewForFilterOptions.topAnchor.constraint(equalTo: sortByLabel.bottomAnchor, constant: 15),
//            tableViewForFilterOptions.leadingAnchor.constraint(equalTo: sortByLabel.leadingAnchor),
//            tableViewForFilterOptions.widthAnchor.constraint(equalToConstant: 200),
//            tableViewForFilterOptions.heightAnchor.constraint(equalToConstant: 200),
            
            filterView.topAnchor.constraint(equalTo: sortByLabel.bottomAnchor, constant: 15),
            filterView.leadingAnchor.constraint(equalTo: sortByLabel.leadingAnchor),
            

        ]
        NSLayoutConstraint.activate(constraints)
    }

}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RadioTableViewCell.identifier, for: indexPath) as! RadioTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemPurple
        let label:UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "Kailasa-Bold", size: 18)
            label.text = "Sort By"
            label.textColor = .label
            return label
        }()
        headerView.addSubview(label)
        let basicHedderConstraints = [
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(basicHedderConstraints)
        return headerView
    }
}
