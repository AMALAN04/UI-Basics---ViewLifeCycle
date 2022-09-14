//
//  ViewController.swift
//  UI Basics - XOX
//
//  Created by amalan-pt5585 on 09/09/22.
//

import UIKit

class ViewController: UIViewController {
    var gameSummary = GameSummary()
    var gameStatusArray: [BoxStatus] = []
    var gameStatusDelegate: GameStatusProtoCol = GameStatus()
    
    var leadingAnchor: NSLayoutConstraint?
    var trailingAnchor: NSLayoutConstraint?
    var topAnchor: NSLayoutConstraint?
    var bottomAnchor: NSLayoutConstraint?
    var widthAnchor: NSLayoutConstraint?
    
    lazy var animateView: UIView = {
        let animatedView = UIView()
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        animatedView.layer.cornerRadius = 5
        animatedView.backgroundColor = .red
        return animatedView
        
    }()
    
    lazy var gameTitle: UILabel = {
        let gameTitle = UILabel()
        gameTitle.font = .preferredFont(forTextStyle: .largeTitle)
        gameTitle.translatesAutoresizingMaskIntoConstraints = false
        gameTitle.textColor = .label
        gameTitle.text =  "..TIC TAC TOE.."
        return gameTitle
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.axis = .vertical
        stackview.spacing = 1
        stackview.distribution = .fillEqually
        return stackview
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
    
    lazy var winsByX: UILabel = {
        let winsByX = UILabel()
        winsByX.font = .preferredFont(forTextStyle: .body)
        winsByX.translatesAutoresizingMaskIntoConstraints = false
        winsByX.adjustsFontSizeToFitWidth = true
        winsByX.minimumScaleFactor = 0.5
        winsByX.numberOfLines = 0
        winsByX.lineBreakMode = .byClipping
        winsByX.sizeToFit()
        winsByX.text = "X = \(gameSummary.matchWonByX)"
        winsByX.textColor = .label
        return winsByX
    }()
    
    lazy var winsByY: UILabel = {
        let winsByY = UILabel()
        winsByY.font = .preferredFont(forTextStyle: .body)
        winsByY.translatesAutoresizingMaskIntoConstraints = false
        winsByY.adjustsFontSizeToFitWidth = true
        winsByY.numberOfLines = 0
        winsByY.sizeToFit()
        winsByY.text = "Y = \(gameSummary.matchWonByY)"
        winsByY.textColor = .label
        return winsByY
    }()
    
    lazy var draw: UILabel = {
        let draw = UILabel()
        draw.font = .preferredFont(forTextStyle: .body)
        draw.translatesAutoresizingMaskIntoConstraints = false
        draw.adjustsFontSizeToFitWidth = true
        draw.numberOfLines =  0
        draw.sizeToFit()
        draw.text = "D = \(gameSummary.noOfMatchDraw)"
        draw.textColor = .label
        return draw
    }()
    
    lazy var gameSummaryStack: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        return stackview
    }()
    
    lazy var squareFrame: UIView = {
        let squareFrame = UIView()
        squareFrame.translatesAutoresizingMaskIntoConstraints = false
        squareFrame.backgroundColor = .purple
        return squareFrame
    }()
    
    var collectionView: UICollectionView = {
        let layout = createCompositeLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        return backButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        gameStatusArray = loadStatusArray()
        addsquareFrameconstraints()
        configureCollectionView()
        collectionViewLayout()
        titleViewLayout()
        summaryLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.deactivate(squareFrame.constraints)
        addsquareFrameconstraints()
        collectionViewLayout()
    }
    
