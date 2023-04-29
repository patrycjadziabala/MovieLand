//
//  TrailerViewController.swift
//  MovieLand
//
//  Created by Patka on 29/04/2023.
//

import UIKit

class TrailerViewController: UIViewController {
    
    private let collectionViewTrailers: UICollectionView
    private var dataSource: [WelcomeScreenTrailerModel] = []
    private let tabRouter: TabRouterProtocol
    private var timer: Timer?
    private var currentRow = 0
    
    init(tabRouter: TabRouterProtocol) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionViewTrailers = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.tabRouter = tabRouter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrailerCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    func configureTrailerCollectionView() {
        view.addSubview(collectionViewTrailers)
        collectionViewTrailers.register(UINib(nibName: Constants.trailerCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.trailerCollectionViewCell)
        collectionViewTrailers.backgroundColor = UIColor(named: Constants.customDarkBlue)
        collectionViewTrailers.constraint(to: view)
        collectionViewTrailers.showsHorizontalScrollIndicator = false
        collectionViewTrailers.isPagingEnabled = true
        collectionViewTrailers.dataSource = self
        collectionViewTrailers.delegate = self
        
    }
   
    func set(dataSource: [ComingSoonModel]) {
        DispatchQueue.main.async {
            self.dataSource = dataSource.map { comingSoonModel in
                return WelcomeScreenTrailerModel(comingSoonModel: comingSoonModel)
            }
            self.collectionViewTrailers.reloadData()
        }
    }
    
    func setUpAutoScroll() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.scrollToNextItem()
        }
    }
    
    func scrollToNextItem() {
        let visibleCells = collectionViewTrailers.visibleCells
        guard
            visibleCells.count == 1,
            let currentCell = visibleCells.first,
            let currentIndex = collectionViewTrailers.indexPath(for: currentCell)
        else {
            return
        }
        if currentIndex.row == dataSource.count - 1 {
            /// We are at the last row, scroll to the beginning
            collectionViewTrailers.scrollToItem(at: IndexPath(row: 0,
                                                              section: 0),
                                                at: .centeredHorizontally, animated: true)
        } else {
            /// Scroll to next row
            let nextIndex = IndexPath(row: currentIndex.row + 1,
                                      section: 0)
            collectionViewTrailers.scrollToItem(at: nextIndex,
                                                at: .centeredHorizontally,
                                                animated: true)
        }
    }
}

// MARK: - Extensions

extension TrailerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        if let trailerUrlString = item.trailerModel?.link {
            tabRouter.navigateToWebView(urlString: trailerUrlString)
        }
    }
}

extension TrailerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewTrailers.dequeueReusableCell(withReuseIdentifier: Constants.trailerCollectionViewCell, for: indexPath) as? TrailerCollectionViewCell {
            cell.configure(with: dataSource[indexPath.row])
            currentRow = indexPath.row
            return cell
        }
        return UICollectionViewCell()
    }
}

extension TrailerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
}
