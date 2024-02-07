//
//  WelcomeScreenViewModelTests.swift
//  MovieLandTests
//
//  Created by Patka on 02/02/2024.
//

import XCTest
@testable import MovieLand

final class WelcomeScreenViewModelTests: XCTestCase {
    
    var sut: WelcomeScreenViewModel!
    var mockApiManager: MockAPIManager!
    var mockDelegate: MockWelcomeScreenViewModelDelegate!
    
    override func setUpWithError() throws {
        mockApiManager = MockAPIManager()
        mockDelegate = MockWelcomeScreenViewModelDelegate()
        sut = WelcomeScreenViewModel(apiManager: mockApiManager)
        sut.delegate = mockDelegate
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockApiManager = nil
        mockDelegate = nil
    }
    
    func testFetchComingSoonSuccess() {
        //given
        let models = [ComingSoonModel(id: "1234",
                                    title: "",
                                    fullTitle: "",
                                    year: "",
                                    releaseState: "",
                                    image: "",
                                    genres: "",
                                    genreList: [],
                                    stars: "",
                                    imDbRating: "")]
        mockApiManager.expectedFetchComingSoonResult = .success(models)
        
        //when
        sut.fetchComingSoon()
        
        //then
        XCTAssertEqual(mockDelegate.lastOnFetchComingSoonModel, models)
    }
    
    func testFetchComingSoonFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchComingSoonResult = .failure(error)
        
        //when
        sut.fetchComingSoon()
        
        //then
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testInCinemaMoviesInformationSuccess() {
        //given
        let inCinemasModels = [InCinemasModel(id: "123",
                                              title: "",
                                              image: "")]
        let models = ItemsforInCinemasModel(items: inCinemasModels)
        mockApiManager.expectedInCinemasMoviesInformationResult = .success(models)
        
        //when
        sut.fetchInCinemaMoviesInformation()
        
        //then
        XCTAssertEqual(mockDelegate.lastOnFetchInCinemaMoviesModel, models)
    }
    
    func testFetchInCinemaMoviesInformationFailure() {
        // given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedInCinemasMoviesInformationResult = .failure(error)
        
        //when
        sut.fetchInCinemaMoviesInformation()
        
        //then
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testFetchFeaturedMoviesResultsSuccess() {
        //given
        let featuredMovieModels = [FeaturedMoviesModel(id: "123",
                                                       rank: "",
                                                       title: "",
                                                       fullTitle: "",
                                                       year: "",
                                                       image: "",
                                                       crew: "",
                                                       imDbRating: "")]
        
        let model = ItemsForFeaturedMoviesModel(items: featuredMovieModels)
        mockApiManager.expectedFetchFeaturedMoviesResults = .success(model)
        
        //when
        sut.fetchFeaturedMoviesResults()
        
        //then
        XCTAssertEqual(mockDelegate.lastOnFetchFeaturedMoviesModel, model)
    }
    
    func testFetchFeaturedMoviesResultsFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchFeaturedMoviesResults = .failure(error)
        
        //when
        sut.fetchFeaturedMoviesResults()
        
        //then
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testFetchMostPopularMoviesInformationSuccess() {
      //given
        let featuredMovieModels = [FeaturedMoviesModel(id: "123",
                                                       rank: "",
                                                       title: "",
                                                       fullTitle: "",
                                                       year: "",
                                                       image: "",
                                                       crew: "",
                                                       imDbRating: "")]
        
        let model = ItemsForFeaturedMoviesModel(items: featuredMovieModels)
        mockApiManager.expectedFetchMostPopularMoviesResult = .success(model)
        
        //when
        sut.fetchMostPopularMoviesInformation()
        
        //then
        XCTAssertEqual(mockDelegate.lastOnFetchMostPopularMoviesModel, model)
    }
    
    func testFetchMostPopularMoviesInformationFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchMostPopularMoviesResult = .failure(error)
        
        //when
        sut.fetchMostPopularMoviesInformation()
        
        //then
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testFetchTop250TVSeriesSuccess() {
        //given
        let featuredMovieModels = [FeaturedMoviesModel(id: "123",
                                                       rank: "",
                                                       title: "",
                                                       fullTitle: "",
                                                       year: "",
                                                       image: "",
                                                       crew: "",
                                                       imDbRating: "")]
        
        let model = ItemsForFeaturedMoviesModel(items: featuredMovieModels)
        mockApiManager.expectedFetchTop250SeriesResult = .success(model)
        
        //when
        sut.fetchTop250TVSeries()
        
        //then
        XCTAssertEqual(mockDelegate.lastOnFetchTop250TVSeriesModel, model)
    }
    
    func testFetchTop250TVSeriesFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchTop250SeriesResult = .failure(error)
        
        //when
        sut.fetchTop250TVSeries()
        
        //then
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testFetchMostPopularTVSeriesSuccess() {
        //given
        let featuredMovieModels = [FeaturedMoviesModel(id: "123",
                                                       rank: "",
                                                       title: "",
                                                       fullTitle: "",
                                                       year: "",
                                                       image: "",
                                                       crew: "",
                                                       imDbRating: "")]
        
        let model = ItemsForFeaturedMoviesModel(items: featuredMovieModels)
        mockApiManager.expectedFetchMostPopularTVSeriesResult = .success(model)
        
        //when
        sut.fetchMostPopularTVSeries()
        
        //then
        XCTAssertEqual(mockDelegate.lastOnFetchMostPopularTVSeriesModel, model)
    }
    
    func testFetchMostPopularTVSeriesFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchMostPopularTVSeriesResult = .failure(error)
        
        //when
        sut.fetchMostPopularTVSeries()
        
        //then
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
    
    func testFetchBoxOfficeAllTimeSuccess() {
        //given
        let boxOfficeAllTimeModel = [BoxOfficeAllTimeModel(id: "",
                                                          rank: "",
                                                          title: "",
                                                          worldwideLifetimeGross: "",
                                                          domesticLifetimeGross: "",
                                                          domestic: "",
                                                          foreignLifetimeGross: "",
                                                          foreign: "",
                                                          year: "")]
        
        let model = ItemsForBoxOfficeAllTimeModel(items: boxOfficeAllTimeModel)
        mockApiManager.expectedFetchBoxOfficeAllTimeResult = .success(model)
        
        //when
        sut.fetchBoxOfficeAllTime()
        
        //then
        XCTAssertEqual(mockDelegate.lastOnFetchBoxOfficeAllTimeModel, model)
    }
    
    func testFetchBoxOfficeAllTimeFailure() {
        //given
        let error = MockAPIManagerError.genericError
        mockApiManager.expectedFetchBoxOfficeAllTimeResult = .failure(error)
        
        //when
        sut.fetchBoxOfficeAllTime()
        
        //then
        XCTAssertEqual(mockDelegate.lastPresentedError, error)
    }
}
