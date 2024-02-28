//
//  TMDB-APIManager.swift
//  MovieLand
//
//  Created by Patka on 13/02/2024.
//

import Foundation

enum TMDBAPIManagerError: Error {
    case invalidURL
    case badResponse
    case basStatus
    case failedToDecodeResponse
    case notImplementedYet
}
    
enum TMDBEndpointType: String {
    case movie
    case person
}

enum TMDBAPIEndpoint: String {
    case name
    case popular
}

class TMDBAPIManager: APIManagerProtocol {
    
    let baseURLString: String = "https://api.themoviedb.org/3/<type>/<endpoint>?api_key=29d1eac12ae7da1b5df0ba13aca09837"
    
    var currentTasks: [URLSessionDataTask] = []
    
    private let configuration: URLSessionConfiguration
    
    init(configuration: URLSessionConfiguration = .default) {
        self.configuration = configuration
    }
    
//    func buildURL(for type: TMDBEndpointType, for endpoint: TMDBAPIEndpoint, id: String) -> URL? {
//        let urlString: String
//      return URL(string: urlString)
//    }
    
    func buildURLforFeaturedMovies(for type: TMDBEndpointType, for endpoint: TMDBAPIEndpoint) -> URL? {
        let urlString = baseURLString.replacingOccurrences(of: "<type>", with: type.rawValue)
            .replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            return nil
        }
        return URL(string: urlString)
    }
    
    func fetchPersonInformation(id: String, completion: @escaping (Result<PersonModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchTitle(id: String, completion: @escaping (Result<TitleModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchTrailer(id: String, completion: @escaping (Result<TrailerModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchSearchResults(query: String, completion: @escaping (Result<SearchResultsModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchFeaturedMoviesResults(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchInCinemasMoviesInformation(completion: @escaping (Result<ItemsforInCinemasModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchMostPopularMoviesInformation(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void) {
        guard let url = buildURLforFeaturedMovies(for: .movie, for: .popular) else {
            completion(.failure(APIManagerError.couldNotBuildURL))
            return
        }
        let session = URLSession(configuration: configuration)
        var currentTask: URLSessionDataTask?
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            self?.currentTasks.removeAll { storedTask in
                storedTask === currentTask
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    var decodedData = try decoder.decode(ResultsForPopularMoviesModel.self, from: data)
                    completion(.success(decodedData.mapToOldModel()))
                    return
                } catch {
                    completion(.failure(error))
                    return
                }
            }
            completion(.failure(APIManagerError.unknownError))
        }
        currentTask = task
        task.resume()
        currentTasks.append(task)
    }
    
    func fetchTop250TVSeriesResults(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchMostPopularTVSeriesInformation(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchBoxOfficeAllTime(completion: @escaping (Result<ItemsForBoxOfficeAllTimeModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchPersonAwardsInformation(id: String, completion: @escaping (Result<PersonAwardsModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchMovieAwardsInformation(id: String, completion: @escaping (Result<MovieAwardsModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchAllDetailsWeb(id: String, completion: @escaping (Result<AllDetailsWebModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchRatings(id: String, completion: @escaping (Result<RatingsModel, Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func fetchComingSoon(completion: @escaping (Result<[ComingSoonModel], Error>) -> Void) {
        completion(.failure(TMDBAPIManagerError.notImplementedYet))
    }
    
    func cancelCurrentTasks() {
        
    }
}
