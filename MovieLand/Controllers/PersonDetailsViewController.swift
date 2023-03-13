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
    @IBOutlet weak var collectionViewCastMovies: UICollectionView!
    
    let personID: String
    let tabRouter: TabRouterProtocol
    var dataSource: [CastMovieModel]
    
    
    init(personID: String, tabRouter: TabRouterProtocol) {
        self.personID = personID
        self.tabRouter = tabRouter
        self.dataSource = []
       
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViewCastMovies()
       
        let apiManager = APIManager()
            apiManager.fetchPersonInformation(id: personID) { [weak self] result in
                switch result {
                case .success(let person):
                    self?.handleSuccess(personModel: person)
                 
                case .failure(let error):
                    self?.handleError(error: error)
                }
                print(result)
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
            self.dataSource = personModel.castMovies
            self.collectionViewCastMovies.reloadData()
                
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
    
    func presentAlert(with error: Error) {
        let alert = UIAlertController(title: "No internet", message: "Ooops you appear to be offline. This app required internet connection.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func configureCollectionViewCastMovies() {
        collectionViewCastMovies.dataSource = self
        collectionViewCastMovies.delegate = self
        collectionViewCastMovies.register(UINib(nibName: Constants.collectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCell)
        collectionViewCastMovies.backgroundColor = UIColor(named: Constants.customPink)
        
    }
    
}

extension PersonDetailsViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        CGSize(width: 80, height: collectionViewCastMovies.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let collectionViewCell = cell as? CollectionViewCell
    }
}

extension PersonDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewCastMovies.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCell, for: indexPath) as? CollectionViewCell{
            cell.configure(with: dataSource[indexPath.item])
            return cell
        }
            
        return UICollectionViewCell()
    }
    
    
}



//class ScrollableHorizontalItemListView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    let itemsStackView: UIStackView
//    required init?(coder: NSCoder) {
//        itemsStackView = UIStackView(frame: .zero)
//        super.init(coder: coder)
//        let scrollView = UIScrollView(frame: frame)
//        addSubview(scrollView)
//        scrollView.constraint(to: self)
//        scrollView.backgroundColor = UIColor(named: Constants.customLightGrey)
//        scrollView.addSubview(itemsStackView)
//        itemsStackView.constraint(to: scrollView)
//        itemsStackView.distribution = .fillEqually
//        itemsStackView.spacing = 8
//        itemsStackView.axis = .horizontal
//        for i in 1...10 {
//            let item = ScrollableItemView(frame: CGRect(x: 0, y: 0, width: 200, height: 350), title: "title \(i)", subtitle: "subtitle \(i)", image: UIImage(named: "camera"))
//            itemsStackView.addArrangedSubview(item)
//        }
//    }
//}


