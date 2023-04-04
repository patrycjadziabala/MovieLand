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
    func navigateToList(results: [ListViewControllerCellPresentable])
    func navigateToWebView(urlString: String)
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
            let viewModel = MovieDetailsViewModel(tabRouter: self)
            let controller = MovieDetailsViewController(titleID: id, tabRouter: self, viewModel: viewModel)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func navigateToList(results: [ListViewControllerCellPresentable]) {
        DispatchQueue.main.async {
            let controller = ListViewController(tabRouter: self, dataSource: results)
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
