//
//  APIPersonModels.swift
//  MovieLand
//
//  Created by Patka on 16/04/2023.
//

import Foundation

struct TMDBPersonModel {
    let id: String
    let personName: String
    
    func asImdbModel() -> PersonModel {
        PersonModel(id: id,
                    name: personName,
                    role: "",
                    image: "",
                    summary: "",
                    birthDate: "",
                    deathDate: "",
                    height: "",
                    awards: "",
                    knownFor: [],
                    castMovies: [],
                    errorMessage: "")
    }
}

struct PersonModel: Codable, Equatable {
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

struct KnownForModel: Codable, Equatable {
    let id: String
    let title: String
    let year: String?
    let role: String
    let image: String
}

struct CastMovieModel: Codable, Equatable {
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
        year
    }
}

extension CastMovieModel: ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType {
        .regularTableViewCell(model: self)
    }
}

struct BasicPersonModel: Codable, Equatable {
    let id: String
    let name: String
}

struct ActorForTitleModel: Codable, Equatable {
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
    var optionalID: String {
        id
    }
    
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
