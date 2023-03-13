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
        DispatchQueue.main.async {
            let controller = MovieDetailsViewController(titleID: id, tabRouter: self)
//            PersonDetailsViewController(personID: id, tabRouter: self)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToTitleDetails(id: String) {
        DispatchQueue.main.async {
            let controller = MovieDetailsViewController(titleID: id, tabRouter: self)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToSearchResults(results: SearchResultsModel) {
        DispatchQueue.main.async {
            let controller = SearchResultsViewController(searchResults: results, tabRouter: self)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
}
