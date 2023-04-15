//
//  ActorModel.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import Foundation

struct PersonModel: Decodable, Equatable {
    let id: String
    let name: String
    let role: String?
    let image: String
    let summary: String
    let birthDate: String?
    let deathDate: String?
    let height: String
    let awards: String?
    let knownFor: [KnownForModel]
    let castMovies: [CastMovieModel]
    let errorMessage: String
}

extension PersonModel: TableViewCellPresentable {
    var iMDbRankLabelText: String? {
        nil
    }
    
    var imageUrlString: String? {
        image
    }
    
    var nameLabelText: String? {
        name
    }
    
    var additionalInfoLabelText: String? {
        awards
    }
    
    var yearInfoText: String? {
        nil
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
}

extension PersonModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
    
    var contentType: CellContentType {
        .name
    }
}

struct KnownForModel: Decodable, Equatable {
    let id: String
    let title: String
    let year: String?
    let role: String
    let image: String
}

struct CastMovieModel: Decodable, Equatable {
    let id: String
    let role: String
    let title: String
    let year: String?
    let description: String
}

extension CastMovieModel: SwipeableInformationTilePresentable {
    var contentType: CellContentType {
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
    
    var yearOrAdditionalInfoLabelText: String? {
        year
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
    
    var optionalId: String {
        id
    }
}

extension CastMovieModel: TableViewCellPresentable {
    var additionalInfoLabelText: String? {
        nil
    }
    
    var nameLabelText: String? {
        title
    }
    
    var yearInfoText: String? {
        year
    }
}

extension CastMovieModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

struct TitleModel: Decodable, Equatable {
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

struct TrailerModel: Decodable {
    let imDbId: String
    let link: String
    let linkEmbed: String
    let thumbnailUrl: String
}

struct AllDetailsWebModel: Decodable {
    let imDbId: String
    let officialWebsite: String?
    let imDb: AllDetailsWebLinkModel
    let theMovieDb: AllDetailsWebLinkModel
    let rottenTomatoes: AllDetailsWebLinkModel
    let filmAffinity: AllDetailsWebLinkModel
}

struct AllDetailsWebLinkModel: Decodable {
    let id: String
    let url: String
}

struct BasicPersonModel: Decodable, Equatable {
    let id: String
    let name: String
}

struct ActorForTitleModel: Decodable, Equatable {
    let id: String
    let image: String
    let name: String
    let asCharacter: String
}

extension ActorForTitleModel: SwipeableInformationTilePresentable {
    
    var contentType: CellContentType {
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
        image
    }
    
    var yearOrAdditionalInfoLabelText: String? {
        asCharacter
    }
    
    var iMDbRatingNumberLabelText: String? {
        nil
    }
}

extension ActorForTitleModel: TableViewCellPresentable {
    var additionalInfoLabelText: String? {
        asCharacter
    }
    
    var nameLabelText: String? {
        name
    }
    
    var yearInfoText: String? {
        nil
    }
}

extension ActorForTitleModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

struct GenreModel: Decodable, Equatable {
    let key: String
    let value: String
}

struct Similars: Decodable, Equatable {
    let id: String
    let title: String
    let image: String
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

struct ItemsForBoxOfficeAllTimeModel: Decodable {
    let items: [BoxOfficeAllTimeModel]
}

struct BoxOfficeAllTimeModel: Decodable {
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

struct PersonAwardsModel: Decodable {
    let imDbId: String
    let name: String
    let description: String?
    let items: [PersonAwardsItemModel]
}

struct PersonAwardsItemModel: Decodable {
    let eventTitle: String
    let outcomeItems: [PersonAwardsOutcomeItemModel]
}

struct PersonAwardsOutcomeItemModel: Decodable {
    let outcomeYear: String?
    let outcomeTitle: String
    let outcomeCategory: String
    let outcomeDetails: [PersonAwardsOutcomeDetailsModel]
}

struct PersonAwardsOutcomeDetailsModel: Decodable {
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

struct MovieAwardsModel: Decodable {
    let imDbId: String
    let title: String
    let type: String
    let year: String
    let description: String?
    let items: [MovieAwardsItemModel]
}

struct MovieAwardsItemModel: Decodable {
    let eventTitle: String
    let eventYear: String
    let outcomeItems: [MovieAwardsOutcomeItemModel]
}

struct MovieAwardsOutcomeItemModel: Decodable {
    let outcomeTitle: String
    let outcomeCategory: String
    let outcomeDetails: [MovieAwardsOutcomeDetailsModel]
}

struct MovieAwardsOutcomeDetailsModel: Decodable {
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

struct RatingsModel: Decodable {
    let imDbId: String
    let year: String
    let type: String
    let imDb: String?
    let title: String
}
