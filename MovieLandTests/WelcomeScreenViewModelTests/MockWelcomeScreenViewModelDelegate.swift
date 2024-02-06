//
//  MockWelcomeScreenViewModelDelegate.swift
//  MovieLandTests
//
//  Created by Patka on 02/02/2024.
//

import Foundation
@testable import MovieLand

class MockWelcomeScreenViewModelDelegate: WelcomeScreenViewModelDelegate {
    
    var lastOnFetchInCinemaMoviesModel: ItemsforInCinemasModel?
    func onFetchInCinemasMoviesHandleSuccess(model: MovieLand.ItemsforInCinemasModel) {
        lastOnFetchInCinemaMoviesModel = model
    }
    var lastOnFetchFeaturedMoviesModel: ItemsForFeaturedMoviesModel?
    func onFetchFeaturedMoviesHandleSuccess(model: MovieLand.ItemsForFeaturedMoviesModel) {
        lastOnFetchFeaturedMoviesModel = model
    }
    
    var lastOnFetchMostPopularMoviesModel: ItemsForFeaturedMoviesModel?
    func onFetchMostPopularMoviesInformationSuccess(model: MovieLand.ItemsForFeaturedMoviesModel) {
        lastOnFetchMostPopularMoviesModel = model
    }
    
    var lastOnFetchTop250TVSeriesModel: ItemsForFeaturedMoviesModel?
    func onFetchTop250TVSeriesSuccess(model: MovieLand.ItemsForFeaturedMoviesModel) {
        lastOnFetchTop250TVSeriesModel = model
    }
    
    var lastOnFetchMostPopularTVSeriesModel: ItemsForFeaturedMoviesModel?
    func onFetchMostPopularTVSeriesSuccess(model: MovieLand.ItemsForFeaturedMoviesModel) {
        lastOnFetchMostPopularTVSeriesModel = model
    }
    
    var lastOnFetchBoxOfficeAllTimeModel: ItemsForBoxOfficeAllTimeModel?
    func onFetchBoxOfficeAllTimeSuccess(model: MovieLand.ItemsForBoxOfficeAllTimeModel) {
        lastOnFetchBoxOfficeAllTimeModel = model
    }
    
    var lastOnFetchComingSoonModel: [ComingSoonModel]?
    func onFetchComingSoonSuccess(models: [MovieLand.ComingSoonModel]) {
        lastOnFetchComingSoonModel = models
    }
    
    var lastPresentedError: MockAPIManagerError?
    func presentError(error: Error) {
        lastPresentedError = (error as! MockAPIManagerError)
    }
}

