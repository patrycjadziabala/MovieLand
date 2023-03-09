//
//  SearchResultsViewController.swift
//  MovieLand
//
//  Created by Patka on 09/03/2023.
//

import UIKit

class SearchResultsViewController: UIViewController {

    let searchResults: SearchResultsModel
    let tabRouter: TabRouterProtocol
    
    init(searchResults: SearchResultsModel, tabRouter: TabRouterProtocol) {
        self.searchResults = searchResults
        self.tabRouter = tabRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   

}
