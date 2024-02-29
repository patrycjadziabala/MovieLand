//
//  APITitleModels.swift
//  MovieLand
//
//  Created by Patka on 16/04/2023.
//

import Foundation

struct TMDBMovieModel: Codable, Equatable {
    let backdrop_path: String
    let budget: Int
    let genres: [TMDBGenreModel]
    let homepage: String
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let poster_path: String
    let release_date: String
    let title: String
    
    func asImdbModel() -> TitleModel {
        TitleModel(id: String(id),
                   title: title,
                   type: "",
                   year: release_date,
                   image: poster_path,
                   releaseDate: release_date,
                   plot: overview,
                   awards: nil,
                   directors: "",
                   stars: "",
                   starList: [],
                   actorList: [],
                   genreList: genres.map {
            $0.asImdbModel()
        },
                   similars: [],
                   errorMessage: "")
    }
}

struct TMDBGenreModel: Codable, Equatable {
    let id: Int
    let name: String
    
    func asImdbModel() -> GenreModel {
        GenreModel(key: String(id),
                   value: name)
    }
}

struct TitleModel: Codable, Equatable {
    let id: String
    let title: String
    let type: String
    let year: String
    let image: String
    let releaseDate: String
    let plot: String
    let awards: String?
    let directors: String
    let stars: String
    let starList: [BasicPersonModel]
    let actorList: [ActorForTitleModel]
    let genreList: [GenreModel]
    let similars: [Similars]
    let errorMessage: String
}

extension TitleModel: TableViewCellPresentable {
    var optionalID: String {
        id
    }
    
    var iMDbRankLabelText: String? {
        nil
    }
    
    var imageUrlString: String? {
        image
    }
    
    var nameLabelText: String? {
        title
    }
    
    var additionalInfoLabelText: String? {
        nil
    }
    
    var yearInfoText: String? {
        year
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
    
    var contentType: CellContentType {
        .title
    }
}

extension TitleModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

struct Similars: Codable, Equatable {
    let id: String
    let title: String
    let image: String
    let imDbRating: String
}

extension Similars: SwipeableInformationTilePresentable {
    
    var contentType: CellContentType {
        .title
    }
    
    var optionalId: String {
        id
    }
    
    var iMDbRankLabelText: String? {
        nil
    }
    
    var titleLabelText: String {
        title
    }
    
    var imageUrlString: String? {
        image
    }
    
    var yearOrAdditionalInfoLabelText: String? {
        nil
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
}

extension Similars: TableViewCellPresentable {
    var optionalID: String {
        id
    }
    
    var additionalInfoLabelText: String? {
        nil
    }
    
    var nameLabelText: String? {
        title
    }
    
    var yearInfoText: String? {
        nil
    }
}

extension Similars: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}
