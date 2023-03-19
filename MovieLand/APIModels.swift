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

struct Similars: Decodable, SwipeableInformationTilePresentable {
    let id: String
    let title: String
    let image: String
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
    var cellType: TableViewCellType {
        TableViewCellType(rawValue: resultType?.lowercased() ?? "") ?? .unknown
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

enum TableViewCellType: String {
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

extension FeaturedMoviesModel: TableViewCellPresentable {
    var cellType: TableViewCellType {
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
    let fullTitle: String
    let year: String
    let releaseState: String
    let image: String
    let genres: String
    let genreList: [GenreList]
    let stars: String
    let imDbRating: String?
}

extension ComingSoonModel: TableViewCellPresentable {
    var cellType: TableViewCellType {
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
