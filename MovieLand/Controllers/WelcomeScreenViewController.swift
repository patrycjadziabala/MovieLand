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
    @IBOutlet weak var mostPopularMoviesLabel: UILabel!
    @IBOutlet weak var mostPopularMoviesButton: UIButton!
    @IBOutlet weak var mostPopularScrollableViewCointainer: UIView!
    @IBOutlet weak var top250IMDbTVSeriesLabel: UILabel!
    @IBOutlet weak var top250IMDbTVSeriesButton: UIButton!
    @IBOutlet weak var top250IMDbTVSeriesScrollableViewContainer: UIView!
    
    @IBOutlet weak var mostPopularTVShowsLabel: UILabel!
    @IBOutlet weak var mostPopularTVShowsButton: UIButton!
    @IBOutlet weak var mostPopularTVShowsScrollableContainer: UIView!

    @IBOutlet weak var boxOfficeAllTimeLabel: UILabel!
    @IBOutlet weak var boxOfficeAllTimeButton: UIButton!
    @IBOutlet weak var boxOfficeAllTimeScrollableContainer: UIView!
    
    let apiManager: APIManagerProtocol = APIManager()
    let tabRouter: TabRouterProtocol
    let moviesInCinemaController: SwipeableInformationTilesController
    let top250MoviesController: SwipeableInformationTilesController
    let mostPopularMoviesController: SwipeableInformationTilesController
    let top250TVSeriesController: SwipeableInformationTilesController
    let mostPopularTVSeriesController: SwipeableInformationTilesController
    let boxOfficeAllTimeController: SwipeableInformationTilesController
    
    init(tabRouter: TabRouterProtocol) {
        self.tabRouter = tabRouter
        self.moviesInCinemaController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.top250MoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.mostPopularMoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.top250TVSeriesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.mostPopularTVSeriesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.boxOfficeAllTimeController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        
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

        configureCollectionViewTop250Movies()
        prepareForShowingTop250MoviesInformation()
        
        configureCollectionViewMostPopularMovies()
        prepareForShowingMostPopularMovies()
        
        configureCollectionViewTop250TVSeries()
        prepareForShowingTop250TVSeriesInformation()
        
        configureCollectionViewForMostPopularTVSeries()
        prepareForShowingMostPopularSeries()
        
        configureCollectionViewForBoxOfficeAllTime()
        prepareForShowingBoxOfficeAllTime()
    }

    // MARK: - Welcome Screen View configuration
    
    func configureWelcomeScreenView() {
        trailerButton.setTitle("See all Coming Soon movies", for: .normal)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
            scrollView.showsVerticalScrollIndicator = false
        
    }
    
// MARK: - Trailer configuration
    
