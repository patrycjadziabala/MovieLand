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
    @IBOutlet weak var deathDateLabel: UILabel!
    
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
    
    deinit {
        print("\(String(describing: Self.self)) dead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivity(active: true)
        prepareForShowingPersonInformation()
        configureView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.toggleActivity(active: false)
        }
    }
    
    // MARK: - View Configuration
    
    func configureView() {
        configureCollectionViewCastMovies()
        awardsButton.isEnabled = false
    }
    
    //MARK: - Person Details Configuration
    
    func prepareForShowingPersonInformation() {
        viewModel.fetchPersonInformation(id: personID)
        viewModel.fetchPersonAwards(id: personID)
    }
    
    func handleSuccess(personModel: PersonModel) {
        DispatchQueue.main.async {
            self.seeAllCastMovieButton.isEnabled = true
            self.nameLabel.text = personModel.name
            self.configureBirthDate(personModel: personModel)
            self.roleLabel.text = personModel.role
            self.personInfoTextView.text = personModel.summary
            self.configureImage(personModel: personModel)
            self.heightLabel.text = personModel.height
            self.configurePersonAwards(personModel: personModel)
            self.castMoviesController.set(dataSource: personModel.castMovies)
            self.configurePersonDeathDate(personModel: personModel)
            //            self.collectionViewCastMovies.reloadData()
        }
    }
    //MARK: - Birth Date
    
    func configureBirthDate(personModel: PersonModel) {
        if personModel.birthDate == nil {
            self.birthDateLabel.isHidden = true
        } else {
            self.birthDateLabel.text = "Birth date: \(personModel.birthDate ?? "")"
            self.birthDateLabel.sizeToFit()
        }
    }
    
    //MARK: - Image
    
    func configureImage(personModel: PersonModel) {
        let imageUrl = URL(string: personModel.image)
        self.personImageView.sd_setImage(with: imageUrl)
    }
    
    //MARK: - Awards
    
    func configurePersonAwards(personModel: PersonModel) {
        if let personAwards = personModel.awards {
            self.awardsLabel.text = personAwards
        } else {
            self.hideAwardsLabelandButton()
        }
    }
    
    //MARK: - Death Date
    
    func configurePersonDeathDate(personModel: PersonModel) {
        if let personDeathDate = personModel.deathDate {
            self.deathDateLabel.text = "Death date: \(personDeathDate)"
        } else {
            self.deathDateLabel.isHidden = true
        }
    }
    
    func hideAwardsLabelandButton() {
        awardsLabel.isHidden = true
        awardsButton.isHidden = true
    }
    
    //MARK: - Collection View Configuaration
    
    func configureCollectionViewCastMovies() {
        addChild(castMoviesController)
        view.addSubview(castMoviesController.view)
        castMoviesController.didMove(toParent: self)
        castMoviesController.view.constraint(to: castMoviesCollectionViewContainer)
    }
    
    // MARK: - Alerts
    
    func presentAlert(with error: Error) {
        let alert = UIAlertController(title: Constants.noInternet, message: Constants.offlineMessage, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: Constants.ok, style: .default, handler: { (action) -> Void in
            print(Constants.okButtonTapped)
        })
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Cast
    
    @IBAction func seeAllCastMovieButtonPressed(_ sender: UIButton) {
        viewModel.navigateToList(result: castMoviesController.dataSource)
    }
    
    // MARK: - Awards
    
    @IBAction func awardsButtonPressed(_ sender: UIButton) {
        viewModel.navigateToAwards()
    }
}

// MARK: - PersonDetailsViewController - extension

extension PersonDetailsViewController: PersonDetailsViewModelDelegate {
    
    // enum zamiast bool i rozne case
    func onFetchAwardsCompleted(success: Bool) {
        DispatchQueue.main.async {
            self.awardsButton.isEnabled = success
        }
    }
    
    func onFetchPersonInformationSuccess(model: PersonModel) {
        handleSuccess(personModel: model)
    }
    
    func presentAlertOffile(with error: Error) {
        presentAlert(with: error)
    }
}
