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
    
    func onFetchTrailerSuccess(model: MovieLand.TrailerModel) {
        
    }
    
    func onFetchWebDetailsSuccess(model: MovieLand.AllDetailsWebModel) {
        
    }
    
    func onFetchRatingSuccess(ratingModel: MovieLand.RatingsModel) {
        
    }
    
    func onFetchMovieAwardsFinished() {
        
    }
    
    func presentErrorAlert(error: Error) {
        
    }
    
    func onFetchMovieAwardsErrorAlert() {
        
    }
}