//    func prepareForShowingTrailer() {
//
    @IBAction func seeAllSomingSoonButtonPressed(_ sender: UIButton) {
        
        
    }
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
        }
    }
    
    func handleSuccess(model: ItemsforInCinemasModel) {
        DispatchQueue.main.async {
            self.inCinemasSeeAllButton.isEnabled = true
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
        let mappedDataSource = moviesInCinemaController.dataSource.compactMap { swipeable in
            return swipeable as? ListViewControllerCellPresentable
        }
        tabRouter.navigateToList(results: mappedDataSource)
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
        }
    }
    
    func handleSuccess(model: ItemsForFeaturedMoviesModel) {
        DispatchQueue.main.async {
            self.top250IMDMoviesSeeAllButton.isEnabled = true
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
        let mappedDataSource = top250MoviesController.dataSource.compactMap { swipeable in
            return swipeable as? ListViewControllerCellPresentable
        }
        tabRouter.navigateToList(results: mappedDataSource)
    }
    
    // MARK: - MostPopularMovies configiration
    
    func prepareForShowingMostPopularMovies() {
        apiManager.fetchMostPopularMoviesInformation { [weak self] result in
            switch result {
            case .success(let title):
                self?.handleSuccessForMostPopularMovies(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func handleSuccessForMostPopularMovies(model: ItemsForFeaturedMoviesModel) {
        DispatchQueue.main.async {
            self.mostPopularMoviesButton.isEnabled = true
            self.mostPopularMoviesController.set(dataSource: model.items)
        }
    }
    
    func configureCollectionViewMostPopularMovies() {
        addChild(mostPopularMoviesController)
        view.addSubview(mostPopularMoviesController.view)
        mostPopularMoviesController.didMove(toParent: self)
        mostPopularMoviesController.view.constraint(to: mostPopularScrollableViewCointainer)
    }
    
    @IBAction func mostPopularMoviesSeeAllButtonPressed(_ sender: UIButton) {
        let mappedDataSource = mostPopularMoviesController.dataSource.compactMap { swipeable in
            return swipeable as? ListViewControllerCellPresentable
        }
        tabRouter.navigateToList(results: mappedDataSource)
    }
    
    // MARK: - Top250IMDbTVSeries configuration
    
    func prepareForShowingTop250TVSeriesInformation() {
        apiManager.fetchTop250TVSeriesResults { [weak self] result in
            switch result {
            case .success(let title):
                self?.handleSuccessForTop250TVSeries(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func handleSuccessForTop250TVSeries(model: ItemsForFeaturedMoviesModel) {
        DispatchQueue.main.async {
            self.top250IMDbTVSeriesButton.isEnabled = true
            self.top250TVSeriesController.set(dataSource: model.items)
        }
    }
    
    func configureCollectionViewTop250TVSeries() {
        addChild(top250TVSeriesController)
        view.addSubview(top250TVSeriesController.view)
        top250TVSeriesController.didMove(toParent: self)
        top250TVSeriesController.view.constraint(to: top250IMDbTVSeriesScrollableViewContainer)
    }
    
    @IBAction func top250IMDbTVSeriesButtonPressed(_ sender: UIButton) {
        let mappedDataSource = top250TVSeriesController.dataSource.compactMap { swipeable in
            return swipeable as? ListViewControllerCellPresentable
        }
        tabRouter.navigateToList(results: mappedDataSource)
    }
    
    // MARK: - MostPopularTVSeries configuration
    
    func prepareForShowingMostPopularSeries() {
        apiManager.fetchMostPopularTVSeriesInformation { [weak self] result in
            switch result {
            case .success(let title):
                self?.handleSuccessForMostPopularTVSeries(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func handleSuccessForMostPopularTVSeries(model: ItemsForFeaturedMoviesModel) {
        DispatchQueue.main.async {
            self.mostPopularTVShowsButton.isEnabled = true
            self.mostPopularTVSeriesController.set(dataSource: model.items)
        }
    }
    
    func configureCollectionViewForMostPopularTVSeries() {
        addChild(mostPopularTVSeriesController)
        view.addSubview(mostPopularTVSeriesController.view)
        mostPopularTVSeriesController.didMove(toParent: self)
        mostPopularTVSeriesController.view.constraint(to: mostPopularTVShowsScrollableContainer)
    }
    
    @IBAction func mostPopularTvSeriesButtonPressed(_ sender: UIButton) {
        let mappedDataSource = mostPopularTVSeriesController.dataSource.compactMap { swipeable in
            return swipeable as? ListViewControllerCellPresentable
        }
        tabRouter.navigateToList(results: mappedDataSource)
    }
   
    // MARK: - BoxOfficeAllTime configuration
    
    func prepareForShowingBoxOfficeAllTime() {
        apiManager.fetchBoxOfficeAllTime { [weak self] result in
            switch result {
            case .success(let title):
                self?.handleSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func handleSuccess(model: ItemsForBoxOfficeAllTimeModel) {
        DispatchQueue.main.async {
            self.boxOfficeAllTimeButton.isEnabled = true
            self.boxOfficeAllTimeController.set(dataSource: model.items)
        }
    }
    
    func configureCollectionViewForBoxOfficeAllTime() {
        addChild(boxOfficeAllTimeController)
        view.addSubview(boxOfficeAllTimeController.view)
        boxOfficeAllTimeController.didMove(toParent: self)
        boxOfficeAllTimeController.view.constraint(to: boxOfficeAllTimeScrollableContainer)
    }
    
    
    @IBAction func boxOfficeAllTimeButtonPressed(_ sender: UIButton) {
            let mappedDataSource = boxOfficeAllTimeController.dataSource.compactMap { swipeable in
                return swipeable as? ListViewControllerCellPresentable
            }
            self.tabRouter.navigateToList(results: mappedDataSource)
    }
    
}
