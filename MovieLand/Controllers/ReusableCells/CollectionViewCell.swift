//
//  InformationCell.swift
//  MovieLand
//
//  Created by Patka on 13/03/2023.
//

import UIKit
import SDWebImage

protocol SwipeableInformationTilePresentable {
    var optionalId: String { get }
    var iMDbRankLabelText: String? { get }
    var titleLabelText: String { get }
    var imageUrlString: String? { get }
    var additionalInfoLabelText: String? { get }
    var iMDbRatingNumberLabelText: String? { get }
    var contentType: CellContentType { get }
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var rankNumber: UILabel!
    @IBOutlet weak var rankScore: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    let apiManager: APIManagerProtocol = APIManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor(named: Constants.customPink)
        configureDefaultImage()
    }
    
    func configure(with model: SwipeableInformationTilePresentable) {
        title.text = model.titleLabelText
        
        if let yearMovieInfo = model.additionalInfoLabelText {
            info.text = yearMovieInfo
        } else {
            apiManager.fetchTitle(id: model.optionalId) { result in
                var yearMovieInfoFromDifferentModel: String?
                switch result {
                case .success(let movieYear):
                    yearMovieInfoFromDifferentModel = movieYear.year
                case .failure:
                    DispatchQueue.main.async {
                        self.info.isHidden = true
                    }
                }
                DispatchQueue.main.async {
                    self.info.text = yearMovieInfoFromDifferentModel
                }
            }
        }
        
        if model.iMDbRankLabelText?.isEmpty ?? true {
            rankNumber.isHidden = true
        } else {
            rankNumber.isHidden = false
            rankNumber.text = model.iMDbRankLabelText
        }
        
        if model.iMDbRatingNumberLabelText?.isEmpty ?? true {
            rankScore.isHidden = true
            starImage.isHidden = true
        } else {
            rankScore.isHidden = false
            rankScore.text = model.iMDbRatingNumberLabelText
        }
        
        if let urlString = model.imageUrlString {
            imageView.sd_setImage(with: URL(string: urlString))
        } else {
            apiManager.fetchTitle(id: model.optionalId) { result in
                var imageUrlString: String?
                switch result {
                case .success(let titleModel):
                    imageUrlString = titleModel.image
                case .failure:
                    self.configureDefaultImage()
                }
                self.configureImage(for: imageUrlString)
            }
        }
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
            DispatchQueue.main.async {
                self.imageView.image = Constants.defaultImage
            }
        }
        
        func cancelCurrentTask() {
            apiManager.cancelCurrentTask()
            imageView.sd_cancelCurrentImageLoad()
        }
    }
