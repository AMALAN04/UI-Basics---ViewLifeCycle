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
    var lineThickness:Double = 8
    static var noOfWinner = 0
    
    var leadingAnchor: NSLayoutConstraint?
    var trailingAnchor: NSLayoutConstraint?
    var topAnchor: NSLayoutConstraint?
    var bottomAnchor: NSLayoutConstraint?
    var widthAnchor: NSLayoutConstraint?
    var shapeLayer:CAShapeLayer?
    
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
        winsByY.text = "O = \(gameSummary.matchWonByY)"
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
        collectionView.isScrollEnabled = false
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
        lineThickness = calculateSquareFrameDimension() / 60
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
            winsByX.leadingAnchor.constraint(equalTo: gameSummaryStack.leadingAnchor, constant: 2),
            winsByY.trailingAnchor.constraint(equalTo: gameSummaryStack.trailingAnchor, constant: -2),
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
                handleTapAnimations(possible: winnerDetails.possible!, winnerTeam: "Winner \"X\"", lastItem: indexPath.row)
                updateMatchesWon(player: .playerX)
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
                print("LAST ITEM: \(indexPath.row)")
                handleTapAnimations(possible: winnerDetails.possible!, winnerTeam: "Winner \"O\"", lastItem: indexPath.row)
                updateMatchesWon(player: .playerO)
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
    
    func updateMatchesWon(player: BoxStatus) {
        guard ViewController.noOfWinner == 0 else {
            return
        }
        if player == .playerX {
            gameSummary.matchWonByX = gameSummary.matchWonByX + 1
        } else {
            gameSummary.matchWonByY = gameSummary.matchWonByY + 1
        }
        
    }
}

extension ViewController {
    
    @objc func cancelTapped() {
        let alert = UIAlertController(title: title, message: "..TIC TAC TOE..", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { [weak self] action in
            self?.reloadGame()
        }))
        present(alert, animated: true)
    }
    
    func pushPopUp(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Home", style: .destructive, handler: { [weak self] action in
            self?.reloadGame()
        }))
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { [weak self] action in
            self?.ContinueGame()
        }))
        present(alert, animated: true)
    }
    
    func ContinueGame() {
        gameStatusArray = loadStatusArray()
        animateView.removeFromSuperview()
        ViewController.noOfWinner = 0
        collectionView.isUserInteractionEnabled  = true
        gameSummary.playerFlag = true
        turnTitle.text = "-X-"
        winsByX.text = "X = \(gameSummary.matchWonByX)"
        winsByY.text = "O = \(gameSummary.matchWonByY)"
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
    
    private func constructScaleAnimation(startingScale: CGFloat, endingScale: CGFloat, animationDuration: Double) -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = startingScale
        scaleAnimation.toValue = endingScale
        scaleAnimation.duration = animationDuration
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = 3
        return scaleAnimation
    }
    private func constructPositionAnimation(startingPoint: CGPoint, endPoint: CGPoint, animationDuration: Double) -> CABasicAnimation {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = NSValue(cgPoint: startingPoint)
        positionAnimation.toValue = NSValue(cgPoint: endPoint)
        positionAnimation.duration = animationDuration
        positionAnimation.autoreverses = true
        positionAnimation.repeatCount = Float.infinity
        positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        return positionAnimation
    }
    
    func findCell(item: Int, section: Int) -> UICollectionViewCell? {
        let cell = collectionView.cellForItem(at: IndexPath(item: item, section: section))
        return cell
    }
    
    func handleTapAnimations(possible: WinnerPossibilities, winnerTeam: String, lastItem: Int) {
        var cellStating: UICollectionViewCell? = nil
        var cellEnding: UICollectionViewCell? = nil
        guard ViewController.noOfWinner == 0 else {
            return
        }
        collectionView.isUserInteractionEnabled  = false
        ViewController.noOfWinner = ViewController.noOfWinner + 1
        cellEnding =  findCell(item: lastItem, section: 0)
        switch possible {
        case .horizontalTop:
            if(lastItem == 2) {
            cellStating = findCell(item: 0, section: 0)
            } else {
                cellStating = findCell(item: 2, section: 0)
            }
            print("H1")
        case .horizontalMiddle:
            if(lastItem == 5) {
            cellStating = findCell(item: 3, section: 0)
            } else {
                cellStating = findCell(item: 5, section: 0)
            }
            print("H2")
        case .horizontalBottom:
            if(lastItem == 8) {
            cellStating = findCell(item: 6, section: 0)
            } else {
                cellStating = findCell(item: 8, section: 0)
            }
            print("H3")
        case .verticalTop:
            if(lastItem == 6) {
            cellStating = findCell(item: 0, section: 0)
            } else {
                cellStating = findCell(item: 6, section: 0)
            }
            print("V1")
        case .verticalMiddle:
            if(lastItem == 7) {
            cellStating = findCell(item: 1, section: 0)
            } else {
                cellStating = findCell(item: 7, section: 0)
            }
            print("V2")
        case .verticalBottom:
            if(lastItem == 8) {
            cellStating = findCell(item: 2, section: 0)
            } else {
                cellStating = findCell(item: 8, section: 0)
            }
            print("V3")
        case .diagnolForwardBend:
            if(lastItem == 6) {
            cellStating = findCell(item: 2, section: 0)
            } else {
                cellStating = findCell(item: 6, section: 0)
            }
            print("D1")
        case .diagnolBackwardBend:
            if(lastItem == 8) {
            cellStating = findCell(item: 0, section: 0)
            } else {
                cellStating = findCell(item: 8, section: 0)
            }
            print("D2")
        }
        guard let cellEnding = cellEnding else {
            return
        }
        guard let cellStating = cellStating else {
            return
        }
        let statyingPoint: CGPoint = cellStating.center
        let endindPoint: CGPoint = cellEnding.center
        let path = UIBezierPath()
        path.move(to:  statyingPoint)
        path.addLine(to: endindPoint)
        shapeLayer = CAShapeLayer()
        shapeLayer?.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer?.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        shapeLayer?.lineWidth = lineThickness
        shapeLayer?.path = path.cgPath
        CATransaction.begin()
        collectionView.layer.addSublayer(shapeLayer!)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.4
        CATransaction.setCompletionBlock{ [weak self] in
            self?.shapeLayer?.removeFromSuperlayer()
            self?.pushPopUp(title: "\(winnerTeam)")
                print("again...")
            }
        shapeLayer?.add(animation, forKey: "MyAnimation")
        CATransaction.commit()
    }
}
