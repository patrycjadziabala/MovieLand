//
//  MovieViewController.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import UIKit
import SDWebImage
import SafariServices

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
    
    let actorsInFilmController: SwipeableInformationTilesController
    let similarMoviesController: SwipeableInformationTilesController
    let titleID: String
    let tabRouter: TabRouterProtocol
    var trailerUrl: String = ""
    
    init(titleID: String, tabRouter: TabRouterProtocol) {
        self.titleID = titleID
        self.tabRouter = tabRouter
        self.actorsInFilmController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.similarMoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        
        super.init(nibName: nil, bundle: nil)
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
        let apiManager = APIManager()
        apiManager.fetchTitle(id: titleID) { [weak self] result in
            switch result {
            case .success(let title):
                self?.handleSuccess(titleModel: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
            print(result)
        }
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
            self.actorsInFilmController.dataSource = titleModel.actorList
            self.similarMoviesController.dataSource = titleModel.similars
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
        
        let apiManager = APIManager()
        apiManager.fetchTrailer(id: titleID) { [weak self] result in
            switch result {
            case .success(let trailer):
                self?.handleSuccess(trailerModel: trailer)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func handleSuccess(trailerModel: TrailerModel) {
        DispatchQueue.main.async {
            let trailerImageUrl = URL(string: trailerModel.thumbnailUrl)
            self.trailerImageView.sd_setImage(with: trailerImageUrl)
            self.trailerUrl = trailerModel.link
        }
    }
    
    func showTrailer(urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.showTrailer(urlString: self.trailerUrl)
        }
    }
}

// MARK: - SFSafariViewControllerDelegate

extension MovieDetailsViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
    }
}
