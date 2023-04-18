//
//  PersonDetailsViewModel.swift
//  MovieLand
//
//  Created by Patka on 07/04/2023.
//

import Foundation

protocol PersonDetailsViewModelProtocol: AnyObject {
    
    func fetchPersonInformation(id: String)
    func fetchPersonAwards(id: String)
    func navigateToList(result:[SwipeableInformationTilePresentable])
    func navigateToAwards()
    func toggleFavourite()
    func isFavourite() -> Bool
    var delegate: PersonDetailsViewModelDelegate? { get set }
}

class PersonDetailsViewModel: PersonDetailsViewModelProtocol {
    
    let apiManager = APIManager()
    
    weak var delegate: PersonDetailsViewModelDelegate?
    
    let tabRouter: TabRouterProtocol
    
    let persistenceManager: PersistenceManagerProtocol
    
    var personModel: PersonModel?
    
    private var awardsArray: [PersonAwardSummaryModel]?
    
    init(tabRouter: TabRouterProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.tabRouter = tabRouter
        self.persistenceManager = persistenceManager
    }
    
    //MARK: - Navigation
    
    func navigateToList(result: [SwipeableInformationTilePresentable]) {
        let mappedResult = result.compactMap { swipeable in
            return swipeable as? ListViewControllerCellPresentable
        }
        tabRouter.navigateToList(results: mappedResult)
    }
    
    func navigateToAwards() {
        guard let array = awardsArray else {
            return
        }
        self.tabRouter.navigateToList(results: array)
    }
    
    //MARK: - Fetch Person Information
    
    func fetchPersonInformation(id: String) {
        apiManager.fetchPersonInformation(id: id) { [weak self] result in
            switch result {
            case .success(let person):
                self?.personModel = person
                self?.delegate?.onFetchPersonInformationSuccess(model: person)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    //MARK: - Fetch Awards
    
    func fetchPersonAwards(id: String) {
        apiManager.fetchPersonAwardsInformation(id: id) { [weak self] result in
            switch result {
            case .success(let awardsResults):
                self?.handleSuccess(awardsResults: awardsResults)
                self?.delegate?.onFetchAwardsCompleted(success: true)
            case .failure(let error):
                self?.handleError(error: error)
                self?.delegate?.onFetchAwardsCompleted(success: false)
            }
        }
    }
    
    func handleSuccess(awardsResults: PersonAwardsModel) {
        var array: [PersonAwardSummaryModel] = []
        for outerItem in awardsResults.items {
            for innerItem in outerItem.outcomeItems {
                let model = PersonAwardSummaryModel(with: innerItem, eventTitle: outerItem.eventTitle)
                array.append(model)
            }
        }
        awardsArray = array
    }
    
    //MARK: - Alerts
    
    func handleError(error: Error) {
            self.delegate?.presentAlertOffile(with: error)
    }
    
  //MARK: - Favourites
    
    func toggleFavourite() {
      
        guard let personModel = self.personModel else {
            return
        }
        persistenceManager.togglePersisted(model: .person(model: personModel))
        
    }
    
    func isFavourite() -> Bool {
        guard let personModel = self.personModel else {
            return false
        }
        return persistenceManager.isPersisted(model: .person(model: personModel))
    }
}

//MARK: - PersonDetailsViewModel - Delegate

protocol PersonDetailsViewModelDelegate: AnyObject {
    func onFetchPersonInformationSuccess(model: PersonModel)
    func presentAlertOffile(with error: Error)
    func onFetchAwardsCompleted(success: Bool)
}
