//
//  APITitleModels.swift
//  MovieLand
//
//  Created by Patka on 16/04/2023.
//

import Foundation

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
