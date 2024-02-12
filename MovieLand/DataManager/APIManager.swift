//
//  DataManager.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import Foundation
import SafariServices
import UIKit

protocol APIManagerProtocol: AnyObject {
    func fetchPersonInformation(id: String, completion: @escaping (Result<PersonModel, Error>) -> Void)
    func fetchTitle(id: String, completion: @escaping (Result<TitleModel, Error>) -> Void)
    func fetchTrailer(id: String, completion: @escaping(Result<TrailerModel, Error>) -> Void)
    func fetchSearchResults(query: String, completion: @escaping (Result<SearchResultsModel, Error>) -> Void)
    func fetchFeaturedMoviesResults(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void)
    func fetchInCinemasMoviesInformation(completion: @escaping (Result<ItemsforInCinemasModel, Error>) -> Void)
    func fetchMostPopularMoviesInformation(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void)
    func fetchTop250TVSeriesResults(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void)
    func fetchMostPopularTVSeriesInformation(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void)
    func fetchBoxOfficeAllTime(completion: @escaping (Result<ItemsForBoxOfficeAllTimeModel, Error>) -> Void)
    func fetchPersonAwardsInformation(id: String, completion: @escaping (Result<PersonAwardsModel, Error>) -> Void)
    func fetchMovieAwardsInformation(id: String, completion: @escaping (Result<MovieAwardsModel, Error>) -> Void)
    func fetchAllDetailsWeb(id: String, completion: @escaping(Result<AllDetailsWebModel, Error>) -> Void)
    func fetchRatings(id: String, completion: @escaping (Result<RatingsModel, Error>) -> Void)
    func fetchComingSoon(completion: @escaping (Result<[ComingSoonModel], Error>) -> Void)
    func cancelCurrentTasks()
}

enum APIEndpoint: String {
    case name
    case title
    case searchMovie
    case searchAll
    case trailer
    case externalSites
    case top250Movies
    case boxoffice
    case mostPopularMovies
    case top250TVs
    case mostPopularTVs
    case boxOfficeAllTime
    case nameAwards
    case awards
    case ratings
    case comingSoon
}

enum APIManagerError: Error {
    case couldNotBuildURL
    case unknownError
}

class APIManager: APIManagerProtocol {
    
    let baseURLString: String = "https://tv-api.com//<language>/API/<endpoint>/k_bdv8grxf/"
    
    let language: String
    
    var currentTasks: [URLSessionDataTask] = []
    
    private let configuration: URLSessionConfiguration
    
    init(language: String = "en", configuration: URLSessionConfiguration = .default) {
        self.language = language
        self.configuration = configuration
    }
    
    func buildURL(for endpoint: APIEndpoint, id: String) -> URL? {
        let urlString = baseURLString
            .replacingOccurrences(of: "<language>", with: language)
            .replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue.capitalized)
            .appending(id)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let urlString = urlString else {
            return nil
        }
        return URL(string: urlString)
    }
    
    func buildURLForFeaturedMovies(for endpoint: APIEndpoint) -> URL? {
        let urlString = baseURLString
            .replacingOccurrences(of: "<language>", with: language)
            .replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue.capitalized)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            return nil
        }
        return URL(string: urlString)
    }
    
    func fetchPersonInformation(id: String, completion: @escaping (Result<PersonModel, Error>) -> Void) {
        guard let url = buildURL(for: .name, id: id) else {
            completion(.failure(APIManagerError.couldNotBuildURL))
            return
        }
        // TODO: - Make it generic and reuse
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
                    let decodedData = try decoder.decode(PersonModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchTitle(id: String, completion: @escaping (Result<TitleModel, Error>) -> Void) {
        guard let url = buildURL(for: .title, id: id) else {
            completion(.failure(APIManagerError.couldNotBuildURL))
            return
        }
        // TODO: - Make it generic and reuse
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
                    let decodedData = try decoder.decode(TitleModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchSearchResults(query: String, completion: @escaping (Result<SearchResultsModel, Error>) -> Void) {
        guard let url = buildURL(for: .searchAll, id: query) else {
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
                    let decodedData =  try decoder.decode(SearchResultsModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchTrailer(id: String, completion: @escaping(Result<TrailerModel, Error>) -> Void) {
        guard let url = buildURL(for: .trailer, id: id) else {
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
                    let decodedData =  try decoder.decode(TrailerModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchAllDetailsWeb(id: String, completion: @escaping(Result<AllDetailsWebModel, Error>) -> Void) {
        guard let url = buildURL(for: .externalSites, id: id) else {
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
                    let decodedData = try decoder.decode(AllDetailsWebModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchFeaturedMoviesResults(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void) {
        guard let url = buildURLForFeaturedMovies(for: .top250Movies) else {
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
                    let decodedData = try decoder.decode(ItemsForFeaturedMoviesModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchInCinemasMoviesInformation(completion: @escaping (Result<ItemsforInCinemasModel, Error>) -> Void) {
        guard let url = buildURLForFeaturedMovies(for: .boxoffice) else {
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
                    let decodedData = try decoder.decode(ItemsforInCinemasModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchMostPopularMoviesInformation(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void) {
        guard let url = buildURLForFeaturedMovies(for: .mostPopularMovies) else {
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
                    let decodedData = try decoder.decode(ItemsForFeaturedMoviesModel.self, from: data)
                    completion(.success(decodedData))
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
        guard let url = buildURLForFeaturedMovies(for: .top250TVs) else {
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
                    let decodedData = try decoder.decode(ItemsForFeaturedMoviesModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchMostPopularTVSeriesInformation(completion: @escaping (Result<ItemsForFeaturedMoviesModel, Error>) -> Void) {
        guard let url = buildURLForFeaturedMovies(for: .mostPopularTVs) else {
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
                    let decodedData = try decoder.decode(ItemsForFeaturedMoviesModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchBoxOfficeAllTime(completion: @escaping (Result<ItemsForBoxOfficeAllTimeModel, Error>) -> Void) {
        guard let url = buildURLForFeaturedMovies(for: .boxOfficeAllTime) else {
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
                    let decodedData = try decoder.decode(ItemsForBoxOfficeAllTimeModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchPersonAwardsInformation(id: String, completion: @escaping (Result<PersonAwardsModel, Error>) -> Void) {
        guard let url = buildURL(for: .nameAwards, id: id) else {
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
                    let decodedData = try decoder.decode(PersonAwardsModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchMovieAwardsInformation(id: String, completion: @escaping (Result<MovieAwardsModel, Error>) -> Void) {
        guard let url = buildURL(for: .awards, id: id) else {
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
                    let decodedData = try decoder.decode(MovieAwardsModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func fetchRatings(id: String, completion: @escaping (Result<RatingsModel, Error>) -> Void) {
        guard let url = buildURL(for: .ratings, id: id) else {
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
                    let decodedData = try decoder.decode(RatingsModel.self, from: data)
                    completion(.success(decodedData))
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
    
    func cancelCurrentTasks() {
        currentTasks.forEach { task in
            task.cancel()
        }
    }
    
    func fetchComingSoon(completion: @escaping (Result<[ComingSoonModel], Error>) -> Void) {
        guard let url = buildURLForFeaturedMovies(for: .comingSoon) else {
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
                    let decodedData = try decoder.decode(ItemsForComingSoonModel.self, from: data)
                    completion(.success(decodedData.items))
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
}
