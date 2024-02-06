//
//  MockAPIManager.swift
//  MovieLandTests
//
//  Created by Patka on 03/06/2023.
//

import Foundation
@testable import MovieLand

enum MockAPIManagerError: Error {
    case genericError
}

final class MockAPIManager: APIManagerProtocol {
    var expectedFetchPersonInformationResult: Result<MovieLand.PersonModel, Error>?
    var lastFetchPersonId: String?
    func fetchPersonInformation(id: String, completion: @escaping (Result<MovieLand.PersonModel, Error>) -> Void) {
        lastFetchPersonId = id
        completion(expectedFetchPersonInformationResult!)
    }
    
    var expectedFetchTitleResult: Result<MovieLand.TitleModel, Error>?
    var lastFetchTitleId: String?
    func fetchTitle(id: String, completion: @escaping (Result<MovieLand.TitleModel, Error>) -> Void) {
        lastFetchTitleId = id
        completion(expectedFetchTitleResult!)
    }
    
    var expectedFetchTrailerResult: Result<MovieLand.TrailerModel, Error>?
    var lastFetchTrailerId: String?
    func fetchTrailer(id: String, completion: @escaping (Result<MovieLand.TrailerModel, Error>) -> Void) {
        lastFetchTrailerId = id
        completion(expectedFetchTrailerResult!)
    }
    
    func fetchSearchResults(query: String, completion: @escaping (Result<MovieLand.SearchResultsModel, Error>) -> Void) {
        
    }
    
    var expectedFetchFeaturedMoviesResults: Result<ItemsForFeaturedMoviesModel, Error>?
    func fetchFeaturedMoviesResults(completion: @escaping (Result<MovieLand.ItemsForFeaturedMoviesModel, Error>) -> Void) {
        completion(expectedFetchFeaturedMoviesResults!)
    }
    
    var expectedInCinemasMoviesInformationResult: Result<ItemsforInCinemasModel, Error>?
    func fetchInCinemasMoviesInformation(completion: @escaping (Result<MovieLand.ItemsforInCinemasModel, Error>) -> Void) {
        completion(expectedInCinemasMoviesInformationResult!)
    }
    
    var expectedFetchMostPopularMoviesResult: Result<ItemsForFeaturedMoviesModel, Error>?
    func fetchMostPopularMoviesInformation(completion: @escaping (Result<MovieLand.ItemsForFeaturedMoviesModel, Error>) -> Void) {
        completion(expectedFetchMostPopularMoviesResult!)
    }
    
    var expectedFetchTop250SeriesResult: Result<ItemsForFeaturedMoviesModel, Error>?
    func fetchTop250TVSeriesResults(completion: @escaping (Result<MovieLand.ItemsForFeaturedMoviesModel, Error>) -> Void) {
        completion(expectedFetchTop250SeriesResult!)
    }
    
    var expectedFetchMostPopularTVSeriesResult: Result<ItemsForFeaturedMoviesModel, Error>?
    func fetchMostPopularTVSeriesInformation(completion: @escaping (Result<MovieLand.ItemsForFeaturedMoviesModel, Error>) -> Void) {
        completion(expectedFetchMostPopularTVSeriesResult!)
    }
    
    var expectedFetchBoxOfficeAllTimeResult: Result<ItemsForBoxOfficeAllTimeModel, Error>?
    func fetchBoxOfficeAllTime(completion: @escaping (Result<MovieLand.ItemsForBoxOfficeAllTimeModel, Error>) -> Void) {
        completion(expectedFetchBoxOfficeAllTimeResult!)
    }
    
    var expectedFetchPersonAwardsInformationResult: Result<MovieLand.PersonAwardsModel, Error>?
    var lastFetchPersonAwardsInformationId: String?
    func fetchPersonAwardsInformation(id: String, completion: @escaping (Result<MovieLand.PersonAwardsModel, Error>) -> Void) {
        lastFetchPersonAwardsInformationId = id
        completion(expectedFetchPersonAwardsInformationResult!)
    }
    
    var expectedFetchMovieAwardsInformationResult: Result<MovieLand.MovieAwardsModel, Error>?
    var lastFetchMovieAwardsInformationId: String?
    func fetchMovieAwardsInformation(id: String, completion: @escaping (Result<MovieLand.MovieAwardsModel, Error>) -> Void) {
        lastFetchMovieAwardsInformationId = id
        completion(expectedFetchMovieAwardsInformationResult!)
    }
    
    var expectedFetchAllDetailsWebResult: Result<MovieLand.AllDetailsWebModel, Error>?
    var lastFetchDetailId: String?
    func fetchAllDetailsWeb(id: String, completion: @escaping (Result<MovieLand.AllDetailsWebModel, Error>) -> Void) {
        lastFetchDetailId = id
        completion(expectedFetchAllDetailsWebResult!)
    }
    var expectedFetchRatingResult: Result<MovieLand.RatingsModel, Error>?
    var lastFetchRatingId: String?
    func fetchRatings(id: String, completion: @escaping (Result<MovieLand.RatingsModel, Error>) -> Void) {
        lastFetchRatingId = id
        completion(expectedFetchRatingResult!)
    }
    
    var expectedFetchComingSoonResult: Result<[MovieLand.ComingSoonModel], Error>?
    func fetchComingSoon(completion: @escaping (Result<[MovieLand.ComingSoonModel], Error>) -> Void) {
        completion(expectedFetchComingSoonResult!)
    }
    
    func cancelCurrentTasks() {
        
    }
}
