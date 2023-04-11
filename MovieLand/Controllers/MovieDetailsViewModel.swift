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
    func fetchFullDetailsWeb(id: String)
    func navigateToList(result: [SwipeableInformationTilePresentable])
    func navigateToTrailer(urlString: String)
    func navigateToFullDetailsWeb(urlString: String)
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
    
    func fetchFullDetailsWeb(id: String) {
        apiManager.fetchAllDetailsWeb(id: id) { [weak self] result in
            switch result {
            case .success(let webDetails):
                self?.delegate?.onFetchWebDetailsSuccess(model: webDetails)
            case .failure(let error):
                self?.delegate?.onFetchWebDetailsError(error: error)
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
            var arrayMovieAward: [MovieAwardSummaryModel] = []
            for outerItem in awardsResults.items {
                for innerItem in outerItem.outcomeItems {
                    let model = MovieAwardSummaryModel(with: innerItem, eventYear: outerItem.eventYear, eventTitle: outerItem.eventTitle)
                    arrayMovieAward.append(model)
                }
            }
            self.tabRouter.navigateToList(results: arrayMovieAward)
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
    func onFetchWebDetailsSuccess(model: AllDetailsWebModel)
    func onFetchWebDetailsError(error: Error)
    func onFetchMovieAwardError(error: Error)
}
