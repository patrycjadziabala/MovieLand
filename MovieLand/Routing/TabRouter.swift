//
//  TabRouter.swift
//  MovieLand
//
//  Created by Patka on 09/03/2023.
//

import Foundation
import UIKit

protocol TabRouterProtocol {
    func navigateToPersonDetails(id: String)
    func navigateToTitleDetails(id: String)
    func navigateToSearchResults(results: SearchResultsModel)
}

class TabRouter: TabRouterProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToPersonDetails(id: String) {
        let controller = PersonDetailsViewController(personID: id, tabRouter: self)
        DispatchQueue.main.async {
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToTitleDetails(id: String) {
        let controller = MovieDetailsViewController(titleID: id, tabRouter: self)
        DispatchQueue.main.async {
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToSearchResults(results: SearchResultsModel) {
        let controller = SearchResultsViewController(searchResults: results, tabRouter: self)
        DispatchQueue.main.async {
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
}
