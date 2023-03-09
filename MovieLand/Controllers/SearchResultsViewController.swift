//
//  SearchResultsViewController.swift
//  MovieLand
//
//  Created by Patka on 09/03/2023.
//

import UIKit

class SearchResultsViewController: UIViewController {

    let tabRouter: TabRouterProtocol
    let tableView: UITableView
    var dataSource: [Results]
    
    init(searchResults: SearchResultsModel, tabRouter: TabRouterProtocol) {
        self.dataSource = searchResults.results
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
        let actorCellName = String(describing: ActorTableViewCell.self)
        tableView.register(UINib(nibName: actorCellName, bundle: nil), forCellReuseIdentifier: actorCellName)
        let titleCellName = String(describing: TitleTableViewCell.self)
        tableView.register(UINib(nibName: titleCellName, bundle: nil), forCellReuseIdentifier: titleCellName)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension SearchResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        guard let resultsType = ResultType(rawValue: model.resultType?.lowercased() ?? "") else {
            return UITableViewCell()
        }
        switch resultsType {
        case .title:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleTableViewCell.self)) as? TitleTableViewCell {
                cell.configure(with: model)
                return cell
            }
        case .name:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActorTableViewCell.self)) as? ActorTableViewCell {
                cell.configure(with: model)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension SearchResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        guard let resultType = ResultType(rawValue: model.resultType?.lowercased() ?? "") else {
            print("No result type found \(model.resultType)")
            return
        }
        switch resultType {
        case .title:
            tabRouter.navigateToTitleDetails(id: model.id)
        case .name:
            tabRouter.navigateToPersonDetails(id: model.id)
        }
    }
}
