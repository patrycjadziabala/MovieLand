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
        
    }

}
