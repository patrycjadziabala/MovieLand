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
    }
    
    func handleSuccess(searchResults: SearchResultsModel) {
        /*
         bedziemy z background wątku (thread) wracać na główny wątek.
         update UI ZAWSZE robimy na głównym wątku, więc cokolwiek się tutaj wydarzy w tej metodzie,
         musimy to opakować w
         DispatchQueue.main.async {
            // tu updatujemy ui. nie trzeba pisać [weak self] tutaj
         }
         */
    }
    
    func handleError(error: Error) {
        print(error.localizedDescription)
    }
}

/*
 
 Zadanie domowe:

 MovieDetailsViewController - podłączyć outlety

 PersonDetailsViewcontroller - usunąć tabelkę

 W obu kontrolerach powyższych jakoś sobie zaprojektować UI, biorąc pod uwagę modele - czyli dane które będziemy mieli dostępne do wyświetlenia (TitleModel i PersonModel)

 COMMITOWAĆ CZĘSTO

 Zadanie dodatkowe:

 Zrobić także handling errorów - wyświetlić alert użytkownikowi - UIAlertView (wyszukać w necie jak się to robi) i w tym uialertview (chyba tak to się nazywa) wyświetlić error.localizedDescription
 Jak to przetestować? Wyłączyć internet


 
 */
