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
    func fetchPersonInformation(id: String, completion: @escaping (Result<MovieLand.PersonModel, Error>) -> Void) {
        
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
    
    func fetchFeaturedMoviesResults(completion: @escaping (Result<MovieLand.ItemsForFeaturedMoviesModel, Error>) -> Void) {
        
    }
    
    func fetchInCinemasMoviesInformation(completion: @escaping (Result<MovieLand.ItemsforInCinemasModel, Error>) -> Void) {
        
    }
    
    func fetchMostPopularMoviesInformation(completion: @escaping (Result<MovieLand.ItemsForFeaturedMoviesModel, Error>) -> Void) {
        
    }
    
    func fetchTop250TVSeriesResults(completion: @escaping (Result<MovieLand.ItemsForFeaturedMoviesModel, Error>) -> Void) {
        
    }
    
    func fetchMostPopularTVSeriesInformation(completion: @escaping (Result<MovieLand.ItemsForFeaturedMoviesModel, Error>) -> Void) {
        
    }
    
    func fetchBoxOfficeAllTime(completion: @escaping (Result<MovieLand.ItemsForBoxOfficeAllTimeModel, Error>) -> Void) {
        
    }
    
    func fetchPersonAwardsInformation(id: String, completion: @escaping (Result<MovieLand.PersonAwardsModel, Error>) -> Void) {
        
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
    
    func fetchComingSoon(completion: @escaping (Result<[MovieLand.ComingSoonModel], Error>) -> Void) {
        
    }
    
    func cancelCurrentTasks() {
        
    }
}
