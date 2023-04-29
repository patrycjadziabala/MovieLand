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
    @IBOutlet weak var cellIMDbRatingNumberLabel: UILabel!
    @IBOutlet weak var cellAdditionalInfoLabel: UILabel!
    @IBOutlet weak var cellYearInfo: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var crownImageView: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    let apiManager: APIManagerProtocol = APIManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
    }
    
    //MARK: - Configure Cell View
    
    func configureCellView() {
        configureDefaultImage()
    }
    
    //MARK: - Cell configuration
    
    func configure(with model: TableViewCellPresentable) {
        cellNameLabel.text = model.nameLabelText
        cellNameLabel.lineBreakMode = .byWordWrapping
        cellNameLabel.numberOfLines = 0
        
        containerView.makeRound(radius: 15)
        cellImage.applyShadow()
        rankView.makeRound()
        rankView.applyShadow()
        crownImageView.rotate(degrees: 35)
        
        fetchImage(with: model)
        configureMovieYear(with: model)
        configureIMDbRank(with: model)
        configureIMDbRating(with: model)
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
            rankView.isHidden = true
            crownImageView.isHidden = true
        } else {
            rankView.isHidden = false
            cellIMDbRankLabel.text = model.iMDbRankLabelText
            if let rank = Int(model.iMDbRankLabelText ?? "") {
                if rank > 3 {
                    crownImageView.isHidden = true
                } else {
                    crownImageView.isHidden = false
                }
            } else {
                crownImageView.isHidden = true
            }
        }
    }
    
    //MARK: - Movie iMDbRating
    func setRankStars(ranking: String) {
        if let intValue = Double(ranking) {
            DispatchQueue.main.async {
                switch intValue {
                case 0...1:
                    self.star1.image = Constants.starHalf
                case ...2:
                    self.star1.image = Constants.starFill
                case ...3:
                    self.star1.image = Constants.starFill
                    self.star2.image = Constants.starHalf
                case ...4:
                    self.star1.image = Constants.starFill
                    self.star2.image = Constants.starFill
                case ...5:
                    self.star1.image = Constants.starFill
                    self.star2.image = Constants.starFill
                    self.star3.image = Constants.starHalf
                case ...6:
                    self.star1.image = Constants.starFill
                    self.star2.image = Constants.starFill
                    self.star3.image = Constants.starFill
                case ...7:
                    self.star1.image = Constants.starFill
                    self.star2.image = Constants.starFill
                    self.star3.image = Constants.starFill
                    self.star4.image = Constants.starHalf
                case ...8:
                    self.star1.image = Constants.starFill
                    self.star2.image = Constants.starFill
                    self.star3.image = Constants.starFill
                    self.star4.image = Constants.starFill
                case ...9:
                    self.star1.image = Constants.starFill
                    self.star2.image = Constants.starFill
                    self.star3.image = Constants.starFill
                    self.star4.image = Constants.starFill
                    self.star5.image = Constants.starHalf
                case ...10:
                    self.star1.image = Constants.starFill
                    self.star2.image = Constants.starFill
                    self.star3.image = Constants.starFill
                    self.star4.image = Constants.starFill
                    self.star5.image = Constants.starFill
                default:
                    ()
                }
            }
        }
    }
    
    func configureIMDbRating(with model: TableViewCellPresentable) {
        if model.iMDbRatingNumberLabelText?.isEmpty ?? true {
            configureMovieRating(id: model.id)
        } else {
            cellIMDbRatingNumberLabel.text = "IMDb rating: \(model.iMDbRatingNumberLabelText ?? "")"
            setRankStars(ranking: model.iMDbRatingNumberLabelText ?? "0")
        }
    }
    
    func configureMovieRating(id: String) {
        apiManager.fetchRatings(id: id) { result in
            var ratingMovieFromDifferentModel: String?
            switch result {
            case .success(let movieRating):
                ratingMovieFromDifferentModel = movieRating.imDb
                self.setRankStars(ranking: ratingMovieFromDifferentModel ?? "0")
            case .failure:
                DispatchQueue.main.async {
                    self.cellIMDbRatingNumberLabel.isHidden = true
                }
            }
            DispatchQueue.main.async {
                if ratingMovieFromDifferentModel == "" {
                    self.cellIMDbRatingNumberLabel.isHidden = true
                } else {
                    self.cellIMDbRatingNumberLabel.text = "IMDb rating: \(ratingMovieFromDifferentModel ?? "")"
                }
            }
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
    
    func cancelCurrentTasks() {
        cellImage.sd_cancelCurrentImageLoad()
    }
}


