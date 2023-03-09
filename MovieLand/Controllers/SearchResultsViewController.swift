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
    let tableView: UITableView
    
    init(searchResults: SearchResultsModel, tabRouter: TabRouterProtocol) {
        self.searchResults = searchResults
        self.tabRouter = tabRouter
        self.tableView = UITableView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
