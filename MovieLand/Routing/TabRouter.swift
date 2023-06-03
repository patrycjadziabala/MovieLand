//
//  TabRouter.swift
//  MovieLand
//
//  Created by Patka on 09/03/2023.
//

import Foundation
import UIKit
import SafariServices

protocol TabRouterProtocol {
    func navigateToPersonDetails(id: String)
    func navigateToTitleDetails(id: String)
    func navigateToList(results: [ListViewControllerCellPresentable], title: String)
    func navigateToWebView(urlString: String)
}

class TabRouter: TabRouterProtocol {
    let navigationController: UINavigationController
    let persistenceManager: PersistenceManagerProtocol
    
    init(navigationController: UINavigationController, persistenceManager: PersistenceManagerProtocol) {
        self.navigationController = navigationController
        self.persistenceManager = persistenceManager
    }
    
    func navigateToPersonDetails(id: String) {
        DispatchQueue.main.async {
            let viewModel = PersonDetailsViewModel(tabRouter: self, persistenceManager: self.persistenceManager)
            let controller = PersonDetailsViewController(personID: id, tabRouter: self, viewModel: viewModel)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToTitleDetails(id: String) {
        DispatchQueue.main.async {
            let viewModel = MovieDetailsViewModel(apiManager: APIManager(),
                                                  tabRouter: self,
                                                  persistenceManager: self.persistenceManager)
            let controller = MovieDetailsViewController(titleID: id, tabRouter: self, viewModel: viewModel)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToList(results: [ListViewControllerCellPresentable], title: String) {
        DispatchQueue.main.async {
            let controller = ListViewController(tabRouter: self, dataSource: results, navBarTitle: title)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToWebView(urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            navigationController.present(vc, animated: true)
        }
    }
}
