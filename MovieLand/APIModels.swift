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
    let birthDate: String?
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

struct CastMovieModel: Decodable {
    let id: String
    let role: String
    let title: String
    let year: String?
    let description: String
}

extension CastMovieModel: SwipeableInformationTilePresentable {
    var cellType: CellType {
        .title
    }
    
    var iMDbRankLabelText: String? {
        nil
    }
    
    var titleLabelText: String {
        title
    }
    
    var imageUrlString: String? {
        nil
    }
    
    var additionalInfoLabelText: String? {
        role
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
    
    var optionalId: String {
        id
    }
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
    let similars: [Similars]
    let errorMessage: String
}

struct TrailerModel: Decodable {
    let imDbId: String
    let link: String
    let linkEmbed: String
    let thumbnailUrl: String
}

struct BasicPersonModel: Decodable {
    let id: String
    let name: String
}

struct ActorForTitleModel: Decodable {
    let id: String
    let image: String
    let name: String
    let asCharacter: String
}

extension ActorForTitleModel: SwipeableInformationTilePresentable {
    
    var cellType: CellType {
        .name
    }
    
    var optionalId: String {
        id
    }
    
    var iMDbRankLabelText: String? {
        nil
    }
    
    var titleLabelText: String {
        name
    }
    
    var imageUrlString: String? {
        nil
    }
    
    var additionalInfoLabelText: String? {
        asCharacter
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
}

struct GenreModel: Decodable {
    let key: String
    let value: String
}

struct Similars: Decodable {
    let id: String
    let title: String
    let image: String
}

extension Similars: SwipeableInformationTilePresentable {
    
    var cellType: CellType {
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
    
    var additionalInfoLabelText: String? {
        nil
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
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

extension Results: TableViewCellPresentable {
    var cellType: CellType {
        CellType(rawValue: resultType?.lowercased() ?? "") ?? .unknown
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
        description
    }
    
    var yearInfoText: String? {
        nil
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
    
    
}

enum CellType: String {
    case title
    case name
    case unknown
}

//struct MostPopularMoviesResultsModel: Decodable {
//    let items: [MostPopularItem]
//}
//struct MostPopularItem: Decodable {
//    let id: String
//    let rank: String
//    let title: String
//    let year: String
//    let image: String
//}

struct ItemsForFeaturedMoviesModel: Decodable {
    let items: [FeaturedMoviesModel]
}

struct FeaturedMoviesModel: Decodable {
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
    var optionalId: String {
        id
    }
    
    var titleLabelText: String {
        title
    }
}


extension FeaturedMoviesModel: TableViewCellPresentable {
    var cellType: CellType {
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

struct ItemsForComingSoonModel: Decodable {
    let items: [ComingSoonModel]
}

struct ComingSoonModel: Decodable {
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
    var optionalId: String {
        id
    }
    var titleLabelText: String {
        title
    }
}

extension ComingSoonModel: TableViewCellPresentable {
    var cellType: CellType {
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
        "Release Date: \(releaseState)"
    }
    
    var iMDbRatingNumberLabelText: String? {
        imDbRating
    }
}

struct GenreList: Decodable {
    let key: String
    let value: String
}

struct ItemsforInCinemasModel: Decodable {
    let items: [InCinemasModel]
}

struct InCinemasModel: Decodable {
    let id: String
    let title: String
    let image: String
}

extension InCinemasModel: TableViewCellPresentable, SwipeableInformationTilePresentable {
    var nameLabelText: String? {
        title
    }
    
    var yearInfoText: String? {
        nil
    }
    
    var cellType: CellType {
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
    
    var additionalInfoLabelText: String? {
        nil
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
}
