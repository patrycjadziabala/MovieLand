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
    @IBOutlet weak var seeAllSimilarsButton: UIButton!
    @IBOutlet weak var exploreAwardsButton: UIButton!
    @IBOutlet weak var officialWebsiteButton: UIButton!
    @IBOutlet weak var imDbWebsiteButton: UIButton!
    @IBOutlet weak var filmAffinityWebsiteButton: UIButton!
    @IBOutlet weak var movieDbWebsiteButton: UIButton!
    @IBOutlet weak var rottenTomatoesWebsiteButton: UIButton!
    @IBOutlet weak var ratingScore: UILabel!
    @IBOutlet weak var ratingStarImage: UIImageView!
    @IBOutlet weak var ratingDescriptionLabel: UILabel!
    
    let actorsInFilmController: SwipeableInformationTilesController
    let similarMoviesController: SwipeableInformationTilesController
    let titleID: String
    var trailerUrl: String = ""
    var webDetailsModel: AllDetailsWebModel?
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
        
        prepareForShowingMovieInformation()
        
        prepareForShowingTrailer()
        
        prepareToShowFullDetails()
        
        prepareForShowingMovieRating()
        
        configureView()
    }
    
    // MARK: - View - Configuration
    
    func configureView() {
        configureCollectionViewActorsInFilm()
        configureCollectionViewSimilarMovies()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Movie information configuration
    
    func prepareForShowingMovieInformation() {
        exploreAwardsButton.isHidden = true
        viewModel.fetchTitle(id: titleID)
    }
    
    func handleSuccess(titleModel: TitleModel) {
        DispatchQueue.main.async {
            self.seeAllCastButton.isEnabled = true
            self.seeAllSimilarsButton.isEnabled = true
            self.movieTitleLabel.text = titleModel.title
            self.releaseDateLabel.text = titleModel.releaseDate
            self.genreLabel.text = titleModel.genreList.first?.value ?? ""
            let imageUrl = URL(string: titleModel.image)
            self.moviePosterImageView.sd_setImage(with: imageUrl)
            self.movieOverviewTextView.text = titleModel.plot
            
//            if titleModel.awards == nil {
//                self.exploreAwardsButton.isHidden
//            }
            if let awardsList = titleModel.awards {
                self.exploreAwardsButton.isHidden = false
                self.exploreAwardsButton.backgroundColor = UIColor.cyan

                self.awardsTextView.text = awardsList
            } else {
                self.awardsTextView.isHidden = true
            }
         
            self.actorsInFilmController.set(dataSource: titleModel.actorList)
            self.similarMoviesController.set(dataSource: titleModel.similars)
            
        }
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
    
    // MARK: - Movie rating configuration
    
    func prepareForShowingMovieRating() {
        viewModel.fetchRating(id: titleID)
    }
    
    func handleSuccess(ratingModel: RatingsModel) {
        DispatchQueue.main.async {
            if ratingModel.imDb?.isEmpty ?? true {
                self.ratingScore.isHidden = true
                self.ratingStarImage.isHidden = true
                self.ratingDescriptionLabel.isHidden = true
            } else {
                self.ratingScore.text = ratingModel.imDb
            }
        }
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
    
    // MARK: - See Full Details - Web View configuration
    
    func prepareToShowFullDetails() {
        viewModel.fetchFullDetailsWeb(id: titleID)
    }
    
    func handleSuccess(webDetailsModel: AllDetailsWebModel) {
        DispatchQueue.main.async {
            self.officialWebsiteButton.isEnabled = true
            self.imDbWebsiteButton.isEnabled = true
            self.rottenTomatoesWebsiteButton.isEnabled = true
            self.movieDbWebsiteButton.isEnabled = true
            self.filmAffinityWebsiteButton.isEnabled = true
            self.webDetailsModel = webDetailsModel
        }
    }
    
    func showWeb(urlString: String) {
        viewModel.navigateToFullDetailsWeb(urlString: urlString)
    }
    
    @IBAction func officialWebsiteButtonPressed(_ sender: UIButton) {
        print("OK")
        DispatchQueue.main.async {
            self.showWeb(urlString: self.webDetailsModel?.officialWebsite ?? "")
        }
    }
    
    @IBAction func imDbWebsiteButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.showWeb(urlString: self.webDetailsModel?.imDb.url ?? "")
        }
    }
    
    @IBAction func movieDbWebsiteButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.showWeb(urlString: self.webDetailsModel?.theMovieDb.url ?? "")
        }
    }
    
    @IBAction func rottenTomatoesWebsiteButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.showWeb(urlString: self.webDetailsModel?.rottenTomatoes.url ?? "")
        }
    }
    
    @IBAction func filmAffinityWebsiteButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.showWeb(urlString: self.webDetailsModel?.filmAffinity.url ?? "")
        }
    }
    
    // MARK: - Cast configuration
    
    @IBAction func seeAllCastButtonPressed(_ sender: UIButton) {
        viewModel.navigateToList(result: actorsInFilmController.dataSource)
    }
    
    // MARK: - Similar Movies configuration
    
    @IBAction func seeAllSimilarsButtonPressed(_ sender: UIButton) {
        viewModel.navigateToList(result: similarMoviesController.dataSource)
    }
    
    // MARK: - Awards configuration
    
    @IBAction func exploreAwardsButtonPressed(_ sender: UIButton) {
        exploreAwardsButton.isEnabled = false
        viewModel.fetchMovieAwards(id: titleID)
    }
    
    // MARK: - Alerts
    
    func errorAlert(with error: Error) {
        let alert = UIAlertController(title: Constants.noInternet, message: Constants.offlineMessage, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: Constants.ok, style: .default, handler: { (action) -> Void in
            print(Constants.okButtonTapped)
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - MovieDetailsViewController - extension

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    
    func onFetchTitleSuccess(model: TitleModel) {
        handleSuccess(titleModel: model)
    }
    
    func onFetchTrailerSuccess(model: TrailerModel) {
        handleSuccess(trailerModel: model)
    }
    
    func onFetchWebDetailsSuccess(model: AllDetailsWebModel) {
        handleSuccess(webDetailsModel: model)
    }
    
    func onFetchRatingSuccess(ratingModel: RatingsModel) {
        handleSuccess(ratingModel: ratingModel)
    }
    
    func presentErrorAlert(error: Error) {
        errorAlert(with: error)
    }
    
    func onFetchMovieAwardsFinished() {
        DispatchQueue.main.async {
            self.exploreAwardsButton.isEnabled = true
        }
    }
}
