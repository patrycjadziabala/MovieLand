//
//  MovieDetailsViewModel.swift
//  MovieLand
//
//  Created by Patka on 04/04/2023.
//

import Foundation

protocol MovieDetailsViewModelProtocol: AnyObject {
    func fetchTitle(id: String)
    func fetchTrailer(id: String)
    func navigateToList(result: [SwipeableInformationTilePresentable])
    func navigateToTrailer(urlString: String)
    func fetchMovieAwards(id: String)
    var delegate: MovieDetailsViewModelDelegate? { get set }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    let apiManager = APIManager()
    
    var delegate: MovieDetailsViewModelDelegate?

    let tabRouter: TabRouterProtocol
    
    init(tabRouter: TabRouterProtocol) {
        self.tabRouter = tabRouter
    }
    
    func navigateToTrailer(urlString: String) {
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
                self?.delegate?.onFetchTitleSuccess(model: title)
            case .failure(let error):
                self?.delegate?.onFetchTitleError(error: error)
            }
        }
    }
    
    func fetchTrailer(id: String) {
        apiManager.fetchTrailer(id: id) { [weak self] result in
            switch result {
            case .success(let trailer):
                self?.delegate?.onFetchTrailerSuccess(model: trailer)
            case .failure(let error):
                self?.delegate?.onFetchTrailerError(error: error)
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
        }
    }
    
    func handleSuccess(awardsResults: MovieAwardsModel) {
        DispatchQueue.main.async {
            var array: [MovieAwardSummaryModel] = []
            for outerItem in awardsResults.items {
                for innerItem in outerItem.outcomeItems {
                    let model = MovieAwardSummaryModel(with: innerItem, eventYear: outerItem.eventYear, eventTitle: outerItem.eventTitle)
                    array.append(model)
                }
            }
            self.tabRouter.navigateToList(results: array)
        }
    }
    
    func handleError(error: Error) {
        print(error)
//        DispatchQueue.main.async {
//            self.presentAlert(with: error)
//        }
    }
}

protocol MovieDetailsViewModelDelegate {
    func onFetchTitleSuccess(model: TitleModel)
    func onFetchTitleError(error: Error)
    func onFetchTrailerSuccess(model: TrailerModel)
    func onFetchTrailerError(error: Error)
    func onFetchMovieAwardError(error: Error)
}
