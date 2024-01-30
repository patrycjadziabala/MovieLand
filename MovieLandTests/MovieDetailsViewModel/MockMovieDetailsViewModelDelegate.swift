//
//  MockMovieDetailsViewModelDelegate.swift
//  MovieLandTests
//
//  Created by Patka on 03/06/2023.
//

import Foundation
@testable import MovieLand

class MockMovieDetailsViewModelDelegate: MovieDetailsViewModelDelegate {
    var lastOnFetchTitleSuccessModel: TitleModel?
    func onFetchTitleSuccess(model: MovieLand.TitleModel) {
        lastOnFetchTitleSuccessModel = model
    }
    
    var lastOnFetchTrailerSuccessModel: TrailerModel?
    func onFetchTrailerSuccess(model: MovieLand.TrailerModel) {
        lastOnFetchTrailerSuccessModel = model
    }
    
    var lastOnFetchWebDetailsSuccessModel: AllDetailsWebModel?
    func onFetchWebDetailsSuccess(model: MovieLand.AllDetailsWebModel) {
        lastOnFetchWebDetailsSuccessModel = model
    }
    
    var lastOnFetchRatingSuccessModel: RatingsModel?
    func onFetchRatingSuccess(ratingModel: MovieLand.RatingsModel) {
        lastOnFetchRatingSuccessModel = ratingModel
    }
    
    var expectedExploreAwardsButton = false
    func onFetchMovieAwardsFinished() {
        expectedExploreAwardsButton = true
    }
    
    var lastPresentedError: MockAPIManagerError?
    func presentErrorAlert(error: Error) {
        lastPresentedError = (error as! MockAPIManagerError)
    }
    
    var onFetchMovieAwardsErrorAlertCalled = false
    func onFetchMovieAwardsErrorAlert() {
        onFetchMovieAwardsErrorAlertCalled = true
    }
}
