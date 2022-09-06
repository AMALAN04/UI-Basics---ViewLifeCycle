//
//  AdvancedViewController.swift
//  UI Basics - TabBar 4
//
//  Created by amalan-pt5585 on 05/09/22.
//

import UIKit

class AdvancedViewController: UIViewController {
    
    var courseImges: [Int: String] = [0: "star", 1: "sun.max", 2: "pc", 3: "wifi",4: "star", 5: "sun.max", 6: "pc", 7: "wifi", 8: "mappin", 9: "homekit"]
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        view.addSubview(tableView)
        configureTableView()
        tableViewLaout()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    func tableViewLaout() {
        view.addSubview(tableView)
        let constrains = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constrains)
    }
}

extension AdvancedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        guard let cell = cell else {return UITableViewCell() }
        cell.textLabel?.text =  "Course Id \(indexPath.row)"
        cell.imageView?.image = UIImage(systemName: "house")
        for index in indexPath {
            let image: String = courseImges[index] ?? "add_circle"
            cell.imageViewOnRight.image = UIImage(systemName: image)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootController =  SelectedCourseController()
        rootController.hidesBottomBarWhenPushed = true
        rootController.setDetails(image: courseImges[indexPath.row] ?? "doc", courseID: indexPath.row)
        //        let navController = UINavigationController(rootViewController: rootController )
        //        navController.modalPresentationStyle = .fullScreen
        //        present(navController, animated: true)
        navigationController?.pushViewController(rootController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

