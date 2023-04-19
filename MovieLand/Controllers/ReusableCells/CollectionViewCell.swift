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
    var yearOrAdditionalInfoLabelText: String? { get }
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
        
        configureCellView()
    }
    
    //MARK: - Configure Cell View
    
    func configureCellView() {
        contentView.backgroundColor = UIColor(named: Constants.customPink)
        configureDefaultImage()
        starImage.isHidden = true
    }
    
    //MARK: - Cell configuration
    
    func configure(with model: SwipeableInformationTilePresentable) {
        title.text = model.titleLabelText
        configureMovieYear(with: model)
        configureRankingNumber(with: model)
        configureRankNumber(with: model)
        fetchImage(with: model)
    }
    
    //MARK: - Movie Year
    
    func configureMovieYear(with model: SwipeableInformationTilePresentable) {
        if let yearMovieInfo = model.yearOrAdditionalInfoLabelText {
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
    }
    
    //MARK: - Movie Rating
    
    func configureRankingNumber(with model: SwipeableInformationTilePresentable) {
        if let rankingNumber = model.iMDbRatingNumberLabelText {
            rankScore.text = rankingNumber
            self.starImage.isHidden = false
        } else {
            apiManager.fetchRatings(id: model.optionalId) { result in
                var ratingMovieFromDifferentModel: String?
                switch result {
                case .success(let movieRating):
                    ratingMovieFromDifferentModel = movieRating.imDb
                    DispatchQueue.main.async {
                        self.starImage.isHidden = false
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.rankScore.isHidden = true
                    }
                }
                DispatchQueue.main.async {
                    self.rankScore.text = ratingMovieFromDifferentModel
                }
            }
        }
    }
    
    //MARK: - Movie Rank
    
    func configureRankNumber(with model: SwipeableInformationTilePresentable) {
        if model.iMDbRankLabelText?.isEmpty ?? true {
            rankNumber.isHidden = true
        } else {
            rankNumber.isHidden = false
            rankNumber.text = model.iMDbRankLabelText
        }
    }
    //MARK: - Image
    
    func fetchImage(with model: SwipeableInformationTilePresentable) {
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
    
    //MARK: - Task cancel
    
    func cancelCurrentTask() {
        apiManager.cancelCurrentTask()
        imageView.sd_cancelCurrentImageLoad()
    }
}

