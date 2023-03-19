//
//  Top250MoviesViewController.swift
//  MovieLand
//
//  Created by Patka on 18/03/2023.
//

import UIKit

class Top250MoviesViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topMoviesTableView: UITableView!
    
    let tabRouter: TabRouterProtocol
    var dataSource: [FeaturedMoviesModel] = []
    
    init(tabRouter: TabRouterProtocol) {
        self.tabRouter = tabRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFeaturedMoviesList()
        configureTopMoviesTableView()
        
    }
    
    // MARK: - Movies List configuration
    
    func fetchFeaturedMoviesList() {
        let apiManager = APIManager()
        apiManager.fetchFeaturedMoviesResults { [weak self] result in
            switch result {
            case .success(let moviesList):
                self?.handleSuccess(model: moviesList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func handleSuccess(model: ItemsForFeaturedMoviesModel) {
        dataSource = model.items
        DispatchQueue.main.async {
            self.topMoviesTableView.reloadData()
        }
    }
    
    func configureTopMoviesTableView() {
        topMoviesTableView.backgroundColor = UIColor(named: Constants.customDarkPink)
        let cell = String(describing: TableViewCell.self)
        topMoviesTableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        topMoviesTableView.delegate = self
        topMoviesTableView.dataSource = self
        topMoviesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension Top250MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        
        if let cell = topMoviesTableView.dequeueReusableCell(withIdentifier: Constants.tableViewCell) as? TableViewCell {
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

extension Top250MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        tabRouter.navigateToTitleDetails(id: model.id)
    }
}
