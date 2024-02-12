//
//  PersistenceManagerTests.swift
//  MovieLandTests
//
//  Created by Patka on 06/02/2024.
//
import XCTest
@testable import MovieLand

final class PersistenceManagerTests: XCTestCase {
    
    let defaultsSuitName = "testDefaults"
    var defaults: UserDefaults!
    var sut: UserDefaultsPersistenceManager!
    
    override func tearDown() {
        defaults = nil
        UserDefaults.standard.removePersistentDomain(forName: defaultsSuitName)
        sut = nil
    }
    
    func testPersist() {
        //given
        let model = PersistableModel.person(model: PersonModel(id: "123",
                                                               name: "",
                                                               role: "",
                                                               image: "",
                                                               summary: "",
                                                               birthDate: "",
                                                               deathDate: "",
                                                               height: "",
                                                               awards: "",
                                                               knownFor: [],
                                                               castMovies: [],
                                                               errorMessage: ""))
        defaults = UserDefaults(suiteName: defaultsSuitName)
        sut = UserDefaultsPersistenceManager(userDefaults: defaults)
        
        //when
        sut.persist(model: model)
        sut.persist(model: model)
        
        //then
        XCTAssertEqual(sut.persistedData, [model])
        XCTAssertEqual(sut.persistedData.count, 1)
        let dataFromDefaults = readFromDefaults()
        XCTAssertEqual(dataFromDefaults, [model])
        XCTAssertEqual(dataFromDefaults.count, 1)
    }
    func testRemove() {
        //given
        let model1 = PersistableModel.person(model: PersonModel(id: "123",
                                                                name: "",
                                                                role: "",
                                                                image: "",
                                                                summary: "",
                                                                birthDate: "",
                                                                deathDate: "",
                                                                height: "",
                                                                awards: "",
                                                                knownFor: [],
                                                                castMovies: [],
                                                                errorMessage: ""))
        let model2 = PersistableModel.person(model: PersonModel(id: "321",
                                                                name: "",
                                                                role: "",
                                                                image: "",
                                                                summary: "",
                                                                birthDate: "",
                                                                deathDate: "",
                                                                height: "",
                                                                awards: "",
                                                                knownFor: [],
                                                                castMovies: [],
                                                                errorMessage: ""))
        defaults = UserDefaults(suiteName: defaultsSuitName)
        addToDefaults(models: [model1, model2])
        sut = UserDefaultsPersistenceManager(userDefaults: defaults)
        
        //when
        sut.remove(model: model1)
        
        //then
        XCTAssertEqual(sut.persistedData.count, 1)
        XCTAssertEqual(sut.persistedData.first?.id, "321")
        let dataFromDefaults = readFromDefaults()
        XCTAssertEqual(dataFromDefaults.count, 1)
        XCTAssertEqual(dataFromDefaults.first?.id, "321")
    }
    
    func testIsPersisted() {
        //given
        let model = PersistableModel.person(model: PersonModel(id: "123",
                                                               name: "",
                                                               role: "",
                                                               image: "",
                                                               summary: "",
                                                               birthDate: "",
                                                               deathDate: "",
                                                               height: "",
                                                               awards: "",
                                                               knownFor: [],
                                                               castMovies: [],
                                                               errorMessage: ""))
        defaults = UserDefaults(suiteName: defaultsSuitName)
        addToDefaults(models: [model])
        sut = UserDefaultsPersistenceManager(userDefaults: defaults)
        
        //when
        let isPersisted = sut.isPersisted(model: model)
        
        //then
        XCTAssertTrue(isPersisted)
    }
    
    func testTogglePersistedCaseIsPersisted() {
        //given
        let model = PersistableModel.person(model: PersonModel(id: "123",
                                                               name: "",
                                                               role: "",
                                                               image: "",
                                                               summary: "",
                                                               birthDate: "",
                                                               deathDate: "",
                                                               height: "",
                                                               awards: "",
                                                               knownFor: [],
                                                               castMovies: [],
                                                               errorMessage: ""))
        defaults = UserDefaults(suiteName: defaultsSuitName)
        addToDefaults(models: [model])
        sut = UserDefaultsPersistenceManager(userDefaults: defaults)
        
        //when
        sut.togglePersisted(model: model)
        
        //then
        XCTAssertEqual(sut.persistedData.count, 0)
        let dataFromDefaults = readFromDefaults()
        XCTAssertEqual(dataFromDefaults.count, 0)
    }
    
    func testTogglePersistedCaseIsNotPersisted() {
        //given
        let model = PersistableModel.person(model: PersonModel(id: "123",
                                                               name: "",
                                                               role: "",
                                                               image: "",
                                                               summary: "",
                                                               birthDate: "",
                                                               deathDate: "",
                                                               height: "",
                                                               awards: "",
                                                               knownFor: [],
                                                               castMovies: [],
                                                               errorMessage: ""))
        defaults = UserDefaults(suiteName: defaultsSuitName)
        sut = UserDefaultsPersistenceManager(userDefaults: defaults)
        
        //when
        sut.togglePersisted(model: model)
        
        //then
        XCTAssertEqual(sut.persistedData.count, 1)
        let dataFromDefaults = readFromDefaults()
        XCTAssertEqual(dataFromDefaults.count, 1)
    }
    
    func addToDefaults(models: [PersistableModel]) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(models)
        defaults.set(data, forKey: "kPersistedData")
    }
    
    func readFromDefaults() -> [PersistableModel] {
        if let dataFromDefaults = defaults.data(forKey: "kPersistedData") {
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode([PersistableModel].self, from: dataFromDefaults)
            return decodedData ?? []
        } else {
            return []
        }
    }
}
