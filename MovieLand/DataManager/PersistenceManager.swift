//
//  PersistenceManager.swift
//  MovieLand
//
//  Created by Patka on 15/04/2023.
//

import Foundation

enum PersistableModel {
    case person(model: PersonModel)
    case seen(model: TitleModel)
    case want(model: TitleModel)
    
    var id: String {
        switch self {
        case .person(let personModel):
            return personModel.id
        case .want(let titleModel):
            return titleModel.id
        case .seen(let titleModel):
            return titleModel.id
        }
    }
    
    var asListPresentable: ListViewControllerCellPresentable {
        switch self {
        case .person(let model):
            return model
        case .want(let model):
            return model
        case .seen(let model):
            return model
        }
    }
}

protocol PersistenceManagerProtocol {
    func persist(model: PersistableModel)
    func remove(model: PersistableModel)
    var persistedData: [PersistableModel] { get }
}

class UserDefaultsPersistenceManager: PersistenceManagerProtocol {
    var persistedData: [PersistableModel]
    private let kPersistedData = "kPersistedData"
    
    init() {
        persistedData = []
    }
    
    func persist(model: PersistableModel) {
        guard !persistedData.contains(where: { persistedModel in
            model.id == persistedModel.id
        }) else {
            return
        }
        persistedData.append(model)
    }
    
    func remove(model: PersistableModel) {
        persistedData.removeAll { arrayModel in
            arrayModel.id == model.id
        }
    }
}
