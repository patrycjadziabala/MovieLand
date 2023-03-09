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
            
        }
    }
    func handleError(error: Error) {
        print(error)
    }
}
