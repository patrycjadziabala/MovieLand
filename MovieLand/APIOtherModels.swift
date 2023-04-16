//
//  ActorModel.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import Foundation

struct TrailerModel: Codable {
    let imDbId: String
    let link: String
    let linkEmbed: String
    let thumbnailUrl: String
}

struct AllDetailsWebModel: Codable {
    let imDbId: String
    let officialWebsite: String?
    let imDb: AllDetailsWebLinkModel
    let theMovieDb: AllDetailsWebLinkModel
    let rottenTomatoes: AllDetailsWebLinkModel
    let filmAffinity: AllDetailsWebLinkModel
}

struct AllDetailsWebLinkModel: Codable {
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
    let outcomeItems: [PersonAwardsOutcomeItemModel]
}

struct PersonAwardsOutcomeItemModel: Codable {
    let outcomeYear: String?
    let outcomeTitle: String
    let outcomeCategory: String
    let outcomeDetails: [PersonAwardsOutcomeDetailsModel]
}

struct PersonAwardsOutcomeDetailsModel: Codable {
    let plainText: String
    let html: String
}

struct PersonAwardSummaryModel {
    let year: String?
    let eventTitle: String
    let title: String
    let category: String
    let description: String?
    let id: String
    
    init(with model: PersonAwardsOutcomeItemModel, eventTitle: String) {
        self.year = model.outcomeYear
        self.eventTitle = eventTitle
        self.title = model.outcomeTitle
        self.category = model.outcomeCategory
        self.description = model.outcomeDetails.first?.plainText
        // TODO: - Get id using regex from "html"
        self.id = ""
    }
}

extension PersonAwardSummaryModel: AwardsTableViewCellPresentable {
    var awardsCellEventTitle: String? {
        eventTitle
    }
    
    var awardsCellAwardName: String? {
        category
    }
    
    var awardsCellOutcomeYear: String? {
        year
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

extension PersonAwardSummaryModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .awardTableViewCell(model: self)
    }
    var contentType: CellContentType {
        .title
    }
}

struct MovieAwardsModel: Codable {
    let imDbId: String
    let title: String
    let type: String
    let year: String
    let description: String?
    let items: [MovieAwardsItemModel]
}

struct MovieAwardsItemModel: Codable {
    let eventTitle: String
    let eventYear: String
    let outcomeItems: [MovieAwardsOutcomeItemModel]
}

struct MovieAwardsOutcomeItemModel: Codable {
    let outcomeTitle: String
    let outcomeCategory: String
    let outcomeDetails: [MovieAwardsOutcomeDetailsModel]
}

struct MovieAwardsOutcomeDetailsModel: Codable {
    let plainText: String
    let html: String
}

struct MovieAwardSummaryModel {
    let awardYear: String
    let eventTitle: String
    let title: String
    let category: String
    let description: String?
    let id: String
    
    init(with model: MovieAwardsOutcomeItemModel, eventYear: String, eventTitle: String) {
        self.awardYear = eventYear
        self.eventTitle = eventTitle
        self.title = model.outcomeTitle
        self.category = model.outcomeCategory
        self.description = model.outcomeDetails.first?.plainText
        self.id = ""
    }
}

extension MovieAwardSummaryModel: AwardsTableViewCellPresentable {
    var awardsCellEventTitle: String? {
        eventTitle
    }
    
    var awardsCellAwardName: String? {
        category
    }
    
    var awardsCellOutcomeYear: String? {
        awardYear
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

struct RatingsModel: Codable {
    let imDbId: String
    let year: String
    let type: String
    let imDb: String?
    let title: String
}
