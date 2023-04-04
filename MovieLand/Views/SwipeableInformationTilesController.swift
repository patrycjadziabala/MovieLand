//
//  SwipeableInformationTilesController.swift
//  MovieLand
//
//  Created by Patka on 13/03/2023.
//

import UIKit

protocol SwipeableInformationTilePresentable {
    var optionalId: String { get }
    var iMDbRankLabelText: String? { get }
    var titleLabelText: String { get }
    var imageUrlString: String? { get }
    var additionalInfoLabelText: String? { get }
    var iMDbRatingNumberLabelText: String? { get }
    var cellType: CellType { get }
}

class SwipeableInformationTilesController: UIViewController {

    private let tabRouter: TabRouterProtocol
    
    var dataSource: [SwipeableInformationTilePresentable]
    
    private let collectionViewCastMovies: UICollectionView
    
    init(dataSource: [SwipeableInformationTilePresentable], tabRouter: TabRouterProtocol) {
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
    
    func set(dataSource: [SwipeableInformationTilePresentable]) {
        self.dataSource = dataSource
        self.collectionViewCastMovies.reloadData()
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionViewCastMovies)
        collectionViewCastMovies.register(UINib(nibName: Constants.collectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCell)
        
        collectionViewCastMovies.backgroundColor = UIColor(named: Constants.customPink)
        collectionViewCastMovies.constraint(to: view)
        collectionViewCastMovies.delegate = self
        collectionViewCastMovies.dataSource = self
        collectionViewCastMovies.reloadData()
    }
}

extension SwipeableInformationTilesController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataSource[indexPath.item]
    
        switch model.cellType {
        case .title:
            tabRouter.navigateToTitleDetails(id: model.optionalId)
        case .name:
            tabRouter.navigateToPersonDetails(id: model.optionalId)
        case .unknown:
            break
        }
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
        return CGSize(width: 100, height: 200)
        
    }
}
