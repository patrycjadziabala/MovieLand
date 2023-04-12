//
//  SearchViewController.swift
//  MovieLand
//
//  Created by Patka on 08/03/2023.
//

import UIKit


class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    let tabRouter: TabRouterProtocol
    
    init(tabRouter: TabRouterProtocol) {
        self.tabRouter = tabRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        let dataManager = APIManager()
        dataManager
            .fetchSearchResults(query: searchTextField.text ?? "")
        { [weak self] result in
            switch result {
            case .success(let searchResults):
                self?.handleSuccess(searchResults: searchResults)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
        searchButton.isEnabled = false
        searchTextField.endEditing(true)
    }
    
    func handleSuccess(searchResults: SearchResultsModel) {
        DispatchQueue.main.async {
            self.tabRouter.navigateToList(results: searchResults.results)
            self.searchButton.isEnabled = true
        }
    }
    
    func handleError(error: Error) {
        DispatchQueue.main.async {
            self.searchButton.isEnabled = true
        }
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let dataManager = APIManager()
        dataManager
            .fetchSearchResults(query: searchTextField.text ?? "")
        { [weak self] result in
            switch result {
            case .success(let searchResults):
                self?.handleSuccess(searchResults: searchResults)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
        searchTextField.text = ""
        searchButton.isEnabled = false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type in a name or a film title"
            return false
        }
    }
}
