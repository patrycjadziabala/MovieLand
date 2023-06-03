//
//  MockAPIManager.swift
//  MovieLandTests
//
//  Created by Patka on 03/06/2023.
//

import Foundation
@testable import MovieLand

final class MockAPIManager: APIManagerProtocol {
    func fetchPersonInformation(id: String, completion: @escaping (Result<MovieLand.PersonModel, Error>) -> Void) {
        
    }
    
    var expectedFetchTitleResult: Result<MovieLand.TitleModel, Error>?
    var lastFetchTitleId: String?
    func fetchTitle(id: String, completion: @escaping (Result<MovieLand.TitleModel, Error>) -> Void) {
        completion(expectedFetchTitleResult!)
    }
    
    func fetchTrailer(id: String, completion: @escaping (Result<MovieLand.TrailerModel, Error>) -> Void) {
        
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
    
    func fetchMovieAwardsInformation(id: String, completion: @escaping (Result<MovieLand.MovieAwardsModel, Error>) -> Void) {
        
    }
    
    func fetchAllDetailsWeb(id: String, completion: @escaping (Result<MovieLand.AllDetailsWebModel, Error>) -> Void) {
        
    }
    
    func fetchRatings(id: String, completion: @escaping (Result<MovieLand.RatingsModel, Error>) -> Void) {
        
    }
    
    func fetchComingSoon(completion: @escaping (Result<[MovieLand.ComingSoonModel], Error>) -> Void) {
        
    }
    
    func cancelCurrentTasks() {
        
    }
}
