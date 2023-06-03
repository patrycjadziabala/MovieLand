//
//  MockTabRouter.swift
//  MovieLandTests
//
//  Created by Patka on 03/06/2023.
//

import Foundation
@testable import MovieLand

final class MockTabRouter: TabRouterProtocol {
    func navigateToPersonDetails(id: String) {
        
    }
    
    func navigateToTitleDetails(id: String) {
        
    }
    
    var lastNavigateToListResult: [MovieLand.ListViewControllerCellPresentable]?
    var lastNavigateToListTitle: String?
    func navigateToList(results: [MovieLand.ListViewControllerCellPresentable], title: String) {
        lastNavigateToListResult = results
        lastNavigateToListTitle = title
    }
    
    var lastNavigateToWebViewUrlString: String?
    func navigateToWebView(urlString: String) {
        lastNavigateToWebViewUrlString = urlString
    }
}
