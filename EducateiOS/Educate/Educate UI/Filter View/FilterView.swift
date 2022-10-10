//
//  FilterView.swift
//  Educate_UI
//
//  Created by amalan-pt5585 on 02/10/22.
//

import UIKit

class FilterView: UIView {

    var filterTableView: UITableView = UITableView(frame: .zero, style: .grouped)
    var defaultValue: Bool = false
    var optionChoosed: Filters = ._default
    let filterTitle: [String] =  ["Price: Low to High", "Price: High to Low", "Rating", "Popularity", "Default"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeTableView()
        addConstraints()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeTableView() {
        filterTableView.translatesAutoresizingMaskIntoConstraints = false
        filterTableView.register( RadioTableViewCell.self, forCellReuseIdentifier: RadioTableViewCell.identifier)
        filterTableView.separatorStyle = .none
        filterTableView.isScrollEnabled = false
        filterTableView.delegate = self
        filterTableView.dataSource = self
    }
    
    func addConstraints() {
        self.addSubview(filterTableView)
        let constraints = [
        filterTableView.topAnchor.constraint(equalTo: self.topAnchor),
        filterTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        filterTableView.heightAnchor.constraint(equalToConstant: 245),
        filterTableView.widthAnchor.constraint(equalToConstant: 200),
        filterTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        filterTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func resetAllOthers(except: Int, tableView: UITableView) {
        for filter in 0...3 {
            if (filter == except) {
                continue
            }
            (tableView.cellForRow(at: IndexPath(row: filter, section: 0))  as! RadioTableViewCell).cellSelected = false
            (tableView.cellForRow(at: IndexPath(row: filter, section: 0))  as! RadioTableViewCell).radioImage.image = UIImage(systemName: "circle")
        }
    }
    
    func getFilterIndex(option: Int) -> Filters {
        switch option {

        case 0:
            return .priceLowToHigh
        case 1:
            return .priceHighToLow
        case 2:
            return .rating
        case 3:
            return .popurarity
        case 4:
            return ._default
        default :
            return ._default
        
        }
    }
}

extension FilterView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RadioTableViewCell.identifier, for: indexPath) as! RadioTableViewCell
        cell.radioButtomLabel.text = filterTitle[indexPath.row]
        if indexPath.row == 4 {
            cell.radioImage.image = UIImage(systemName: "circle.circle.fill")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Sort By"
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .tertiarySystemFill
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
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 2),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(basicHedderConstraints)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = (tableView.cellForRow(at: indexPath) as! RadioTableViewCell)
        cell.selectionStyle = .none
        cell.cellSelected = !cell.cellSelected
        if cell.cellSelected {
            cell.radioImage.image = UIImage(systemName: "circle.circle.fill")
            if indexPath.row != 4 {
                (tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! RadioTableViewCell).radioImage.image = UIImage(systemName: "circle")
            }
            optionChoosed = getFilterIndex(option: indexPath.row)
        } else {
            optionChoosed = ._default
            resetAllOthers(except: indexPath.row, tableView: tableView)
            if indexPath.row != 4 {
                cell.radioImage.image = UIImage(systemName: "circle")
                (tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! RadioTableViewCell).radioImage.image = UIImage(systemName: "circle.circle.fill")
            }
        }
        resetAllOthers(except: indexPath.row, tableView: tableView)
        
        print(optionChoosed)
    }
}


enum Filters: Int, CaseIterable {
    case priceLowToHigh = 0
    case priceHighToLow
    case rating
    case popurarity
    case _default
}


