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
    
    override func setUp() {
        defaults = UserDefaults(suiteName: defaultsSuitName)
        sut = UserDefaultsPersistenceManager(userDefaults: defaults)
    }

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
        //when
        sut.persist(model: model)
        sut.persist(model: model)

        //then
        XCTAssertEqual(sut.persistedData, [model])
        XCTAssertEqual(sut.persistedData.count, 1)
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
        
        //when
        sut.persist(model: model1)
        sut.persist(model: model2)
        sut.remove(model: model1)
        
        //then
        XCTAssertEqual(sut.persistedData.count, 1)
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
        
        //when
        let isPersisted = sut.isPersisted(model: model)
        
        //then
//        XCTAssertTrue(isPersisted)
        
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
        
        //when
        sut.persist(model: model)
        sut.togglePersisted(model: model)
        
        //then
        XCTAssertEqual(sut.persistedData.count, 0)
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
        
        //when
        sut.togglePersisted(model: model)
        
        //then
        XCTAssertEqual(sut.persistedData.count, 1)
    }
}
