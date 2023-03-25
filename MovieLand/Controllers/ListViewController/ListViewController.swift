//
//  ListViewController.swift
//  MovieLand
//
//  Created by Patka on 19/03/2023.
//

import UIKit

class ListViewController: UIViewController {

    let tabRouter: TabRouterProtocol
    let tableView: UITableView
    var dataSource: [TableViewCellPresentable]
    
    init(tabRouter: TabRouterProtocol, dataSource: [TableViewCellPresentable]) {
        self.dataSource = dataSource
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
        let cell = String(describing: TableViewCell.self)
        tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
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

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCell) as? TableViewCell {
            cell.configure(with: model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
       
        switch model.cellType {
        case .title:
            tabRouter.navigateToTitleDetails(id: model.id)
        case .name:
            tabRouter.navigateToPersonDetails(id: model.id)
        case .unknown:
            break
        }
    }
}
