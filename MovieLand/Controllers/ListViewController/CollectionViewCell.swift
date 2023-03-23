//
//  InformationCell.swift
//  MovieLand
//
//  Created by Patka on 13/03/2023.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var rankNumber: UILabel!
    @IBOutlet weak var rankScore: UILabel!
    
    let apiManager: APIManagerProtocol = APIManager()
//    var currentModel: TitleModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        contentView.backgroundColor = UIColor(named: Constants.customPink)
        configureDefaultImage()
    }
    
    func configure(with model: SwipeableInformationTilePresentable) {
        if let movieModel = model as? CastMovieModel {
            configure(with: movieModel)
        } else if let actorModel = model as? ActorForTitleModel {
            configure(with: actorModel)
        } else if let similarMovieModel = model as? Similars {
            configure(with: similarMovieModel)
        } else if let comingSoonModel = model as? ComingSoonModel {
            configure(with: comingSoonModel)
        }
    }
    
    func configure(with model: CastMovieModel) {
        title.text = model.title
        info.text = model.year
        rankScore.isHidden = true
        rankNumber.isHidden = true
        cancelCurrentTask()
        configureDefaultImage()
        apiManager.fetchTitle(id: model.id) { result in
            var imageUrlString: String?
            switch result {
            case .success(let titleModel):
                imageUrlString = titleModel.image
            case .failure:
                imageUrlString = nil
            }
            self.configureImage(for: imageUrlString)
        }
    }
    
    func configure(with model: ActorForTitleModel) {
        cancelCurrentTask()
        title.text = model.name
        info.text = model.asCharacter
        rankScore.isHidden = true
        rankNumber.isHidden = true
        configureImage(for: model.image)
    }
    
    func configure(with model: Similars) {
        cancelCurrentTask()
        title.text = model.title
        info.isHidden = true
        rankScore.isHidden = true
        rankNumber.isHidden = true
        configureImage(for: model.image)
    }
    
    func configure(with model: ComingSoonModel) {
        cancelCurrentTask()
        title.text = model.title
        info.isHidden = true
        rankScore.isHidden = true
        rankNumber.isHidden = true
        configureImage(for: model.image)
    }
    
    func configureImage(for urlString: String?) {
        DispatchQueue.main.async {
            if let urlString = urlString {
                self.imageView.sd_setImage(with: URL(string: urlString))
            } else {
                self.configureDefaultImage()
            }
        }
    }
    
    func configureDefaultImage() {
        self.imageView.image = UIImage(named: "camera")
    }
    
    func cancelCurrentTask() {
        apiManager.cancelCurrentTask()
        imageView.sd_cancelCurrentImageLoad()
    }
}
