//
//  ApiManagerTests.swift
//  MovieLandTests
//
//  Created by Patka on 09/02/2024.
//

import XCTest
@testable import MovieLand
import Mocker

final class ApiManagerTests: XCTestCase {
    
    enum APIManagerError: Error {
        case genericError
    }
    
    var sut: APIManager!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        sut = APIManager(language: "en", configuration: configuration)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        Mocker.removeAll()
    }
    
    func testFetchPersonInformationSuccess() {
        // given
        let url = "https://tv-api.com//en/API/Name/k_bdv8grxf/someId"
        let expectedModel = PersonModel(id: "123",
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
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!, statusCode: 200, data: [.get: encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for person information")
        
        // when
        sut.fetchPersonInformation(id: "someId") { result in
            let apiModel = try? result.get()
            
            // then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchPersonInformationFailure() {
        // given
        let url = "https://tv-api.com//en/API/Name/k_bdv8grxf/someId"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get: Data()],
                        requestError: APIManagerError.genericError)
        mock.register()
        
        let expectation = expectation(description: "Wait for person information")
        
        // when
        sut.fetchPersonInformation(id: "someId") { result in
            // then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchTitleSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Title/k_bdv8grxf/someID"
        let expectedModel = TitleModel(id: "123",
                                       title: "",
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
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!, statusCode: 200, data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for title model")
        
        //when
        sut.fetchTitle(id: "someID") { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1 )
    }
    
    func testFetchTitleFailure() {
        //given
        let url = "https://tv-api.com//en/API/Title/k_bdv8grxf/someID"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get: Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for title information")
        
        //when
        sut.fetchTitle(id: "someID") { result in
            // then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchSearchResultsSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Searchall/k_bdv8grxf/someQuery"
        let expectedModel = SearchResultsModel(results: [],
                                               searchType: "",
                                               expression: "")
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for search results")
        
        //when
        sut.fetchSearchResults(query: "someQuery") { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchSearchResultsFailure() {
        //given
        let url = "https://tv-api.com//en/API/Searchall/k_bdv8grxf/someQuery"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for search results")
        
        //when
        sut.fetchSearchResults(query: "someQuery") { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchTrailerSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Trailer/k_bdv8grxf/someID"
        let expectedModel = TrailerModel(imDbId: "",
                                         link: "",
                                         linkEmbed: "",
                                         thumbnailUrl: "",
                                         title: "",
                                         videoTitle: "",
                                         videoDescription: "")
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for trailer")
        
        //when
        sut.fetchTrailer(id: "someID") { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testTrailerResultsFailure() {
        //given
        let url = "https://tv-api.com//en/API/Trailer/k_bdv8grxf/someID"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for trailer")
        
        //when
        sut.fetchTrailer(id: "someID") { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchAllDetailsWebSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Externalsites/k_bdv8grxf/someID"
        let allDetailsWebLinkModel = AllDetailsWebLinkModel(id: "", url: "")
        let expectedModel = AllDetailsWebModel(imDbId: "", officialWebsite: "",
                                               imDb: allDetailsWebLinkModel,
                                               theMovieDb: allDetailsWebLinkModel,
                                               rottenTomatoes: allDetailsWebLinkModel,
                                               filmAffinity: allDetailsWebLinkModel)
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for all web details")
        
        //when
        sut.fetchAllDetailsWeb(id: "someID") { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchAllDetailsWebFailure() {
        //given
        let url = "https://tv-api.com//en/API/Externalsites/k_bdv8grxf/someID"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for all web details")
        
        //when
        sut.fetchAllDetailsWeb(id: "someID") { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchFeaturedMoviesResultsSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Top250Movies/k_bdv8grxf/"
        let featuredMoviesModel = FeaturedMoviesModel(id: "123",
                                                      rank: "",
                                                      title: "",
                                                      fullTitle: "",
                                                      year: "",
                                                      image: "",
                                                      crew: "",
                                                      imDbRating: "")
        let expectedModel = ItemsForFeaturedMoviesModel(items: [featuredMoviesModel])
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for featured movies")
        
        //when
        sut.fetchFeaturedMoviesResults { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchFeaturedMoviesResultsFailure() {
        //given
        let url = "https://tv-api.com//en/API/Top250Movies/k_bdv8grxf/"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for featured movies")
        
        //when
        sut.fetchFeaturedMoviesResults { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testfetchInCinemasMoviesInformationSuccess() {
        let url = "https://tv-api.com//en/API/Boxoffice/k_bdv8grxf/"
        let inCinemaModel = InCinemasModel(id: "123",
                                           title: "",
                                           image: "")
        let expectedModel = ItemsforInCinemasModel(items: [inCinemaModel])
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for in cinemas movies information")
        
        //when
        sut.fetchInCinemasMoviesInformation { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testfetchInCinemasMoviesInformationFailure() {
        //given
        let url = "https://tv-api.com//en/API/Boxoffice/k_bdv8grxf/"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for featured movies")
        
        //when
        sut.fetchInCinemasMoviesInformation { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchMostPopularMoviesInformationSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Mostpopularmovies/k_bdv8grxf/"
        let featuredMoviesModel = FeaturedMoviesModel(id: "123",
                                                      rank: "",
                                                      title: "",
                                                      fullTitle: "",
                                                      year: "",
                                                      image: "",
                                                      crew: "",
                                                      imDbRating: "")
        let expectedModel = ItemsForFeaturedMoviesModel(items: [featuredMoviesModel])
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for most popular movies information")
        
        //when
        sut.fetchMostPopularMoviesInformation { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchMostPopularMoviesInformationFailure() {
        //given
        let url = "https://tv-api.com//en/API/Mostpopularmovies/k_bdv8grxf/"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for most popular movies information")
        
        //when
        sut.fetchMostPopularMoviesInformation { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testfetchTop250TVSeriesResultsSuccess() {
        let url = "https://tv-api.com//en/API/Top250Tvs/k_bdv8grxf/"
        let featuredMoviesModel = FeaturedMoviesModel(id: "123",
                                                      rank: "",
                                                      title: "",
                                                      fullTitle: "", year: "",
                                                      image: "",
                                                      crew: "",
                                                      imDbRating: "")
        let expectedModel = ItemsForFeaturedMoviesModel(items: [featuredMoviesModel])
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for top 250 series")
        
        //when
        sut.fetchTop250TVSeriesResults { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testfetchTop250TVSeriesResultsFailure() {
        //given
        let url = "https://tv-api.com//en/API/Top250Tvs/k_bdv8grxf/"
        let mock = Mock(url: URL(string: url)!, statusCode: 200, data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for top 250 series")
        
        //when
        sut.fetchTop250TVSeriesResults { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchMostPopularTVSeriesInformationSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Mostpopulartvs/k_bdv8grxf/"
        let featuredMoviesModel = FeaturedMoviesModel(id: "123",
                                                      rank: "",
                                                      title: "",
                                                      fullTitle: "",
                                                      year: "",
                                                      image: "",
                                                      crew: "",
                                                      imDbRating: "")
        let expectedModel = ItemsForFeaturedMoviesModel(items: [featuredMoviesModel])
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for most popular TV series information")
        
        //when
        sut.fetchMostPopularTVSeriesInformation { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchMostPopularTVSeriesInformationFailure() {
        //given
        let url = "https://tv-api.com//en/API/Mostpopulartvs/k_bdv8grxf/"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()], requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for most popular TV series information")
        
        //when
        sut.fetchMostPopularTVSeriesInformation { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testBoxOfficeAllTimeSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Boxofficealltime/k_bdv8grxf/"
        let boxOfficeAllTimeModel = BoxOfficeAllTimeModel(id: "123",
                                                          rank: "",
                                                          title: "",
                                                          worldwideLifetimeGross: "",
                                                          domesticLifetimeGross: "",
                                                          domestic: "",
                                                          foreignLifetimeGross: "",
                                                          foreign: "",
                                                          year: "")
        let expectedModel = ItemsForBoxOfficeAllTimeModel(items: [boxOfficeAllTimeModel])
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for box office all time")
        
        //when
        sut.fetchBoxOfficeAllTime { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testBoxOfficeAllTimeFailure() {
        //given
        let url = "https://tv-api.com//en/API/Boxofficealltime/k_bdv8grxf/"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for box office all time")
        
        //when
        sut.fetchBoxOfficeAllTime { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchPersonAwardsInformationSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Nameawards/k_bdv8grxf/someID"
        let expectedModel = PersonAwardsModel(imDbId: "123",
                                              name: "",
                                              description: "",
                                              items: [])
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for person awards")
        
        //when
        sut.fetchPersonAwardsInformation(id: "someID") { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchPersonAwardsInformationFailure() {
        //given
        let url = "https://tv-api.com//en/API/Nameawards/k_bdv8grxf/someID"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for person awards")
        
        //when
        sut.fetchPersonAwardsInformation(id: "someID") { result in
            //then
            switch result {
            case .success:
                XCTFail("This url shuld have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchMovieAwardsInformationSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Awards/k_bdv8grxf/someID"
        let expectedModel = MovieAwardsModel(imDbId: "123",
                                             title: "",
                                             type: "",
                                             year: "",
                                             description: "",
                                             items: [])
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for movie awards")
        
        //when
        sut.fetchMovieAwardsInformation(id: "someID") { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchMovieAwardsInformationFailure() {
        //given
        let url = "https://tv-api.com//en/API/Awards/k_bdv8grxf/someID"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for movie awards")
        
        //when
        sut.fetchMovieAwardsInformation(id: "someID") { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchRatingsSuccess() {
        //given
        let url = "https://tv-api.com//en/API/Ratings/k_bdv8grxf/someID"
        let expectedModel = RatingsModel(imDbId: "123",
                                         year: "",
                                         type: "",
                                         imDb: "",
                                         title: "")
        let encodedModel = try! JSONEncoder().encode(expectedModel)
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 200,
                        data: [.get : encodedModel])
        mock.register()
        let expectation = expectation(description: "Wait for ratings")
        
        //when
        sut.fetchRatings(id: "someID") { result in
            let apiModel = try? result.get()
            
            //then
            do {
                let apiModel = try result.get()
                XCTAssertEqual(apiModel, expectedModel)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchRatingsFailure() {
        //givene
        let url = "https://tv-api.com//en/API/Ratings/k_bdv8grxf/someID"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for ratings")
        
        //when
        sut.fetchRatings(id: "someID") { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
//    func testFetchComingSoonSuccess() {
//        //given
//        let url = "https://tv-api.com//en/API/Comingsoon/k_bdv8grxf/"
//        let comingSoonModel = [ComingSoonModel(id: "123",
//                                            title: "",
//                                            fullTitle: "",
//                                            year: "",
//                                            releaseState: "",
//                                            image: "",
//                                            genres: "",
//                                            genreList: [],
//                                            stars: "",
//                                            imDbRating: "")]
//        let expectedModel = ItemsForComingSoonModel(items: [comingSoonModel])
//        let encodedModel = try! JSONEncoder().encode(comingSoonModel)
//        let mock = Mock(url: URL(string: url)!,
//                        statusCode: 200,
//                        data: [.get : encodedModel])
//        mock.register()
//        let expectation = expectation(description: "Wait for coming soon")
//
//        //when
//        sut.fetchComingSoon { result in
//            let apiModel = try? result.get()
//
//            //then
//            do {
//                let apiModel = try result.get()
//                XCTAssertEqual(apiModel, comingSoonModel)
//            } catch {
//                XCTFail(error.localizedDescription)
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1)
//    }
    
    func testFetchComingSoonFailure() {
        //given
        let url = "https://tv-api.com//en/API/Comingsoon/k_bdv8grxf/"
        let mock = Mock(url: URL(string: url)!,
                        statusCode: 400,
                        data: [.get : Data()],
                        requestError: MockAPIManagerError.genericError)
        mock.register()
        let expectation = expectation(description: "Wait for coming soon")
        
            //when
        sut.fetchComingSoon { result in
            //then
            switch result {
            case .success:
                XCTFail("This url request should have failed")
            case .failure(let error):
                XCTAssertTrue(error.localizedDescription.contains("APIManagerError"))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
