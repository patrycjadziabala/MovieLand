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
    @IBOutlet weak var inCinemasSeeAllButton: UIButton!
    @IBOutlet weak var inCinemasScrollableViewContainer: UIView!
    @IBOutlet weak var top250IMDbMoviesLabel: UILabel!
    @IBOutlet weak var top250IMDMoviesSeeAllButton: UIButton!
    @IBOutlet weak var top250IMDbMoviesScrollableViewContainer: UIView!
    
    let apiManager: APIManagerProtocol = APIManager()
    let tabRouter: TabRouterProtocol
    let dataSource: [SwipeableInformationTilePresentable]
    let moviesInCinemaController: SwipeableInformationTilesController
    let top250MoviesController: SwipeableInformationTilesController
    
    init(tabRouter: TabRouterProtocol, dataSource: [SwipeableInformationTilePresentable]) {
        self.dataSource = dataSource
        self.tabRouter = tabRouter
        self.moviesInCinemaController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.top250MoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureWelcomeScreenView()
//        prepareForShowingTrailer()
        configureCollectionViewInCinamasMovies()
        prepareForShowingInCinemaMoviesInformation()

//        configureCollectionViewTop250Movies()
//        prepareForShowingTop250MoviesInformation()
        
    }

    // MARK: - Welcome Screen View configuration
    
    func configureWelcomeScreenView() {
        trailerButton.setTitle("See all Coming Soon movies", for: .normal)
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
    
    func handleSuccess(model: ItemsforInCinemasModel) {
        DispatchQueue.main.async {
            self.moviesInCinemaController.set(dataSource: model.items)
        }
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
        
    @IBAction func inCinemasSeeAllButtonPressed(_ sender: UIButton) {
        
    }
    
    // MARK: - Top250Movies configuration
    
    func prepareForShowingTop250MoviesInformation() {
        apiManager.fetchFeaturedMoviesResults { [weak self] result in
            switch result {
            case .success(let title):
                self?.handleSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
            print(result)
        }
    }
    
    func handleSuccess(model: ItemsForFeaturedMoviesModel) {
        DispatchQueue.main.async {
            self.top250MoviesController.set(dataSource: model.items)
        }
    }
    
    func configureCollectionViewTop250Movies() {
        addChild(top250MoviesController)
        view.addSubview(top250MoviesController.view)
        top250MoviesController.didMove(toParent: self)
        top250MoviesController.view.constraint(to: top250IMDbMoviesScrollableViewContainer)
    }
    
    @IBAction func top250IMDbMoviesAeeAllButtonPressed(_ sender: UIButton) {
//        tabRouter.navigateToTop250Movies(results: dataSource)
    }
}
