//
//  MovieViewController.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    @IBOutlet weak var awardsTextView: UITextView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var trailerLabel: UILabel!
    @IBOutlet weak var trailerViewContainer: UIView!
    @IBOutlet weak var trailerPlayButton: UIButton!
    @IBOutlet weak var moreLikeThisLabel: UILabel!
    @IBOutlet weak var actorsInFilmScrollableViewContainer: UIView!
    @IBOutlet weak var similarMoviesScrollableViewContainer: UIView!
    @IBOutlet weak var trailerImageView: UIImageView!
    @IBOutlet weak var seeAllCastButton: UIButton!
    
    let actorsInFilmController: SwipeableInformationTilesController
    let similarMoviesController: SwipeableInformationTilesController
    let titleID: String
    var trailerUrl: String = ""
    let viewModel: MovieDetailsViewModelProtocol
    
    init(titleID: String, tabRouter: TabRouterProtocol, viewModel: MovieDetailsViewModelProtocol) {
        self.titleID = titleID
        self.actorsInFilmController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.similarMoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViewActorsInFilm()
        configureCollectionViewSimilarMovies()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        scrollView.showsVerticalScrollIndicator = false
        
        prepareForShowingMovieInformation()
        
        prepareForShowingTrailer()
    }
    
    // MARK: - Movie information configuration
    
    func prepareForShowingMovieInformation() {
        viewModel.fetchTitle(id: titleID)
    }
    
    func handleSuccess(titleModel: TitleModel) {
        DispatchQueue.main.async {
            self.movieTitleLabel.text = titleModel.title
            self.releaseDateLabel.text = titleModel.releaseDate
            self.genreLabel.text = titleModel.genreList.first?.value ?? ""
            let imageUrl = URL(string: titleModel.image)
            self.moviePosterImageView.sd_setImage(with: imageUrl)
            self.movieOverviewTextView.text = titleModel.plot
            self.awardsTextView.text = titleModel.awards
            self.actorsInFilmController.set(dataSource: titleModel.actorList)
            self.similarMoviesController.set(dataSource: titleModel.similars)
        }
    }
    
    func handleError(error: Error) {
        print(error)
    }
    
    func configureCollectionViewActorsInFilm() {
        addChild(actorsInFilmController)
        view.addSubview(actorsInFilmController.view)
        actorsInFilmController.didMove(toParent: self)
        actorsInFilmController.view.constraint(to: actorsInFilmScrollableViewContainer)
    }
    
    func configureCollectionViewSimilarMovies() {
        addChild(similarMoviesController)
        view.addSubview(similarMoviesController.view)
        similarMoviesController.didMove(toParent: self)
        similarMoviesController.view.constraint(to: similarMoviesScrollableViewContainer)
    }
    
    // MARK: - Trailer configuaration
    
    func prepareForShowingTrailer() {
        viewModel.fetchTrailer(id: titleID)
    }
    
    func handleSuccess(trailerModel: TrailerModel) {
        DispatchQueue.main.async {
            let trailerImageUrl = URL(string: trailerModel.thumbnailUrl)
            self.trailerImageView.sd_setImage(with: trailerImageUrl)
            self.trailerUrl = trailerModel.link
        }
    }
    
    func showTrailer(urlString: String) {
        viewModel.navigateToTrailer(urlString: urlString)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.showTrailer(urlString: self.trailerUrl)
        }
    }
    
    // MARK: - Cast configuration
    
    @IBAction func seeAllCastButtonPressed(_ sender: UIButton) {
        viewModel.navigateToList(result: actorsInFilmController.dataSource)
    }
}

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    func onFetchTitleSuccess(model: TitleModel) {
        handleSuccess(titleModel: model)
    }
    
    func onFetchTitleError(error: Error) {
        handleError(error: error)
    }
    
    func onFetchTrailerSuccess(model: TrailerModel) {
        handleSuccess(trailerModel: model)
    }
    
    func onFetchTrailerError(error: Error) {
        handleError(error: error)
    }
}
