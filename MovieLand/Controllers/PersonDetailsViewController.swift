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
    @IBOutlet weak var awardsTextView: UITextView!
    @IBOutlet weak var awardsButton: UIButton!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var castMoviesLabel: UILabel!
    @IBOutlet weak var castMoviesCollectionViewContainer: UIView!
    @IBOutlet weak var seeAllCastMovieButton: UIButton!
    @IBOutlet weak var deathDateLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var roleAndBirthDateView: UIView!
    @IBOutlet weak var awardsView: UIView!
    
    @IBOutlet weak var CastLabelAndButtonView: UIView!
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.toggleActivity(active: false)
        }
    }
    
    // MARK: - View Configuration
    
    func configureView() {
        configureCollectionViewCastMovies()
        awardsButton.isEnabled = false
        favouriteButton.makeRound()
        roleAndBirthDateView.makeRound(radius: 20)
        awardsView.makeRound(radius: 20)
        CastLabelAndButtonView.makeRound(radius: 20)
        navigationController?.navigationBar.barTintColor =  UIColor(named: Constants.customDarkBlue)
        tabBarController?.tabBar.barTintColor = UIColor(named: Constants.customDarkBlue)
    }
    
    //MARK: - Person Details Configuration
    
    func prepareForShowingPersonInformation() {
        viewModel.fetchPersonInformation(id: personID)
        viewModel.fetchPersonAwards(id: personID)
        updateFavouriteIcon(isFavourite: false)
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
            
            self.updateFavouriteIcon(isFavourite: self.viewModel.isFavourite())
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
            self.awardsTextView.text = personAwards
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
        awardsTextView.isHidden = true
        awardsButton.isHidden = true
    }
    
    //MARK: - Collection View Configuaration
    
    func configureCollectionViewCastMovies() {
        addChild(castMoviesController)
        castMoviesCollectionViewContainer.addSubview(castMoviesController.view)
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
    
    //MARK: - Favourites
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        viewModel.toggleFavourite()
        updateFavouriteIcon(isFavourite: viewModel.isFavourite())
    }
    
    func updateFavouriteIcon(isFavourite: Bool) {
        if isFavourite {
            favouriteButton.setImage(Constants.heartFillImage, for: .normal)
        } else {
            favouriteButton.setImage(Constants.heartImage, for: .normal)
        }
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
    
    func presentAlertOffline(with error: Error) {
        DispatchQueue.main.async {
            self.presentAlert(with: error)
        }
    }
}
