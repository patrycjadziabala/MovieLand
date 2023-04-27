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
    @IBOutlet weak var trailerVideoView: UIView!
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
    
    let tabRouter: TabRouterProtocol
    let moviesInCinemaController: SwipeableInformationTilesController
    let top250MoviesController: SwipeableInformationTilesController
    let mostPopularMoviesController: SwipeableInformationTilesController
    let top250TVSeriesController: SwipeableInformationTilesController
    let mostPopularTVSeriesController: SwipeableInformationTilesController
    let boxOfficeAllTimeController: SwipeableInformationTilesController
    let viewModel: WelcomeScreenViewModelProtocol
    
    init(tabRouter: TabRouterProtocol, viewModel: WelcomeScreenViewModelProtocol) {
        self.tabRouter = tabRouter
        self.moviesInCinemaController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.top250MoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.mostPopularMoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.top250TVSeriesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.mostPopularTVSeriesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.boxOfficeAllTimeController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleActivity(active: true)
        configureWelcomeScreenView()
        prepareForShowingWelcomeScreenInformation()
        configureCollectionViews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.toggleActivity(active: false)
          
        }
    }
    
    // MARK: - Welcome Screen View configuration
    
    func configureWelcomeScreenView() {
        trailerButton.setTitle("See all Coming Soon movies", for: .normal)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        inCinemasSeeAllButton.makeRound(radius: 15)
        mostPopularMoviesButton.makeRound(radius: 15)
        mostPopularMoviesButton.makeRound(radius: 15)
        boxOfficeAllTimeButton.makeRound(radius: 15)
        mostPopularTVShowsButton.makeRound(radius: 15)
        top250IMDbTVSeriesButton.makeRound(radius: 15)
        top250IMDMoviesSeeAllButton.makeRound(radius: 15)
        trailerViewContainer.makeRound(radius: 20)
        trailerInfoTextView.makeRound(radius: 20)
        navigationController?.navigationBar.barTintColor =  UIColor(named: Constants.customDarkBlue)
        tabBarController?.tabBar.barTintColor = UIColor(named: Constants.customDarkBlue)
    }
    
    func prepareForShowingWelcomeScreenInformation() {
        prepareForShowingInCinemaMoviesInformation()
        prepareForShowingTop250MoviesInformation()
        prepareForShowingMostPopularMovies()
        prepareForShowingTop250TVSeriesInformation()
        prepareForShowingMostPopularSeries()
        prepareForShowingBoxOfficeAllTime()
        //        prepareForShowingTrailer()
    }
    
    func configureCollectionViews() {
        configureCollectionViewInCinamasMovies()
        configureCollectionViewTop250Movies()
        configureCollectionViewMostPopularMovies()
        configureCollectionViewTop250TVSeries()
        configureCollectionViewForMostPopularTVSeries()
        configureCollectionViewForBoxOfficeAllTime()
    }
    
    // MARK: - Trailers
    
    //    func prepareForShowingTrailer() {
    //}
    @IBAction func seeAllSomingSoonButtonPressed(_ sender: UIButton) {
        
    }
    
    // MARK: - In Cinemas Movies
    
    func prepareForShowingInCinemaMoviesInformation() {
        viewModel.fetchInCinemaMoviesInformation()
    }
    
    func handleSuccess(model: ItemsforInCinemasModel) {
        DispatchQueue.main.async {
            self.inCinemasSeeAllButton.isEnabled = true
            self.moviesInCinemaController.set(dataSource: model.items)
        }
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
    
    // MARK: - Top 250 Movies
    
    func prepareForShowingTop250MoviesInformation() {
        viewModel.fetchFeaturedMoviesResults()
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
    
    // MARK: - Most Popular Movies
    
    func prepareForShowingMostPopularMovies() {
        viewModel.fetchMostPopularMoviesInformation()
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
    
    // MARK: - Top 250 IMDb TV Series
    
    func prepareForShowingTop250TVSeriesInformation() {
        viewModel.fetchTop250TVSeries()
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
    
    // MARK: - Most Popular TV Series
    
    func prepareForShowingMostPopularSeries() {
        viewModel.fetchMostPopularTVSeries()
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
        viewModel.fetchBoxOfficeAllTime()
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
    
    // MARK: - Alert
    
    func errorAlert(with error: Error) {
        let alert = UIAlertController(title: Constants.noInternet, message: Constants.offlineMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: Constants.ok, style: .default, handler: { (action) -> Void in
            print(Constants.okButtonTapped)
        })
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - WelcomeScreenViewController - extension

extension WelcomeScreenViewController: WelcomeScreenViewModelDelegate {
    func onFetchInCinemasMoviesHandleSuccess(model: ItemsforInCinemasModel) {
        handleSuccess(model: model)
    }
    
    func onFetchFeaturedMoviesHandleSuccess(model: ItemsForFeaturedMoviesModel) {
        handleSuccess(model: model)
    }
    
    func onFetchMostPopularMoviesInformationSuccess(model: ItemsForFeaturedMoviesModel) {
        handleSuccessForMostPopularMovies(model: model)    }
    
    func onFetchTop250TVSeriesSuccess(model: ItemsForFeaturedMoviesModel) {
        handleSuccessForTop250TVSeries(model: model)    }
    
    func onFetchMostPopularTVSeriesSuccess(model: ItemsForFeaturedMoviesModel) {
        handleSuccessForMostPopularTVSeries(model: model)    }
    
    func onFetchBoxOfficeAllTimeSuccess(model: ItemsForBoxOfficeAllTimeModel) {
        handleSuccess(model: model)
    }
    
    func presentError(error: Error) {
        DispatchQueue.main.async {
            self.errorAlert(with: error)
        }
    }
}
