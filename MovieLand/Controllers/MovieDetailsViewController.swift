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
    @IBOutlet weak var wantToWatchButton: UIButton!
    @IBOutlet weak var seenButton: UIButton!
    @IBOutlet weak var awardsViewContainer: UIView!
    @IBOutlet weak var movieImageAndOverviewView: UIView!
    
    
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
    
    deinit {
        print("\(String(describing: Self.self)) dead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleActivity(active: true)
        prepareForShowingMovieInformation()
        prepareToShowFullDetailsWeb()
        configureView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.toggleActivity(active: false)
        }
    }
    
    // MARK: - View Configuration
    
    func configureView() {
        configureCollectionViewActorsInFilm()
        configureCollectionViewSimilarMovies()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        movieImageAndOverviewView.makeRound(radius: 20)
        wantToWatchButton.makeRound()
        seenButton.makeRound()
        genreLabel.makeRound(radius:15)
    }
    
    // MARK: - Movie Information Configuration
    
    func prepareForShowingMovieInformation() {
        exploreAwardsButton.isHidden = true
        viewModel.fetchTitle(id: titleID)
        prepareForShowingTrailer()
        prepareForShowingMovieRatingFromRatingsModel()
        updateSeenIcon(isSeen: false)
        updateWantIcon(isWant: false)
    }
    
    func handleSuccess(titleModel: TitleModel) {
        DispatchQueue.main.async {
            self.seeAllCastButton.isEnabled = true
            self.seeAllSimilarsButton.isEnabled = true
            self.movieTitleLabel.text = titleModel.title
            self.releaseDateLabel.text = titleModel.releaseDate
            self.genreLabel.text = titleModel.genreList.first?.value ?? ""
            self.configureMovieImage(titleModel: titleModel)
            self.movieOverviewTextView.text = titleModel.plot
            self.configureMovieAwards(titleModel: titleModel)
            self.actorsInFilmController.set(dataSource: titleModel.actorList)
            self.similarMoviesController.set(dataSource: titleModel.similars)
            
            self.updateWantIcon(isWant: self.viewModel.isWant())
            self.updateSeenIcon(isSeen: self.viewModel.isSeen())
            //            self.toggleActivity(active: false)
        }
    }
    
    // MARK: - Movie Awards
    
    func configureMovieAwards(titleModel: TitleModel) {
        if let awardsList = titleModel.awards {
            self.exploreAwardsButton.isHidden = false
            self.exploreAwardsButton.backgroundColor = UIColor.cyan
            self.awardsTextView.text = awardsList
        } else {
            self.awardsTextView.isHidden = true
        }
    }
    
    //MARK: - Movie Image
    
    func configureMovieImage(titleModel: TitleModel) {
        let imageUrl = URL(string: titleModel.image)
        self.moviePosterImageView.sd_setImage(with: imageUrl)
    }
    
    // MARK: - Movie rating configuration
    
    func confingureMovieRating(model: Similars) {
        //        ratingScore
    }
    
    func prepareForShowingMovieRatingFromRatingsModel() {
        viewModel.fetchRating(id: titleID)
    }
    
    func handleSuccess(ratingModel: RatingsModel) {
        DispatchQueue.main.async {
            if ratingModel.imDb?.isEmpty ?? true {
                self.ratingScore.isHidden = true
//                self.ratingStarImage.isHidden = true
            } else {
                self.ratingScore.text = ratingModel.imDb
            }
        }
    }
    
    //MARK: - Collection views configuration
    
    func configureCollectionViewActorsInFilm() {
        addChild(actorsInFilmController)
        actorsInFilmScrollableViewContainer.addSubview(actorsInFilmController.view)
        actorsInFilmController.didMove(toParent: self)
        actorsInFilmController.view.constraint(to: actorsInFilmScrollableViewContainer)
    }
    
    func configureCollectionViewSimilarMovies() {
        addChild(similarMoviesController)
        similarMoviesScrollableViewContainer.addSubview(similarMoviesController.view)
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
    
    // MARK: - See Full Details - Web View configuration
    
    func prepareToShowFullDetailsWeb() {
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
    
    // MARK: - Cast
    
    @IBAction func seeAllCastButtonPressed(_ sender: UIButton) {
        viewModel.navigateToList(result: actorsInFilmController.dataSource)
    }
    
    // MARK: - Similar Movies
    
    @IBAction func seeAllSimilarsButtonPressed(_ sender: UIButton) {
        viewModel.navigateToList(result: similarMoviesController.dataSource)
    }
    
    // MARK: - Awards
    
    @IBAction func exploreAwardsButtonPressed(_ sender: UIButton) {
        exploreAwardsButton.isEnabled = false
        viewModel.fetchMovieAwards(id: titleID)
    }
    
    // MARK: - Alerts
    
    func errorAlert(with error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Constants.noInternet, message: Constants.offlineMessage, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: Constants.ok, style: .default, handler: { (action) -> Void in
                print(Constants.okButtonTapped)
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Favourites
    
    @IBAction func wantToWatchButtonPressed(_ sender: UIButton) {
        viewModel.toggleWant()
        updateWantIcon(isWant: viewModel.isWant())
    }
    @IBAction func seenButtonPressed(_ sender: UIButton) {
        viewModel.toggleSeen()
        updateSeenIcon(isSeen: viewModel.isSeen())
    }
    
    func updateSeenIcon(isSeen: Bool) {
        if isSeen {
            seenButton.setImage(Constants.eyeSeenIcon, for: .normal)
        } else {
            seenButton.setImage(Constants.eyeNotSeenIcon, for: .normal)
        }
    }
    
    func updateWantIcon(isWant: Bool) {
        if isWant {
            wantToWatchButton.setImage(Constants.wantToWatch, for: .normal)
        } else {
            wantToWatchButton.setImage(Constants.onWantToWatchList, for: .normal)
        }
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
        toggleActivity(active: false)
        errorAlert(with: error)
    }
    
    func onFetchMovieAwardsFinished() {
        DispatchQueue.main.async {
            self.exploreAwardsButton.isEnabled = true
        }
    }
}
