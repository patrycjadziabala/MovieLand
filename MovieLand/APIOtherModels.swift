//
//  ActorModel.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import Foundation

struct TrailerModel: Codable, Equatable {
    let imDbId: String
    let link: String?
    let linkEmbed: String?
    let thumbnailUrl: String?
    let title: String
    let videoTitle: String?
    let videoDescription: String?
}

class WelcomeScreenTrailerModel {
    let comingSoonModel: ComingSoonModel
    var trailerModel: TrailerModel?
    
    init(comingSoonModel: ComingSoonModel, trailerModel: TrailerModel? = nil) {
        self.comingSoonModel = comingSoonModel
        self.trailerModel = trailerModel
    }
}

struct AllDetailsWebModel: Codable, Equatable {
    let imDbId: String
    let officialWebsite: String?
    let imDb: AllDetailsWebLinkModel
    let theMovieDb: AllDetailsWebLinkModel
    let rottenTomatoes: AllDetailsWebLinkModel
    let filmAffinity: AllDetailsWebLinkModel
}

struct AllDetailsWebLinkModel: Codable, Equatable {
    let id: String
    let url: String
}

struct GenreModel: Codable, Equatable {
    let key: String
    let value: String
}

struct SearchResultsModel: Codable {
    let results: [Results]
    let searchType: String
    let expression: String
}

struct Results: Codable {
    let id: String
    let image: String
    let title: String
    let resultType: String?
    let description: String
}

extension Results: TableViewCellPresentable {
    var contentType: CellContentType {
        CellContentType(rawValue: resultType?.lowercased() ?? "") ?? .unknown
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

extension Results: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

enum CellContentType: String {
    case title
    case name
    case unknown
}


struct GenreList: Codable {
    let key: String
    let value: String
}

struct PersonAwardsModel: Codable {
    let imDbId: String
    let name: String
    let description: String?
    let items: [PersonAwardsItemModel]
}

struct PersonAwardsItemModel: Codable {
    let eventTitle: String
    let nameAwardEventDetails: [PersonAwardsOutcomeItemModel]
}

struct PersonAwardsOutcomeItemModel: Codable {
    let image: String?
    let outcomeYear: String?
    let title: String
    let `for`: String
    let description: String?
}

struct PersonAwardSummaryModel {
    let year: String?
    let eventTitle: String
    let title: String
    let category: String
    let description: String?
    let personId: String
    let image: String?
    
    init(with model: PersonAwardsOutcomeItemModel, eventTitle: String, personId: String) {
        self.year = model.outcomeYear
        self.eventTitle = eventTitle
        self.title = model.title
        self.category = model.`for`
        self.description = model.description
        self.personId = personId
        self.image = model.image
    }
}

extension PersonAwardSummaryModel: AwardsTableViewCellPresentable {
    var awardsCellImage: String? {
        image
    }
    
    var id: String {
        personId
    }
    var awardsCellEventTitle: String? {
        eventTitle
    }
    var awardsCellAwardName: String? {
        title
    }
    var awardsCellOutcomeTitle: String? {
        description
    }
    var awardsCellOutcomeCategory: String? {
        category
    }
    var awardsCellType: CellContentType {
        .title
    }
}

extension PersonAwardSummaryModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .awardTableViewCell(model: self)
    }
    var contentType: CellContentType {
        .title
    }
}

struct MovieAwardsModel: Codable, Equatable {
    let imDbId: String?
    let title: String?
    let type: String?
    let year: String?
    let description: String?
    let items: [MovieAwardsItemModel]?
}

struct MovieAwardsItemModel: Codable, Equatable {
    let eventTitle: String?
    let eventYear: String?
    let awardEventDetails: [MovieAwardsOutcomeItemModel]?
}

struct MovieAwardsOutcomeItemModel: Codable, Equatable {
    let image: String?
    let title: String?
    let `for`: String?
    let description: String?
}

struct MovieAwardSummaryModel {
    let awardYear: String
    let eventTitle: String
    let title: String
    let category: String
    let description: String?
    let movieId: String
    let image: String?
    
    init(with model: MovieAwardsOutcomeItemModel, eventYear: String, eventTitle: String, movieID: String) {
        self.awardYear = eventYear
        self.eventTitle = eventTitle
        self.title = model.title ?? ""
        self.category = model.for ?? ""
        self.description = model.description
        self.movieId = movieID
        self.image = model.image
    }
}

extension MovieAwardSummaryModel: AwardsTableViewCellPresentable {
    var awardsCellImage: String? {
        image
    }
    
    var id: String {
        movieId
    }
    
    var awardsCellEventTitle: String? {
        eventTitle
    }
    
    var awardsCellAwardName: String? {
        category
    }
    
    var awardsCellOutcomeTitle: String? {
        title
    }
    
    var awardsCellOutcomeCategory: String? {
        description
    }
    
    var awardsCellType: CellContentType {
        .title
    }
}

extension MovieAwardSummaryModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .awardTableViewCell(model: self)
    }
    var contentType: CellContentType {
        .title
    }
}

struct RatingsModel: Codable, Equatable {
    let imDbId: String
    let year: String
    let type: String
    let imDb: String?
    let title: String
}
