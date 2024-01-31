//
//  MockPersonDetailsViewModelDelegate.swift
//  MovieLandTests
//
//  Created by Patka on 30/01/2024.
//

import Foundation
@testable import MovieLand

class MockPersonDetailsViewModelDelegate: PersonDetailsViewModelDelegate {
    var lastOnFetchPersonInformationModel: PersonModel?
    func onFetchPersonInformationSuccess(model: MovieLand.PersonModel) {
        lastOnFetchPersonInformationModel = model
    }
    
    var lastPresentedError: MockAPIManagerError?
    func presentAlertOffline(with error: Error) {
        lastPresentedError = (error as! MockAPIManagerError)
    }
    
    var onFetchAwardsCompletedCalled: Bool?
    func onFetchAwardsCompleted(success: Bool) {
        onFetchAwardsCompletedCalled = success
    }
}
