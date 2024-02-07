//
//  MockPersistenceManager.swift
//  MovieLandTests
//
//  Created by Patka on 03/06/2023.
//

import Foundation
@testable import MovieLand

//enum MockPersistableModel: Codable, Equatable {
//    case seen(model: TitleModel)
//}

final class MockPersistenceManager: PersistenceManagerProtocol {
    func persist(model: MovieLand.PersistableModel) {
        
    }
    
    func remove(model: MovieLand.PersistableModel) {
        
    }
    
    var lastIsPersistedModel: PersistableModel?
    var expectedIsPersisted: Bool!
    func isPersisted(model: MovieLand.PersistableModel) -> Bool {
        lastIsPersistedModel = model
        return expectedIsPersisted
    }
    
    var lastTogglePersistedModel: PersistableModel?
    func togglePersisted(model: MovieLand.PersistableModel) {
        lastTogglePersistedModel = model
    }
    
    var persistedData: [MovieLand.PersistableModel] = []
}
