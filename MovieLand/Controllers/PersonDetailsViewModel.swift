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
    let apiManager: APIManagerProtocol
    
    weak var delegate: PersonDetailsViewModelDelegate?
    
    let tabRouter: TabRouterProtocol
    
    let persistenceManager: PersistenceManagerProtocol
    
    var personModel: PersonModel?
    
    var awardsArray: [PersonAwardSummaryModel]?
    
    init(apiManager: APIManagerProtocol,
         tabRouter: TabRouterProtocol,
         persistenceManager: PersistenceManagerProtocol) {
        self.apiManager = apiManager
        self.tabRouter = tabRouter
        self.persistenceManager = persistenceManager
    }
    
    //MARK: - Navigation
    
    func navigateToList(result: [SwipeableInformationTilePresentable]) {
        let mappedResult = result.compactMap { swipeable in
            return swipeable as? ListViewControllerCellPresentable
        }
        tabRouter.navigateToList(results: mappedResult, title: "")
    }
    
    func navigateToAwards() {
        guard let array = awardsArray else {
            return
        }
        self.tabRouter.navigateToList(results: array, title: Constants.awardsTitle)
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
                self?.handleSuccess(awardsResults: awardsResults, id: id)
                self?.delegate?.onFetchAwardsCompleted(success: true)
            case .failure(let error):
                self?.handleError(error: error)
                self?.delegate?.onFetchAwardsCompleted(success: false)
            }
        }
    }
    
    func handleSuccess(awardsResults: PersonAwardsModel, id: String) {
        var array: [PersonAwardSummaryModel] = []
        for outerItem in awardsResults.items {
            for innerItem in outerItem.nameAwardEventDetails {
                let model = PersonAwardSummaryModel(with: innerItem, eventTitle: outerItem.eventTitle, personId: id)
                array.append(model)
            }
        }
        awardsArray = array
    }
    
    //MARK: - Alerts
    
    func handleError(error: Error) {
            self.delegate?.presentAlertOffline(with: error)
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
    func presentAlertOffline(with error: Error)
    func onFetchAwardsCompleted(success: Bool)
}
