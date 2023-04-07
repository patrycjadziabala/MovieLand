//
//  PersonDetailsViewController.swift
//  MovieLand
//
//  Created by Patka on 08/03/2023.
//

import UIKit
import SDWebImage

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
    @IBOutlet weak var seeAllCastMovieButton: UIButton!
    
    let apiManager = APIManager()
    let castMoviesController: SwipeableInformationTilesController
    let personID: String
    let tabRouter: TabRouterProtocol
    let viewModel: PersonDetailsViewModelProtocol
    
    init(personID: String, tabRouter: TabRouterProtocol, viewModel: PersonDetailsViewModelProtocol) {
        self.personID = personID
        self.tabRouter = tabRouter
        self.castMoviesController = SwipeableInformationTilesController(dataSource: [], tabRouter: tabRouter)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchPersonInformation(id: personID)
        configureCollectionViewCastMovies()
      
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
    
    func presentAlert(with error: Error) {
        let alert = UIAlertController(title: Constants.noInternet, message: Constants.offlineMessage, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: Constants.ok, style: .default, handler: { (action) -> Void in
            print(Constants.okButtonTapped)
        })
        
        alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
    }
    
    func configureCollectionViewCastMovies() {

        addChild(castMoviesController)
        view.addSubview(castMoviesController.view)
        castMoviesController.didMove(toParent: self)
        castMoviesController.view.constraint(to: castMoviesCollectionViewContainer)
    }
    
    // MARK: - Cast configuration

    @IBAction func seeAllCastMovieButtonPressed(_ sender: UIButton) {
        
        viewModel.navigateToList(result: castMoviesController.dataSource)
    }
    
    // MARK: - Awards configuration
    
    @IBAction func awardsButtonPressed(_ sender: UIButton) {
        viewModel.fetchPersonAwards(id: personID)
            }
    }

// MARK: - PersonDetailsViewController - extension

extension PersonDetailsViewController: PersonDetailsViewModelDelegate {

    func onFetchPersonInformationSuccess(model: PersonModel) {
        handleSuccess(personModel: model)
    }
    
    func presentAlertOffile(with error: Error) {
        presentAlert(with: error)
    }
}
