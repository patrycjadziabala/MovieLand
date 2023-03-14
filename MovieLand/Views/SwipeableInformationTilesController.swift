//
//  SwipeableInformationTilesController.swift
//  MovieLand
//
//  Created by Patka on 13/03/2023.
//

import UIKit

class SwipeableInformationTilesController: UIViewController {

    let tabRouter: TabRouterProtocol
    
    var dataSource: [CastMovieModel] {
        didSet {
            collectionViewCastMovies.reloadData()
        }
    }
    
    let collectionViewCastMovies: UICollectionView
    
    init(dataSource: [CastMovieModel], tabRouter: TabRouterProtocol) {
        self.tabRouter = tabRouter
        self.dataSource = dataSource
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionViewCastMovies = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
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
        collectionViewCastMovies.delegate = self
        collectionViewCastMovies.dataSource = self
      
    }
}

extension SwipeableInformationTilesController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        CGSize(width: 80, height: collectionViewCastMovies.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataSource[indexPath.item]
        tabRouter.navigateToTitleDetails(id: model.id)
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

extension SwipeableInformationTilesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
        
    }
}
