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
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        let dataManager = APIManager()
        dataManager.fetchSearchResults(query: searchTextField.text ?? "") { result in
            print(result)
        }
    }
}
