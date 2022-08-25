//
//  ViewController.swift
//  UI Basics - TabelView3
//
//  Created by amalan-pt5585 on 25/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewStyle()
        tabelViewConstraints()
    }
    
}

extension ViewController {
    func tableViewStyle() {
        view.backgroundColor = .purple
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //        tabelView.rowHeight = view.layer.borderWidth / 3
        tableView.register( UITaleCell.self, forCellReuseIdentifier: UITaleCell.indentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
    }
    
    func tabelViewConstraints() {
        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITaleCell.indentifier, for: indexPath) as? UITaleCell
        if indexPath.row % 2 == 0{
            cell?.configureImage(imageName: "circle.fill")
        } else {
            cell?.configureImage(imageName: "square")
        }
        print("Hai")
        return cell!
    }
    
}
