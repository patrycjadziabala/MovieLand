//
//  PersistenceManager.swift
//  MovieLand
//
//  Created by Patka on 15/04/2023.
//

import Foundation

enum PersistableModel: Codable, Equatable {
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
        if let dataFromDefaults = UserDefaults.standard.data(forKey: kPersistedData) {
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode([PersistableModel].self, from: dataFromDefaults)
            persistedData = decodedData ?? []
        } else {
            persistedData = []
        }
    }
    
    func persist(model: PersistableModel) {
        guard !isPersisted(model: model) else {
            return
        }
        persistedData.append(model)
        persistToUserDefaults()
    }
    
    func remove(model: PersistableModel) {
        persistedData.removeAll { arrayModel in
            arrayModel == model
        }
        persistToUserDefaults()
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
    
    func persistToUserDefaults() {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(persistedData)
        UserDefaults.standard.set(data, forKey: kPersistedData)
    }
}
