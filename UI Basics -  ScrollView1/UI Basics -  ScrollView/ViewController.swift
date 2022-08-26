//
//  ViewController.swift
//  UI Basics -  ScrollView
//
//  Created by amalan-pt5585 on 26/08/22.
//

import UIKit

class ViewController: UIViewController {
    let scrollView: UIScrollView = UIScrollView()
    let topLabel: UILabel = UILabel()
    let midLabel: UILabel = UILabel()
    let bottomLabel: UILabel = UILabel()
    let rightMidTop: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewStyle()
        viewLayout()
        // Do any additional setup after loading the view.
    }


}

extension ViewController {
    func viewStyle() {
        view.backgroundColor = .systemPurple
        //scrollView.frame = view.bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemMint
        scrollView.contentSize = CGSize(width: view.frame.size.width * 4, height: view.frame.size.height * 2)
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = .systemFont(ofSize: 20)
        topLabel.font = .preferredFont(forTextStyle: .largeTitle)
        topLabel.textColor = .white
        topLabel.text = "Im at the top"
        
        midLabel.translatesAutoresizingMaskIntoConstraints = false
        midLabel.font = .systemFont(ofSize: 20)
        midLabel.font = .preferredFont(forTextStyle: .largeTitle)
        midLabel.textColor = .white
        midLabel.text = "Im at the mid"
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.font = .systemFont(ofSize: 20)
        bottomLabel.font = .preferredFont(forTextStyle: .largeTitle)
        bottomLabel.textColor = .white
        bottomLabel.text = "Im at the bottom"
        
        rightMidTop.translatesAutoresizingMaskIntoConstraints = false
        rightMidTop.font = .systemFont(ofSize: 20)
        rightMidTop.font = .preferredFont(forTextStyle: .largeTitle)
        rightMidTop.textColor = .white
        rightMidTop.text = "Im at the RTop"
        
        print( scrollView.frame.size.height)
        print(view.frame.size.height)

    }
    
    func viewLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(topLabel)
        scrollView.addSubview(midLabel)
        scrollView.addSubview(bottomLabel)
        scrollView.addSubview(rightMidTop)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 5),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 5),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
//            topLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

//            view.bottomAnchor.constraint(equalToSystemSpacingBelow: midLabel.bottomAnchor, multiplier: 7),
            midLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:  scrollView.contentSize.height / 2),
            midLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            bottomLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant:  scrollView.contentSize.height - bottomLabel.font.lineHeight),
            bottomLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            rightMidTop.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rightMidTop.centerXAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: scrollView.contentSize.width / 2),

        ]
        NSLayoutConstraint.activate(constraints)
    }
}
