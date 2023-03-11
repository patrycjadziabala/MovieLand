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
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var castMoviesLabel: UILabel!
    @IBOutlet weak var movie1Image: UIImageView!
    @IBOutlet weak var movie1TitleLabel: UILabel!
    @IBOutlet weak var movie1RoleLabel: UILabel!
    @IBOutlet weak var movie2Image: UIImageView!
    @IBOutlet weak var movie2TitleLabel: UILabel!
    @IBOutlet weak var movie2RoleLabel: UILabel!
    @IBOutlet weak var movie3Image: UIImageView!
    @IBOutlet weak var movie3TitleLabel: UILabel!
    @IBOutlet weak var movie3RoleLabel: UILabel!
    @IBOutlet weak var movie4Image: UIImageView!
    @IBOutlet weak var movie4TitleLabel: UILabel!
    @IBOutlet weak var movie4RoleLabel: UILabel!
    
    let personID: String
    let tabRouter: TabRouterProtocol
    
    init(personID: String, tabRouter: TabRouterProtocol) {
        self.personID = personID
        self.tabRouter = tabRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiManager = APIManager()
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
            
            //            if let movie1ImageId = personModel.castMovies.id {
            //                let movie1ImageId = titleModel.id
            //                self.movie1Image.image = movie1ImageId
//        }
        }
    }
    
    func handleError(error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.presentAlert(with: error)
        }
        
    }
    
//    func fetchCastMoviesId (id: Int, personModel: PersonModel, titleModel: TitleModel) {
//        let titleId = titleModel.id
//        let castMovieId = personModel.castMovies[0].id
//
//        switch id {
//        case
//            return
//
//
//    }
    
    func presentAlert(with error: Error) {
        let alert = UIAlertController(title: "No internet", message: "Ooops you appear to be offline. This app required internet connection.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

class ScrollableHorizontalItemListView: UIView {
    
    let itemsStackView: UIStackView

    required init?(coder: NSCoder) {
        itemsStackView = UIStackView(frame: .zero)
        super.init(coder: coder)
        let scrollView = UIScrollView(frame: frame)
        addSubview(scrollView)
        scrollView.constraint(to: self)
        scrollView.backgroundColor = UIColor(named: Constants.customLightGrey)
        scrollView.addSubview(itemsStackView)
        itemsStackView.constraint(to: scrollView)
        itemsStackView.distribution = .fillEqually
        itemsStackView.spacing = 8
        itemsStackView.axis = .horizontal
        for i in 1...10 {
            let item = ScrollableItemView(frame: CGRect(x: 0, y: 0, width: 200, height: 350), title: "title \(i)", subtitle: "subtitle \(i)", image: UIImage(named: "camera"))
            itemsStackView.addArrangedSubview(item)
        }
    }
}


