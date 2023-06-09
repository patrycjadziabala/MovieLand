//
//  MovieDetailsViewModelTests.swift
//  MovieLandTests
//
//  Created by Patka on 03/06/2023.
//

import XCTest
@testable import MovieLand

final class MovieDetailsViewModelTests: XCTestCase {

    var sut: MovieDetailsViewModel!
    var mockApiManager: MockAPIManager!
    var mockTabRouter: MockTabRouter!
    var mockPersistenceManager: MockPersistenceManager!
    var mockDelegate: MockMovieDetailsViewModelDelegate!
    
    override func setUpWithError() throws {
        mockApiManager = MockAPIManager()
        mockTabRouter = MockTabRouter()
        mockPersistenceManager = MockPersistenceManager()
        mockDelegate = MockMovieDetailsViewModelDelegate()
        sut = MovieDetailsViewModel(apiManager: mockApiManager,
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
    
    func testNavigateToTrailer() {
        // given
        let trailerString = "some string"
        
        // when
        sut.navigateToTrailer(urlString: trailerString)
        
        // then
        XCTAssertEqual(mockTabRouter.lastNavigateToWebViewUrlString, "some string")
    }
    
    func testNavigateToFullDetailsWeb() {
        // given
        let urlString = "some web string"

        // when
        sut.navigateToFullDetailsWeb(urlString: urlString)
        
        // then
        XCTAssertEqual(mockTabRouter.lastNavigateToWebViewUrlString, "some web string")
    }
    
    func testNavigateToList() {
        // given
        let results = [FeaturedMoviesModel(id: "mock ID",
                                           rank: "mock rank",
                                           title: "mock title",
                                           fullTitle: "mock full title",
                                           year: "mock year",
                                           image: "mock image",
                                           crew: "mock crew",
                                           imDbRating: "mock ImDb rating")]
               
        // when
        sut.navigateToList(result: results)
        
        // then
        XCTAssertEqual(mockTabRouter.lastNavigateToListResult?.count, 1)
        XCTAssertEqual(mockTabRouter.lastNavigateToListResult?.first?.id, "mock ID")
        XCTAssertEqual(mockTabRouter.lastNavigateToListTitle, "")
    }
    
    func testFetchTitleSuccess() {
        // given
        let model = TitleModel(id: "1234",
                               title: "title",
                               type: "",
                               year: "",
                               image: "",
                               releaseDate: "",
                               plot: "",
                               awards: "",
                               directors: "",
                               stars: "",
                               starList: [],
                               actorList: [],
                               genreList: [],
                               similars: [],
                               errorMessage: "")
        mockApiManager.expectedFetchTitleResult = .success(model)
        
        // when
        sut.fetchTitle(id: "1234id")
        
        // then
        XCTAssertEqual(sut.titleModel, model)
        XCTAssertEqual(mockDelegate.lastOnFetchTitleSuccessModel, model)
    }
    
    func testFetchTitleFailure() {
        
    }
}