    static func createCompositeLayout() -> UICollectionViewCompositionalLayout {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let leadingGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: leadingItem, count: 3)
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: leadingGroup, count: 3)
        
        let section = NSCollectionLayoutSection(group: trailingGroup)
        return UICollectionViewCompositionalLayout(section: section)
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
        print("Before change \(squareDimension)")
        let constraints = [
            squareFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareFrame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            squareFrame.heightAnchor.constraint(equalToConstant: squareDimension),
            squareFrame.widthAnchor.constraint(equalToConstant: squareDimension),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    func titleViewLayout() {
        view.addSubview(titleStackView)
        titleStackView.addArrangedSubview(gameTitle)
        titleStackView.addArrangedSubview(turnTitle)
        
        let constraints = [
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: squareFrame.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func summaryLayout() {
        view.addSubview(gameSummaryStack)
        
        gameSummaryStack.addArrangedSubview(winsByX)
        gameSummaryStack.addArrangedSubview(draw)
        gameSummaryStack.addArrangedSubview(winsByY)
        let constraints = [
            gameSummaryStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameSummaryStack.topAnchor.constraint(equalTo: squareFrame.bottomAnchor, constant: 3),
            gameSummaryStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gameSummaryStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gameSummaryStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            winsByX.leadingAnchor.constraint(equalTo: gameSummaryStack.leadingAnchor),
            winsByY.trailingAnchor.constraint(equalTo: gameSummaryStack.trailingAnchor),
            draw.centerXAnchor.constraint(equalTo: gameSummaryStack.centerXAnchor)
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
        if gameSummary.playerFlag {
            cell?.imageView.image = UIImage(named: "x.png")?.withTintColor(.systemBlue, renderingMode: .alwaysTemplate)
            cell?.boxStatus = .playerX
            gameStatusArray[indexPath.row] = .playerX
            let winnerDetails = gameStatusDelegate.checkVictory(cells: gameStatusArray)
            if let winner = winnerDetails.winnerTeam {
                print(winner)
                gameSummary.matchWonByX = gameSummary.matchWonByX + 1
                handleTapAnimations(possible: winnerDetails.possible!, winnerTeam: "Winner X")
//                pushPopUp(title: "WINNER:\"X\"")
            }
            turnTitle.text = "-O-"
        } else {
            cell?.imageView.image = UIImage(named: "o.png")?.withTintColor(.systemBlue, renderingMode: .alwaysTemplate)
            cell?.boxStatus = .playerO
            gameStatusArray[indexPath.row] = .playerO
            let winnerDetails = gameStatusDelegate.checkVictory(cells: gameStatusArray)
            if let winner = winnerDetails.winnerTeam {
                print(winner)
                gameSummary.matchWonByY = gameSummary.matchWonByY + 1
                handleTapAnimations(possible: winnerDetails.possible!, winnerTeam: "Winner O")
//                pushPopUp(title: "WINNER:\"O\"")
            }
            turnTitle.text = "-X-"
        }
        gameSummary.playerFlag = !gameSummary.playerFlag
        
        if !gameStatusDelegate.gameCompleted(cells: gameStatusArray) {
            print("Reload")
            gameSummary.noOfMatchDraw = gameSummary.noOfMatchDraw + 1
            pushPopUp(title: "GAME OVER")
        }
        
    }
}

extension ViewController {
    
    @objc func cancelTapped() {
        let alert = UIAlertController(title: title, message: "..TIC TAC TOE..", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { [weak self] action in
            self?.reloadGame()// pop this screen
        }))
        present(alert, animated: true)
    }
    
    func pushPopUp(title: String) {
        let alert = UIAlertController(title: title, message: "Do you like to restart the game ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { [weak self] action in
            self?.reloadGame()// pop this screen
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.ContinueGame()
        }))
        present(alert, animated: true)
    }
    
    func ContinueGame() {
        gameStatusArray = loadStatusArray()
        animateView.removeFromSuperview()
        gameSummary.playerFlag = true
        turnTitle.text = "-X-"
        winsByX.text = "X = \(gameSummary.matchWonByX)"
        winsByY.text = "Y = \(gameSummary.matchWonByY)"
        draw.text = "D = \(gameSummary.noOfMatchDraw)"
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let cellValue =  collectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? ImageCollectionViewCell
            cellValue?.imageView.image = nil
            cellValue?.boxStatus = .unownedPlace
        }
        print(gameStatusArray)
    }
    
    func reloadGame() {
        self.dismiss(animated: true)
    }
    
    func animateViewLayout() {
        collectionView.addSubview(animateView)

        leadingAnchor = animateView.leadingAnchor.constraint(equalTo: squareFrame.leadingAnchor, constant: 0)
        trailingAnchor = animateView.trailingAnchor.constraint(equalTo: animateView.leadingAnchor, constant: 10)
        topAnchor = animateView.topAnchor.constraint(equalTo: squareFrame.topAnchor)
        bottomAnchor = animateView.bottomAnchor.constraint(equalTo: animateView.topAnchor, constant: 10)

        let constraints = [

            leadingAnchor!,
            trailingAnchor!,
            topAnchor!,
            bottomAnchor!,
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func handleTapAnimations(possible: WinnerPossibilities, winnerTeam: String) {
        print("Animating")
        var rotate1: Int?
        var rotate2: Int?
        var moveByConst: Double?
        var completetionCondition: Bool = false
        var moveAnchor: MoveAnchor?
        
        
        
        switch possible {
        case .horizontalTop:
            rotate1 = 2
            rotate2 = 2
            moveByConst = calculateSquareFrameDimension() / 6
            completetionCondition =  true
            moveAnchor = .top
            
            print("H1 hai")
        case .horizontalMiddle:
            rotate1 = 2
            rotate2 = 2
//            moveByConst = calculateSquareFrameDimension() - calculateSquareFrameDimension() / 6
            completetionCondition =  false
            print("hai")
        case .horizontalBottom:
            rotate1 = 2
            rotate2 = 2
            moveByConst = calculateSquareFrameDimension() - calculateSquareFrameDimension() / 6
            completetionCondition =  true
            moveAnchor = .top
            print("hai")
        case .verticalTop:
            rotate1 = 2
            rotate2 = 1
            moveByConst = -calculateSquareFrameDimension() / 3
            print(moveByConst)
            completetionCondition =  true
            moveAnchor = .leading
            print("hai")
        case .verticalMiddle:
            rotate1 = 2
            rotate2 = 1
//            moveByConst = calculateSquareFrameDimension() / 6
            completetionCondition =  false
            print("hai")
        case .verticalBottom:
            rotate1 = 2
            rotate2 = 1
            moveByConst =    calculateSquareFrameDimension() / 3
            print(moveByConst)
            completetionCondition =  true
            moveAnchor = .leading
            print("hai")
        case .diagnolForwardBend:
            rotate1 = 2
            rotate2 = 4
            completetionCondition =  false
            print("hai")
        case .diagnolBackwardBend:
            rotate1 = 1
            rotate2 = 4
            completetionCondition =  false
            print("hai")
        }
        animateView.transform = CGAffineTransform.identity;
        NSLayoutConstraint.deactivate(animateView.constraints)
        animateViewLayout()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.trailingAnchor?.constant = self.squareFrame.frame.width //left to right
            self.topAnchor?.constant = self.squareFrame.frame.height / 2
            self.animateView.transform = self.animateView.transform.rotated(by: CGFloat.pi / CGFloat(rotate1!))
            self.animateView.transform = self.animateView.transform.rotated(by: CGFloat.pi / CGFloat(rotate2!))
            self.loadViewIfNeeded()
        }, completion: {_ in
            nextAnimate(winnerTeam: winnerTeam)
        })
        
        func nextAnimate(winnerTeam: String) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                if completetionCondition {
                    if moveAnchor == .top {
                        print("Happy to move")
                        print(moveByConst!)
                self.topAnchor?.constant = moveByConst!
                    } else {
                    self.leadingAnchor?.constant = moveByConst!
                }
                }
               
            }, completion: {_ in
                sleep(1)
                self.pushPopUp(title: "\(winnerTeam)")
            })
        }
    }
}
