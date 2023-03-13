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
    
    let apiManager: APIManagerProtocol = APIManager()
    var currentModel: TitleModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        contentView.backgroundColor = UIColor(named: Constants.customPink)
        configureDefaultImage()
    }
    
    func configure(with model: CastMovieModel) {
        title.text = model.title
        info.text = model.year
        cancelCurrentTask()
        apiManager.fetchTitle(id: model.id) { result in
            switch result {
            case .success(let titleModel):
                self.currentModel = titleModel
            case .failure:
                self.currentModel = nil
            }
            DispatchQueue.main.async {
                if let urlString = self.currentModel?.image {
                    self.imageView.sd_setImage(with: URL(string: urlString))
                } else {
                    self.configureDefaultImage()
                }
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
