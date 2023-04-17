//
//  ListViewController.swift
//  MovieLand
//
//  Created by Patka on 19/03/2023.
//

import UIKit

enum ListViewControllerCellType {
    case regularTableViewCell(model: TableViewCellPresentable)
    case awardTableViewCell(model: AwardsTableViewCellPresentable)
}

protocol ListViewControllerCellPresentable {
    var listCellType: ListViewControllerCellType { get }
    var contentType: CellContentType { get }
    var id: String { get }
}

class ListViewController: UIViewController {
    
    let tabRouter: TabRouterProtocol
    let tableView: UITableView
    var dataSource: [ListViewControllerCellPresentable]
    
    init(tabRouter: TabRouterProtocol, dataSource: [ListViewControllerCellPresentable]) {
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
    
    deinit {
        print("\(String(describing: Self.self)) dead")
    }
    
    //MARK: - View configuration
    
    func configureTableView() {
        view.addSubview(tableView)
        let regularCell = String(describing: TableViewCell.self)
        tableView.register(UINib(nibName: regularCell, bundle: nil), forCellReuseIdentifier: regularCell)
        let awardsCell = String(describing: AwardsTableViewCell.self)
        tableView.register(UINib(nibName: awardsCell, bundle: nil), forCellReuseIdentifier: awardsCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    //MARK: - Update Data Source
    
    func update(dataSource: [ListViewControllerCellPresentable]) {
        self.dataSource = dataSource
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let presentableModel = dataSource[indexPath.row]
        switch presentableModel.listCellType {
        case .regularTableViewCell(let model):
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.regularTableViewCell) as? TableViewCell {
                cell.configure(with: model)
                return cell
            }
        case .awardTableViewCell(let model):
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.awardsTableViewCell) as? AwardsTableViewCell {
                cell.configure(with: model)
                return cell
            }
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
        switch model.contentType {
        case .title:
            tabRouter.navigateToTitleDetails(id: model.id)
        case .name:
            tabRouter.navigateToPersonDetails(id: model.id)
        case .unknown:
            break
        }
    }
}
