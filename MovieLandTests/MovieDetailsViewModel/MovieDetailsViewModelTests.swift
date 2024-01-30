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
        XCTAssertEqual(mockApiManager.lastFetchTitleId, "1234id")
        XCTAssertEqual(sut.titleModel, model)
        XCTAssertEqual(mockDelegate.lastOnFetchTitleSuccessModel, model)
    }
    
    func testFetchTitleFailed() {
        // given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchTitleResult = .failure(error)
        
        // when
        sut.fetchTitle(id: "12345id")
        
        // then
        XCTAssertEqual(mockApiManager.lastFetchTitleId, "12345id")
        XCTAssertEqual(mockDelegate.lastPresentedError, MockAPIManagerError.genericError)
    }
    
    func testFetchTrailerSuccess() {
        //given
        let model = TrailerModel(imDbId: "1234",
                                 link: "",
                                 linkEmbed: "",
                                 thumbnailUrl: "",
                                 title: "",
                                 videoTitle: "",
                                 videoDescription: "")
        mockApiManager.expectedFetchTrailerResult = .success(model)
        
        //when
        sut.fetchTrailer(id: "12345")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchTrailerId, "12345")
        XCTAssertEqual(mockDelegate.lastOnFetchTrailerSuccessModel, model)
    }
    
    func testFetchTrailerFailure() {
        // given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchTrailerResult = .failure(error)
        
        // when
        sut.fetchTrailer(id: "12345a")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchTrailerId, "12345a")
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testFetchFullDetailsWebSuccess() {
        //given
        let linkModel = AllDetailsWebLinkModel(id: "12345",
                                               url: "")
        let model = AllDetailsWebModel(imDbId: "1234",
                                       officialWebsite: "",
                                       imDb: linkModel,
                                       theMovieDb: linkModel,
                                       rottenTomatoes: linkModel,
                                       filmAffinity: linkModel)
        mockApiManager.expectedFetchAllDetailsWebResult = .success(model)
        
        //when
        sut.fetchFullDetailsWeb(id: "1234")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchDetailId, "1234")
        XCTAssertEqual(mockDelegate.lastOnFetchWebDetailsSuccessModel, model)
    }
    
    func testFetchFullDetailsWebFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchAllDetailsWebResult = .failure(error)
        
        //when
        sut.fetchFullDetailsWeb(id: "1234a")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchDetailId, "1234a")
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testFetchMovieAwardsSuccess() {
        //given
        let model = MovieAwardsModel(imDbId: "1234",
                                     title: "",
                                     type: "",
                                     year: "",
                                     description: "",
                                     items: [])
        mockApiManager.expectedFetchMovieAwardsInformationResult = .success(model)
        
        let resultModel = MovieAwardsOutcomeItemModel(image: "",
                                                      title: "",
                                                      for: "",
                                                      description: "")
        let results = [MovieAwardSummaryModel(with: resultModel,
                                              eventYear: "",
                                              eventTitle: "",
                                              movieID: "34")]
        
        //when
        sut.fetchMovieAwards(id: "12345")
        mockTabRouter.navigateToList(results: results, title: "")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchMovieAwardsInformationId, "12345")
        XCTAssertEqual(mockTabRouter.lastNavigateToListTitle, "")
        XCTAssertEqual(mockTabRouter.lastNavigateToListResult?.count, 1)
        XCTAssertEqual(mockTabRouter.lastNavigateToListResult?.first?.id, "34")
        XCTAssertTrue(mockDelegate.expectedExploreAwardsButton)
    }
   
    func testFetchMovieAwardsFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchMovieAwardsInformationResult = .failure(error)
        
        //when
        sut.fetchMovieAwards(id: "1234a")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchMovieAwardsInformationId, "1234a")
        XCTAssertTrue(mockDelegate.onFetchMovieAwardsErrorAlertCalled)
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
        XCTAssertTrue(mockDelegate.expectedExploreAwardsButton)
    }
    
    func testFetchRatingSuccess() {
        //given
        let model = RatingsModel(imDbId: "123456",
                                 year: "",
                                 type: "",
                                 imDb: "",
                                 title: "")
        mockApiManager.expectedFetchRatingResult = .success(model)
        
        //when
        sut.fetchRating(id: "123")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchRatingId, "123")
        XCTAssertEqual(mockDelegate.lastOnFetchRatingSuccessModel, model)
    }
    
    func testFetchRatingFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchRatingResult = .failure(error)
        
        //when
        sut.fetchRating(id: "123a")
        
        //then
        XCTAssertEqual(mockApiManager.lastFetchRatingId, "123a")
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
}
