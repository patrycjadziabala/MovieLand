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
    func navigateToTop250Movies(results: ItemsForFeaturedMoviesModel)
}

class TabRouter: TabRouterProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToPersonDetails(id: String) {
        DispatchQueue.main.async {
            let controller = PersonDetailsViewController(personID: id, tabRouter: self)

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
            let controller = ListViewController(tabRouter: self, dataSource: results.results)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToTop250Movies(results: ItemsForFeaturedMoviesModel) {
        DispatchQueue.main.async {
            let controller = ListViewController(tabRouter: self, dataSource: results.items)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
}
