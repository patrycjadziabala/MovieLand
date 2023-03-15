//
//  ActorModel.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import Foundation

struct PersonModel: Decodable {
    let id: String
    let name: String
    let role: String?
    let image: String
    let summary: String
    let birthDate: String
    let deathDate: String?
    let height: String
    let awards: String
    let knownFor: [KnownForModel]
    let castMovies: [CastMovieModel]
    let errorMessage: String
}

struct KnownForModel: Decodable {
    let id: String
    let title: String
    let year: String?
    let role: String
    let image: String
}

struct CastMovieModel: Decodable, SwipeableInformationTilePresentable {
    let id: String
    let role: String
    let title: String
    let year: String?
    let description: String
}

struct TitleModel: Decodable {
    let id: String
    let title: String
    let type: String
    let year: String
    let image: String
    let releaseDate: String
    let plot: String
    let awards: String
    let directors: String
    let stars: String
    let starList: [BasicPersonModel]
    let actorList: [ActorForTitleModel]
    let genreList: [GenreModel]
    let errorMessage: String
}

struct BasicPersonModel: Decodable {
    let id: String
    let name: String
}

struct ActorForTitleModel: Decodable, SwipeableInformationTilePresentable {
    let id: String
    let image: String
    let name: String
    let asCharacter: String
}

struct GenreModel: Decodable {
    let key: String
    let value: String
}

struct SearchResultsModel: Decodable {
    let results: [Results]
    let searchType: String
    let expression: String
}

struct Results: Decodable {
    let id: String
    let image: String
    let title: String
    let resultType: String?
    let description: String
}

enum ResultType: String {
    case title
    case name
}

struct MostPopularMoviesResultsModel: Decodable {
    let items: [MostPopularItem]
}
struct MostPopularItem: Decodable {
    let id: String
    let rank: String
    let title: String
    let year: String
    let image: String
}
