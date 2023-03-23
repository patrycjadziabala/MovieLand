//
//  WelcomeScreenViewController.swift
//  MovieLand
//
//  Created by Patka on 22/03/2023.
//

import UIKit
import SDWebImage
import SafariServices

class WelcomeScreenViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var trailerViewContainer: UIView!
    @IBOutlet weak var trailerImageView: UIImageView!
    @IBOutlet weak var trailerInfoTextView: UITextView!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var inCinemasLabel: UILabel!
    @IBOutlet weak var inCinemasScrollableViewContainer: UIView!
    
    let apiManager = APIManager()
    let tabRouter: TabRouterProtocol
    let dataSource: [SwipeableInformationTilePresentable]
    let moviesInCinemaController: SwipeableInformationTilesController
    
    init(tabRouter: TabRouterProtocol, dataSource: [SwipeableInformationTilePresentable]) {
        self.dataSource = dataSource
        self.tabRouter = tabRouter
        self.moviesInCinemaController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        prepareForShowingTrailer()
        prepareForShowingInCinemaMoviesInformation()
        configureCollectionViewInCinamasMovies()
    }

// MARK: - Trailer configuration
    
//    func prepareForShowingTrailer() {
//
//    }
    
// MARK: - In Cinemas Movies configuration
    
    func prepareForShowingInCinemaMoviesInformation() {
        apiManager.fetchInCinemasMoviesInformation { [weak self] result in
            switch result {
            case .success(let title):
                self?.handleSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
            print(result)
        }
    }
    
    func handleSuccess(model: ItemsForComingSoonModel) {
        
        self.moviesInCinemaController.dataSource = model.items

    }
    
    func handleError(error: Error) {
        print(error)
    }
    
    func configureCollectionViewInCinamasMovies() {
        addChild(moviesInCinemaController)
        view.addSubview(moviesInCinemaController.view)
        moviesInCinemaController.didMove(toParent: self)
        moviesInCinemaController.view.constraint(to: inCinemasScrollableViewContainer)
      
        
    }
    
}
