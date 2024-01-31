//
//  PersonDetailsViewModelTests.swift
//  MovieLandTests
//
//  Created by Patka on 30/01/2024.
//

import XCTest
@testable import MovieLand

final class PersonDetailsViewModelTests: XCTestCase {
    
    var sut: PersonDetailsViewModel!
    var mockApiManager: MockAPIManager!
    var mockTabRouter: MockTabRouter!
    var mockPersistenceManager: MockPersistenceManager!
    var mockDelegate: MockPersonDetailsViewModelDelegate!
    
    override func setUpWithError() throws {
        mockApiManager = MockAPIManager()
        mockTabRouter = MockTabRouter()
        mockPersistenceManager = MockPersistenceManager()
        mockDelegate = MockPersonDetailsViewModelDelegate()
        sut = PersonDetailsViewModel(apiManager: mockApiManager,
                                     tabRouter: mockTabRouter,
                                     persistenceManager: mockPersistenceManager)
        
        sut.delegate = mockDelegate
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockApiManager = nil
        mockTabRouter = nil
        mockPersistenceManager = nil
    }
    
    func testNavigateToList() {
        // given
        let result = [CastMovieModel(id: "1234",
                                      role: "",
                                      title: "",
                                      year: "",
                                      description: "")]
               
        // when
        sut.navigateToList(result: result)
        
        // then
        XCTAssertEqual(mockTabRouter.lastNavigateToListResult?.count, 1)
        XCTAssertEqual(mockTabRouter.lastNavigateToListResult?.first?.id, "1234")
        XCTAssertEqual(mockTabRouter.lastNavigateToListTitle, "")
    }
 
    func testNavigateToAwards() {
        //given
        let results = [CastMovieModel(id: "12345",
                                      role: "",
                                      title: "",
                                      year: "",
                                      description: "")]
        mockTabRouter.navigateToList(results: results, title: "Abc")
        
        //when
        sut.navigateToAwards()
        
        //then
        XCTAssertEqual(mockTabRouter.lastNavigateToListResult?.count, 1)
        XCTAssertEqual(mockTabRouter.lastNavigateToListResult?.first?.id, "12345")
        XCTAssertEqual(mockTabRouter.lastNavigateToListTitle, "Abc")
    }
    
    func testFetchPersonInformationSuccess() {
        //given
        let model = PersonModel(id: "123",
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
                                errorMessage: "")
        mockApiManager.expectedFetchPersonInformationResult = .success(model)
        
        //when
        sut.fetchPersonInformation(id: "123id")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchPersonId, "123id")
        XCTAssertEqual(sut.personModel, model)
        XCTAssertEqual(mockDelegate.lastOnFetchPersonInformationModel, model)
    }
    
    func testFetchPersonInformationFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchPersonInformationResult = .failure(error)
        
        //when
        sut.fetchPersonInformation(id: "123id")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchPersonId, "123id")
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testPersonAwardsSuccess() {
        //given
        let model = PersonAwardsModel(imDbId: "123",
                                      name: "",
                                      description: "",
                                      items: [])
//        let resultsModel = PersonAwardsOutcomeItemModel(image: "",
//                                                        outcomeYear: "",
//                                                        title: "",
//                                                        for: "",
//                                                        description: "")
//        let resultModel = [PersonAwardSummaryModel(with: resultsModel,
//                                                  eventTitle: "",
//                                                  personId: "")]
        mockApiManager.expectedFetchPersonAwardsInformationResult = .success(model)
        
        //when
        sut.fetchPersonAwards(id: "123id")

        //then
        XCTAssertEqual(mockApiManager.lastFetchPersonAwardsInformationId, "123id")
//        XCTAssertEqual(sut.awardsArray, resultModel)
        XCTAssertEqual(mockDelegate.onFetchAwardsCompletedCalled, true)
    }
    
    func testFetchPersonAwardsFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchPersonAwardsInformationResult = .failure(error)
        
        //when
        sut.fetchPersonAwards(id: "123id")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchPersonAwardsInformationId, "123id")
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
        XCTAssertEqual(mockDelegate.onFetchAwardsCompletedCalled, false)
    }
}
