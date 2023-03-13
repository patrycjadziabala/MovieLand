//
//  SwipeableInformationTilesController.swift
//  MovieLand
//
//  Created by Patka on 13/03/2023.
//

import UIKit

class SwipeableInformationTilesController: UIViewController {

    var dataSource: [CastMovieModel] {
        didSet {
            collectionViewCastMovies.reloadData()
        }
    }
    
    let collectionViewCastMovies: UICollectionView
    
    init(dataSource: [CastMovieModel]) {
        self.dataSource = dataSource

        self.collectionViewCastMovies = UICollectionView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       configureCollectionView()
       
    }
    func configureCollectionView() {
        view.addSubview(collectionViewCastMovies)
        let cell = String(describing: CollectionViewCell.self)
        collectionViewCastMovies.register(UINib(nibName: Constants.collectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCell)
        collectionViewCastMovies.backgroundColor = UIColor(named: Constants.customPink)
        collectionViewCastMovies.constraint(to: view)
    }
    
}



extension SwipeableInformationTilesController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        CGSize(width: 80, height: collectionViewCastMovies.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let collectionViewCell = cell as? CollectionViewCell
    }
}

extension SwipeableInformationTilesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewCastMovies.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCell, for: indexPath) as? CollectionViewCell{
            cell.configure(with: dataSource[indexPath.item])
            return cell
        }
            
        return UICollectionViewCell()
    }
}
