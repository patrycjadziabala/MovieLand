//
//  MovieDetailsViewModel.swift
//  MovieLand
//
//  Created by Patka on 04/04/2023.
//

import Foundation
import UIKit

protocol MovieDetailsViewModelProtocol: AnyObject {
    func fetchTitle(id: String)
    func fetchTrailer(id: String)
    func fetchFullDetailsWeb(id: String)
    func navigateToList(result: [SwipeableInformationTilePresentable])
    func navigateToTrailer(urlString: String)
    func navigateToFullDetailsWeb(urlString: String)
    func fetchMovieAwards(id: String)
    func fetchRating(id: String)
    func toggleSeen()
    func isSeen() -> Bool
    func toggleWant()
    func isWant() -> Bool
    var delegate: MovieDetailsViewModelDelegate? { get set }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    let apiManager = APIManager()
    
    weak var delegate: MovieDetailsViewModelDelegate?

    let tabRouter: TabRouterProtocol
    
    let persistenceManager: PersistenceManagerProtocol
    
    var titleModel: TitleModel?
    
    init(tabRouter: TabRouterProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.tabRouter = tabRouter
        self.persistenceManager = persistenceManager
    }
    
    func navigateToTrailer(urlString: String) {
        tabRouter.navigateToWebView(urlString: urlString)
    }
    
    func navigateToFullDetailsWeb(urlString: String) {
        tabRouter.navigateToWebView(urlString: urlString)
    }
    
    func navigateToList(result: [SwipeableInformationTilePresentable]) {
        let mappedResult = result.compactMap { swipeable in
            return swipeable as? ListViewControllerCellPresentable
        }
        tabRouter.navigateToList(results: mappedResult)
    }
    
    func fetchTitle(id: String) {
        apiManager.fetchTitle(id: id) { [weak self] result in
            switch result {
            case .success(let title):
                self?.titleModel = title
                self?.delegate?.onFetchTitleSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchTrailer(id: String) {
        apiManager.fetchTrailer(id: id) { [weak self] result in
            switch result {
            case .success(let trailer):
                self?.delegate?.onFetchTrailerSuccess(model: trailer)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchFullDetailsWeb(id: String) {
        apiManager.fetchAllDetailsWeb(id: id) { [weak self] result in
            switch result {
            case .success(let webDetails):
                self?.delegate?.onFetchWebDetailsSuccess(model: webDetails)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchMovieAwards(id: String) {
        apiManager.fetchMovieAwardsInformation(id: id) { [weak self] result in
            switch result {
            case .success(let awardsResults):
                self?.handleSuccess(awardsResults: awardsResults)
            case .failure(let error):
                self?.handleError(error: error)
            }
            self?.delegate?.onFetchMovieAwardsFinished()
        }
    }
    
    func fetchRating(id: String) {
        apiManager.fetchRatings(id: id) {
            [weak self] result in
            switch result {
            case .success(let rating):
                self?.delegate?.onFetchRatingSuccess(ratingModel: rating)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func handleSuccess(awardsResults: MovieAwardsModel) {
        var arrayMovieAward: [MovieAwardSummaryModel] = []
        for outerItem in awardsResults.items {
            for innerItem in outerItem.outcomeItems {
                let model = MovieAwardSummaryModel(with: innerItem, eventYear: outerItem.eventYear, eventTitle: outerItem.eventTitle)
                arrayMovieAward.append(model)
            }
        }
        self.tabRouter.navigateToList(results: arrayMovieAward)
    }
    
    func handleError(error: Error) {
        self.delegate?.presentErrorAlert(error: error)
    }
    
    // MARK: - Favourites
    
    func toggleSeen() {
        guard let titleModel = self.titleModel else {
            return
        }
        persistenceManager.togglePersisted(model: .seen(model: titleModel))
    }
        
    func isSeen() -> Bool {
        guard let titleModel = self.titleModel else {
            return false
        }
        return persistenceManager.isPersisted(model: .seen(model: titleModel))
    }
    
    func toggleWant() {
        guard let titleModel = self.titleModel else {
            return
        }
        persistenceManager.togglePersisted(model: .want(model: titleModel))
    }
    
    func isWant() -> Bool {
        guard let titleModel = self.titleModel else {
            return false
        }
        return persistenceManager.isPersisted(model: .want(model: titleModel))
    }
    
}

//MARK: - MovieDetailsViewModelDelegate

protocol MovieDetailsViewModelDelegate: AnyObject {
    func onFetchTitleSuccess(model: TitleModel)
    func onFetchTrailerSuccess(model: TrailerModel)
    func onFetchWebDetailsSuccess(model: AllDetailsWebModel)
    func onFetchRatingSuccess(ratingModel: RatingsModel)
    func onFetchMovieAwardsFinished()
    func presentErrorAlert(error: Error)
}
