//
//  PersonDetailsViewController.swift
//  MovieLand
//
//  Created by Patka on 08/03/2023.
//

import UIKit

class PersonDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var personInfoTextView: UITextView!
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var awardsLabel: UITextView!
    @IBOutlet weak var awardsButton: UIButton!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var castMoviesLabel: UILabel!
    @IBOutlet weak var castMoviesCollectionViewContainer: UIView!
    
    let apiManager = APIManager()
    let castMoviesController: SwipeableInformationTilesController
    let personID: String
    let tabRouter: TabRouterProtocol
    
    init(personID: String, tabRouter: TabRouterProtocol) {
        self.personID = personID
        self.tabRouter = tabRouter
        self.castMoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
       
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViewCastMovies()
       
            apiManager.fetchPersonInformation(id: personID) { [weak self] result in
                switch result {
                case .success(let person):
                    self?.handleSuccess(personModel: person)
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }
    }
    
    func handleSuccess(personModel: PersonModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = personModel.name
            self.roleLabel.text = personModel.role
            self.birthDateLabel.text = personModel.birthDate
            self.personInfoTextView.text = personModel.summary
            let imageUrl = URL(string: personModel.image)
            self.personImageView.sd_setImage(with: imageUrl)
            self.heightLabel.text = personModel.height
            self.awardsLabel.text = personModel.awards
            self.castMoviesController.set(dataSource: personModel.castMovies)
//            self.collectionViewCastMovies.reloadData()
                
           
        }
    }
    
    func handleError(error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.presentAlert(with: error)
        }
        
    }
    
    func presentAlert(with error: Error) {
        let alert = UIAlertController(title: "No internet", message: "Ooops you appear to be offline. This app required internet connection.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func configureCollectionViewCastMovies() {
//        collectionViewCastMovies.dataSource = self
//        collectionViewCastMovies.delegate = self
//        collectionViewCastMovies.register(UINib(nibName: Constants.collectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCell)
//        collectionViewCastMovies.backgroundColor = UIColor(named: Constants.customPink)
        
        
        addChild(castMoviesController)
        view.addSubview(castMoviesController.view)
        castMoviesController.didMove(toParent: self)
        castMoviesController.view.constraint(to: castMoviesCollectionViewContainer)
    }
    
    // MARK: - Awards configuration
    
    @IBAction func awardsButtonPressed(_ sender: UIButton) {
        apiManager.fetchPersonAwardsInformation(id: personID) { [weak self] result in
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
}
