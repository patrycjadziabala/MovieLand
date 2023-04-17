//
//  TableViewCell.swift
//  MovieLand
//
//  Created by Patka on 10/03/2023.
//

import UIKit
import SDWebImage

protocol TableViewCellPresentable {
    var id: String { get }
    var iMDbRankLabelText: String? { get }
    var imageUrlString: String? { get }
    var nameLabelText: String? { get }
    var additionalInfoLabelText: String? { get }
    var yearInfoText: String? { get }
    var iMDbRatingNumberLabelText: String? { get }
    var contentType: CellContentType { get }
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellIMDbRankLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellAdditionalInfoLabel: UILabel!
    @IBOutlet weak var cellYearInfo: UILabel!
    @IBOutlet weak var cellIMDbRatingLabel: UILabel!
    @IBOutlet weak var cellIMDbRatingNumberLabel: UILabel!
    
    let apiManager: APIManagerProtocol = APIManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCellView()
    }
    
    //MARK: - Configure Cell View
    
    func configureCellView() {
        contentView.backgroundColor = UIColor(named: Constants.customLightPink)
        configureDefaultImage()
    }
    
    //MARK: - Cell configuration
    
    func configure(with model: TableViewCellPresentable) {
        cellNameLabel.text = model.nameLabelText
        cellAdditionalInfoLabel.text = model.additionalInfoLabelText
        
        fetchImage(with: model)
        configureMovieYear(with: model)
        configureIMDbRank(with: model)
        configureIMDbRating(with: model)
    }
    
    //MARK: - Movie rating
    
    func configureMovieRating(id: String) {
        apiManager.fetchRatings(id: id) { result in
            var ratingMovieFromDifferentModel: String?
            switch result {
            case .success(let movieRating):
                ratingMovieFromDifferentModel = movieRating.imDb
            case .failure:
                DispatchQueue.main.async {
                    self.cellIMDbRatingNumberLabel.isHidden = true
                    self.cellIMDbRatingLabel.isHidden = true
                }
            }
            DispatchQueue.main.async {
                self.cellIMDbRatingNumberLabel.text = ratingMovieFromDifferentModel
            }
        }
    }
    
    //MARK: - Movie Year
    
    func configureMovieYear(with model: TableViewCellPresentable) {
        if let yearMovieInfo = model.yearInfoText {
            cellYearInfo.text = yearMovieInfo
        } else {
            apiManager.fetchTitle(id: model.id) { result in
                var yearMovieInfoFromDifferentModel: String?
                switch result {
                case .success(let movieYear):
                    yearMovieInfoFromDifferentModel = movieYear.year
                case .failure:
                    DispatchQueue.main.async {
                        self.cellYearInfo.isHidden = true
                    }
                }
                DispatchQueue.main.async {
                    self.cellYearInfo.text = yearMovieInfoFromDifferentModel
                }
            }
        }
    }
   
    //MARK: - Movie iMDb Rank
    
    func configureIMDbRank(with model: TableViewCellPresentable) {
        if model.iMDbRankLabelText?.isEmpty ?? true {
            cellIMDbRankLabel.isHidden = true
        } else {
            cellIMDbRankLabel.isHidden = false
            cellIMDbRankLabel.text = model.iMDbRankLabelText
        }
    }
    
    //MARK: - Movie iMDbRating
    
    func configureIMDbRating(with model: TableViewCellPresentable) {
        if model.iMDbRatingNumberLabelText?.isEmpty ?? true {
            configureMovieRating(id: model.id)
        } else {
            cellIMDbRatingNumberLabel.text = model.iMDbRatingNumberLabelText
            cellIMDbRatingLabel.text = Constants.iMDbRating
        }
    }
    
    //MARK: - Image
    
    func fetchImage(with model: TableViewCellPresentable) {
        if let urlString = model.imageUrlString {
            cellImage.sd_setImage(with: URL(string: urlString))
        } else {
            apiManager.fetchTitle(id: model.id) { result in
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
                self.cellImage.sd_setImage(with: URL(string: urlString))
            } else {
                self.configureDefaultImage()
            }
        }
    }
    
    func configureDefaultImage() {
        DispatchQueue.main.async {
            self.cellImage.image = Constants.defaultImage
        }
    }
}


