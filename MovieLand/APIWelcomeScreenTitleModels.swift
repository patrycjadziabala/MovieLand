//
//  APIWelcomeScreenTitleModels.swift
//  MovieLand
//
//  Created by Patka on 16/04/2023.
//

import Foundation

struct ItemsForFeaturedMoviesModel: Codable {
    let items: [FeaturedMoviesModel]
}

struct FeaturedMoviesModel: Codable {
    let id: String
    let rank: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String
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

struct ItemsForComingSoonModel: Codable {
    let items: [ComingSoonModel]
}

struct ComingSoonModel: Codable {
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

struct ItemsforInCinemasModel: Codable {
    let items: [InCinemasModel]
}

struct InCinemasModel: Codable {
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
    var additionalInfoLabelText: String? {
        nil
    }
}

extension InCinemasModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

struct ItemsForBoxOfficeAllTimeModel: Codable {
    let items: [BoxOfficeAllTimeModel]
}

struct BoxOfficeAllTimeModel: Codable {
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
    var additionalInfoLabelText: String? {
        nil
    }
}

extension BoxOfficeAllTimeModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}
