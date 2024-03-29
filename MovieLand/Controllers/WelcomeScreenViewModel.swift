//
//  WelcomeScreenViewModel.swift
//  MovieLand
//
//  Created by Patka on 12/04/2023.
//

import Foundation

protocol WelcomeScreenViewModelProtocol: AnyObject {
    var delegate: WelcomeScreenViewModelDelegate? { get set }
    func fetchInCinemaMoviesInformation()
    func fetchFeaturedMoviesResults()
    func fetchMostPopularMoviesInformation()
    func fetchTop250TVSeries()
    func fetchMostPopularTVSeries()
    func fetchBoxOfficeAllTime()
    func fetchComingSoon()
}

class WelcomeScreenViewModel: WelcomeScreenViewModelProtocol {
    
    let apiManager: APIManagerProtocol
    weak var delegate: WelcomeScreenViewModelDelegate?
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchComingSoon() {
        apiManager.fetchComingSoon { [weak self] result in
            switch result {
            case .success(let title):
                self?.delegate?.onFetchComingSoonSuccess(models: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchInCinemaMoviesInformation() {
        apiManager.fetchInCinemasMoviesInformation { [weak self] result in
            switch result {
            case .success(let title):
                self?.delegate?.onFetchInCinemasMoviesHandleSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchFeaturedMoviesResults() {
        apiManager.fetchFeaturedMoviesResults { [weak self] result in
            switch result {
            case .success(let title):
                self?.delegate?.onFetchFeaturedMoviesHandleSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchMostPopularMoviesInformation() {
        apiManager.fetchMostPopularMoviesInformation { [weak self] result in
            switch result {
            case .success(let title):
                self?.delegate?.onFetchMostPopularMoviesInformationSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchTop250TVSeries() {
        apiManager.fetchTop250TVSeriesResults { [weak self] result in
            switch result {
            case .success(let title):
                self?.delegate?.onFetchTop250TVSeriesSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchMostPopularTVSeries() {
        apiManager.fetchMostPopularTVSeriesInformation { [weak self] result in
            switch result {
            case .success(let title):
                self?.delegate?.onFetchMostPopularTVSeriesSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchBoxOfficeAllTime() {
        apiManager.fetchBoxOfficeAllTime { [weak self] result in
            switch result {
            case .success(let title):
                self?.delegate?.onFetchBoxOfficeAllTimeSuccess(model: title)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func handleError(error: Error) {
        print(error)
        delegate?.presentError(error: error)
    }
}

// MARK: - WelcomeScreenViewModelDelegate

protocol WelcomeScreenViewModelDelegate: AnyObject {
    
    func onFetchInCinemasMoviesHandleSuccess(model: ItemsforInCinemasModel)
    func onFetchFeaturedMoviesHandleSuccess(model: ItemsForFeaturedMoviesModel)
    func onFetchMostPopularMoviesInformationSuccess(model: ItemsForFeaturedMoviesModel)
    func onFetchTop250TVSeriesSuccess(model: ItemsForFeaturedMoviesModel)
    func onFetchMostPopularTVSeriesSuccess(model: ItemsForFeaturedMoviesModel)
    func onFetchBoxOfficeAllTimeSuccess(model: ItemsForBoxOfficeAllTimeModel)
    func onFetchComingSoonSuccess(models: [ComingSoonModel])
    func presentError(error: Error)
}
