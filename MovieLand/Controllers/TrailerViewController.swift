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
    
    init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionViewTrailers = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTrailerCollectionView()
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
}

// MARK: - Extensions

extension TrailerViewController: UICollectionViewDelegate {
    
}

extension TrailerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewTrailers.dequeueReusableCell(withReuseIdentifier: Constants.trailerCollectionViewCell, for: indexPath) as? TrailerCollectionViewCell {
            cell.configure(with: dataSource[indexPath.row])
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
