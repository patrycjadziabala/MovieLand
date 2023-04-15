//
//  PersistenceManager.swift
//  MovieLand
//
//  Created by Patka on 15/04/2023.
//

import Foundation

enum PersistableModel: Equatable {
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
    func isPersisted(model: PersistableModel) -> Bool
    func togglePersisted(model: PersistableModel)
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
            model == persistedModel
        }) else {
            return
        }
        persistedData.append(model)
    }
    
    func remove(model: PersistableModel) {
        persistedData.removeAll { arrayModel in
            arrayModel == model
        }
    }
    
    func isPersisted(model: PersistableModel) -> Bool {
        persistedData.contains { persistedModel in
            model == persistedModel
        }
    }
    
    func togglePersisted(model: PersistableModel) {
        if isPersisted(model: model) {
            remove(model: model)
        } else {
            persist(model: model)
        }
    }
}
