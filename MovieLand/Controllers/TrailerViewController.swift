//
//  TrailerViewController.swift
//  MovieLand
//
//  Created by Patka on 29/04/2023.
//

import UIKit

class TrailerViewController: UIViewController {
    
    private let collectionViewTrailers: UICollectionView
    
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
    
}

extension TrailerViewController: UICollectionViewDelegate {
    
}

extension TrailerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewTrailers.dequeueReusableCell(withReuseIdentifier: Constants.trailerCollectionViewCell, for: indexPath) as? TrailerCollectionViewCell {
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

//extension TrailerViewController: UIScrollViewDelegate {
//
//    func cellWi
//}
