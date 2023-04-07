//
//  PersonDetailsViewModel.swift
//  MovieLand
//
//  Created by Patka on 07/04/2023.
//

import Foundation
import UIKit

protocol PersonDetailsViewModelProtocol: AnyObject {
    
    func fetchPersonInformation(id: String)
    func fetchPersonAwards(id: String)
    var delegate: PersonDetailsViewModelDelegate? { get set }
}

class PersonDetailsViewModel: PersonDetailsViewModelProtocol {
    
    let apiManager = APIManager()
    
    var delegate: PersonDetailsViewModelDelegate?
    
    let tabRouter: TabRouterProtocol
    
    init(tabRouter: TabRouterProtocol) {
        self.tabRouter = tabRouter
    }
    
    func fetchPersonInformation(id: String) {
        apiManager.fetchPersonInformation(id: id) { [weak self] result in
            switch result {
            case .success(let person):
                self?.delegate?.onFetchPersonInformationSuccess(model: person)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func fetchPersonAwards(id: String) {
        apiManager.fetchPersonAwardsInformation(id: id) { [weak self] result in
            switch result {
            case .success(let awardsResults):
                self?.handleSuccess(awardsResults: awardsResults)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    func handleSuccess(awardsResults: PersonAwardsModel) {
        DispatchQueue.main.async {
            var array: [PersonAwardSummaryModel] = []
            for outerItem in awardsResults.items {
                for innerItem in outerItem.outcomeItems {
                    let model = PersonAwardSummaryModel(with: innerItem, eventTitle: outerItem.eventTitle)
                    array.append(model)
                }
            }
            self.tabRouter.navigateToList(results: array)
        }
    }
    
    func handleError(error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.delegate?.presentAlertOffile(with: error)
        }
    }
}

protocol PersonDetailsViewModelDelegate {
    
    func onFetchPersonInformationSuccess(model: PersonModel)
    func presentAlertOffile(with error: Error)
}
