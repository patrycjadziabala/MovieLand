//
//  DataManager.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import Foundation

protocol APIManagerProtocol: AnyObject {
    func fetchPersonInformation(id: String, completion: @escaping (Result<PersonModel, Error>) -> Void)
    
    func fetchTitle(id: String, completion: @escaping (Result<TitleModel, Error>) -> Void)
    
    func fetchSearchResults(query: String, completion: @escaping (Result<SearchResultsModel, Error>) -> Void)
}

enum APIEndpoint: String {
    case name
    case title
    case searchMovie
    case searchAll
}

enum APIManagerError: Error {
    case couldNotBuildURL
    case unknownError
}

class APIManager: APIManagerProtocol {
    
    let baseURLString: String = "https://imdb-api.com/<language>/API/<endpoint>/k_bv6bughg/"
    
    let language: String
    
    init(language: String = "en") {
        self.language = language
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
    
    func fetchPersonInformation(id: String, completion: @escaping (Result<PersonModel, Error>) -> Void) {
        guard let url = buildURL(for: .name, id: id) else {
            completion(.failure(APIManagerError.couldNotBuildURL))
            return
        }
        // TODO: - Make it generic and reuse
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(PersonModel.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(APIManagerError.unknownError))
            }
        }
        task.resume()
    }
    
    func fetchTitle(id: String, completion: @escaping (Result<TitleModel, Error>) -> Void) {
        guard let url = buildURL(for: .title, id: id) else {
            
            completion(.failure(APIManagerError.couldNotBuildURL))
            return
        }
        // TODO: - Make it generic and reuse
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
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
        task.resume()
    }
    
    
    func fetchSearchResults(query: String, completion: @escaping (Result<SearchResultsModel, Error>) -> Void) {
            guard let url = buildURL(for: .searchAll, id: query) else {
        
                completion(.failure(APIManagerError.couldNotBuildURL))
                return
            }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
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
            task.resume()
        }
}

