//
//  ViewController.swift
//  UI Basics - XOX
//
//  Created by amalan-pt5585 on 09/09/22.
//

import UIKit

class ViewController: UIViewController {
    static var playerFlag: Bool = true
    var gameStatusArray: [BoxStatus] = []
    var gameStatusDelegate: GameStatusProtoCol = GameStatus()
    var matchWonByX: Int = 0
    var matchWonByY: Int = 0
    var noOfMatchDraw: Int = 0
    
    lazy var gameTitle: UILabel = {
        let gameTitle = UILabel()
        gameTitle.font = .preferredFont(forTextStyle: .largeTitle)
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
//        gameTitle.font = .systemFont(ofSize: 40)
        gameTitle.textColor = .label
        gameTitle.text =  "..Tic Tac Toe.."
        return gameTitle
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.axis = .vertical
        stackview.spacing = 1
        stackview.distribution = .fillEqually
        return titleStackView
    }()
    
    lazy var turnTitle: UILabel = {
        let gameTitle = UILabel()
        gameTitle.font = .preferredFont(forTextStyle: .body)
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        gameTitle.font = .systemFont(ofSize: 20)
        gameTitle.textColor = .label
        gameTitle.text =  "-X-"
        return gameTitle
    }()
    
    lazy var gameSummary: UILabel = {
        let gameTitle = UILabel()
        gameTitle.font = .preferredFont(forTextStyle: .body)
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        gameTitle.font = .systemFont(ofSize: 20)
        gameTitle.textColor = .label
        gameTitle.numberOfLines = 0
        gameTitle.text =  "X = \(matchWonByX)\n" +
                          "O = \(matchWonByY)\n" +
                          "D = \(noOfMatchDraw)"
        return gameTitle
    }()
    
    lazy var squareFrame: UIView = {
        let squareFrame = UIView()
        squareFrame.translatesAutoresizingMaskIntoConstraints = false
        squareFrame.backgroundColor = .purple
        return squareFrame
    }()
    
    var collectionView: UICollectionView = {
        //        let layout = UICollectionViewFlowLayout()
        let layout = createCompositeLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        gameStatusArray = loadStatusArray()
        addsquareFrameconstraints()
        configureCollectionView()
        collectionViewLayout()
        titleViewLayout()
    }
    
//    override func viewWillLayoutSubviews() {
//        for constraint in squareFrame.constraints {
//            if constraint == .widthAnchor {
//                
//            }
//        }
//    }
    
    static func createCompositeLayout() -> UICollectionViewCompositionalLayout {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let leadingGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: leadingItem, count: 3)
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: leadingGroup, count: 3)

        let section = NSCollectionLayoutSection(group: trailingGroup)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func loadStatusArray () -> [BoxStatus] {
        var statusArray: [BoxStatus] = []
        for _ in 0...8 {
            statusArray.append(.unownedPlace)
        }
        return statusArray
    }
    
    func addsquareFrameconstraints() {
        view.addSubview(squareFrame)
        let squareDimension = calculateSquareFrameDimension()
        let constraints = [
//            squareFrame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            squareFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareFrame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            squareFrame.heightAnchor.constraint(equalToConstant: squareDimension),
            squareFrame.widthAnchor.constraint(equalToConstant: squareDimension),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func calculateSquareFrameDimension() -> CGFloat {
        let textViewHeight = view.safeAreaLayoutGuide.layoutFrame.height / 4
        var squareDimension = view.safeAreaLayoutGuide.layoutFrame.height - textViewHeight
        let viewWidth = view.safeAreaLayoutGuide.layoutFrame.width
        if squareDimension > viewWidth {
            squareDimension = viewWidth
        }
        return squareDimension
    }
    
    func titleViewLayout() {
        view.addSubview(gameTitle)
        view.addSubview(turnTitle)
        view.addSubview(gameSummary)
//
//        view.addSubview(titleStackView)
//        titleStackView.addArrangedSubview(gameTitle)
//        titleStackView.addArrangedSubview(turnTitle)

        let constraints = [
             gameTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             gameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             turnTitle.topAnchor.constraint(equalTo: gameTitle.bottomAnchor, constant: 1),
             turnTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             
             gameSummary.topAnchor.constraint(equalTo: squareFrame.bottomAnchor , constant: 1),
             gameSummary.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
//            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleStackView.bottomAnchor.constraint(equalTo: squareFrame.topAnchor)
 
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func collectionViewLayout() {
        view.addSubview(collectionView)
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: squareFrame.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: squareFrame.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: squareFrame.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: squareFrame.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell
        cell?.backgroundColor = .secondarySystemBackground
        return  cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImgNo = indexPath.row
        print(selectedImgNo)
        let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
        guard cell?.boxStatus == .unownedPlace else {
            return
        }
        if ViewController.playerFlag {
            cell?.imageView.image = UIImage(named: "x.png")?.withTintColor(.systemBlue, renderingMode: .alwaysTemplate)
            cell?.boxStatus = .playerX
            gameStatusArray[indexPath.row] = .playerX
            if let winner = gameStatusDelegate.checkVictory(cells: gameStatusArray) {
                print(winner)
                pushPopUp(title: "\(winner) Wons")
            }
            turnTitle.text = "-O-"
        } else {
            cell?.imageView.image = UIImage(named: "o.png")?.withTintColor(.systemBlue, renderingMode: .alwaysTemplate)
            cell?.boxStatus = .playerO
            gameStatusArray[indexPath.row] = .playerO
            if let winner = gameStatusDelegate.checkVictory(cells: gameStatusArray) {
                print(winner)
                pushPopUp(title: "\(winner) Wons")
            }
            turnTitle.text = "-X-"
        }
        ViewController.playerFlag = !ViewController.playerFlag
        
        if !gameStatusDelegate.gameCompleted(cells: gameStatusArray) {
            print("Reload")
            pushPopUp(title: "GAMAE OVER")
        }
        
    }
    
    func pushPopUp(title: String) {
        let allert = UIAlertController(title: title, message: "Do you like to restart the game ?", preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.reloadGame()
        }))
        allert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { [weak self] action in
            self?.reloadGame() // pop this screen
        }))
        
        present(allert, animated: true)
    }
    
    override func reloadInputViews() {
        super.reloadInputViews()
        print("reload input views")
    }
    
    func reloadGame() {
        gameStatusArray = loadStatusArray()
        ViewController.playerFlag = true
        turnTitle.text = "-X-"
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let cellValue =  collectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? ImageCollectionViewCell
            cellValue?.imageView.image = nil
            cellValue?.boxStatus = .unownedPlace
        }
        print(gameStatusArray)
        
//        let rootVc = ViewController()
//        let navController = UINavigationController(rootViewController: rootVc)
//        navController.modalPresentationStyle = .fullScreen
//        present(navController, animated:  true)
        
    }
    
}
