//
//  APIWelcomeScreenTitleModels.swift
//  MovieLand
//
//  Created by Patka on 16/04/2023.
//

import Foundation

struct ResultsForPopularMoviesModel: Codable {
    let page: Int
    let results: [PopularMoviesModel]
    
    func mapToOldModel() -> ItemsForFeaturedMoviesModel {
        let items = results.map {
            $0.asImdbModel()
        }
        return ItemsForFeaturedMoviesModel(items: items)
    }
}

struct PopularMoviesModel: Codable, Equatable {
    let genre_ids: [Int]
    var id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Float
    let poster_path: String
    let release_date: String
    let title: String
    let vote_average: Float
    let vote_count: Int

    func asImdbModel() -> FeaturedMoviesModel {
        FeaturedMoviesModel(id: String(id),
                            rank: nil,
                            title: title,
                            fullTitle: original_title,
                            year: release_date,
                            image: poster_path,
                            crew: nil,
                            imDbRating: String(vote_average))
    }
}

struct ItemsForFeaturedMoviesModel: Codable, Equatable {
    var items: [FeaturedMoviesModel]
}

struct FeaturedMoviesModel: Codable, Equatable {
    let id: String
    let rank: String?
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String?
    let imDbRating: String
}

extension FeaturedMoviesModel: SwipeableInformationTilePresentable {
    var yearOrAdditionalInfoLabelText: String? {
        year
    }
    
    var optionalId: String {
        id
    }
    
    var titleLabelText: String {
        title
    }
}

extension FeaturedMoviesModel: TableViewCellPresentable {
    var optionalID: String {
        id
    }
    
    var contentType: CellContentType {
        .title
    }
    
    var iMDbRankLabelText: String? {
        rank
    }
    
    var imageUrlString: String? {
        image
    }
    
    var nameLabelText: String? {
        title
    }
    
    var additionalInfoLabelText: String? {
        crew
    }
    
    var yearInfoText: String? {
        year
    }
    
    var iMDbRatingNumberLabelText: String? {
        imDbRating
    }
}

extension FeaturedMoviesModel: ListViewControllerCellPresentable {

    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

struct ItemsForComingSoonModel: Codable, Equatable {
    let items: [ComingSoonModel]
}

struct ComingSoonModel: Codable, Equatable {
    let id: String
    let title: String
    let fullTitle: String?
    let year: String?
    let releaseState: String?
    let image: String
    let genres: String?
    let genreList: [GenreList]
    let stars: String?
    let imDbRating: String?   
}

extension ComingSoonModel: SwipeableInformationTilePresentable {
    var yearOrAdditionalInfoLabelText: String? {
        year
    }
    var optionalId: String {
        id
    }
    var titleLabelText: String {
        title
    }
}

extension ComingSoonModel: TableViewCellPresentable {
    var optionalID: String {
        id
    }
    
    var contentType: CellContentType {
        .title
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
        stars
    }
    
    var yearInfoText: String? {
        "Release Date: \(releaseState ?? "Unknown")"
    }
    
    var iMDbRatingNumberLabelText: String? {
        imDbRating
    }
}

extension ComingSoonModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

struct ItemsforInCinemasModel: Codable, Equatable {
    let items: [InCinemasModel]
}

struct InCinemasModel: Codable, Equatable {
    let id: String
    let title: String
    let image: String
}

extension InCinemasModel: SwipeableInformationTilePresentable {
    
    var nameLabelText: String? {
        title
    }
    
    var yearInfoText: String? {
        nil
    }
    
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

extension InCinemasModel: TableViewCellPresentable {
    var optionalID: String {
        id
    }
    
    var additionalInfoLabelText: String? {
        nil
    }
}

extension InCinemasModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

struct ItemsForBoxOfficeAllTimeModel: Codable, Equatable {
    let items: [BoxOfficeAllTimeModel]
}

struct BoxOfficeAllTimeModel: Codable, Equatable {
    let id: String
    let rank: String
    let title: String
    let worldwideLifetimeGross: String
    let domesticLifetimeGross: String
    let domestic: String
    let foreignLifetimeGross: String
    let foreign: String
    let year: String
}

extension BoxOfficeAllTimeModel: SwipeableInformationTilePresentable {
    var iMDbRankLabelText: String? {
        rank
    }
    
    var imageUrlString: String? {
        nil
    }
    
    var nameLabelText: String? {
        title
    }
    
    var yearOrAdditionalInfoLabelText: String? {
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
    
    var optionalId: String {
        id
    }
    
    var titleLabelText: String {
        title
    }
}

extension BoxOfficeAllTimeModel: TableViewCellPresentable {
    var optionalID: String {
        id
    }
    
    var additionalInfoLabelText: String? {
        nil
    }
}

extension BoxOfficeAllTimeModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}
