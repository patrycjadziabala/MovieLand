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
    
    func isPersisted(model: MovieLand.PersistableModel) -> Bool {
        false
    }
    
    func togglePersisted(model: MovieLand.PersistableModel) {
    }
    
    var persistedData: [MovieLand.PersistableModel] = []
}
