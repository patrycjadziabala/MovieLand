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
    var cellType: TableViewCellType { get }
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellIMDbRankLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellAdditionalInfoLabel: UILabel!
    @IBOutlet weak var cellYearInfo: UILabel!
    @IBOutlet weak var cellIMDbRatingLabel: UILabel!
    @IBOutlet weak var cellIMDbRatingNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor(named: Constants.customLightPink)
    }
    
    func configure(with model: TableViewCellPresentable) {
        cellNameLabel.text = model.nameLabelText
        cellAdditionalInfoLabel.text = model.additionalInfoLabelText
        if let urlString = model.imageUrlString {
            cellImage.sd_setImage(with: URL(string: urlString))
        } else {
            // set default image
        }
        if model.yearInfoText?.isEmpty ?? true {
            cellYearInfo.isHidden = true
        } else {
            cellYearInfo.isHidden = false
            cellYearInfo.text = model.yearInfoText
        }
        if model.iMDbRankLabelText?.isEmpty ?? true {
            cellIMDbRankLabel.isHidden = true
        } else {
            cellIMDbRankLabel.isHidden = false
            cellIMDbRankLabel.text = model.iMDbRankLabelText
        }
        if model.iMDbRatingNumberLabelText?.isEmpty ?? true {
            cellIMDbRatingNumberLabel.isHidden = true
            cellIMDbRatingLabel.isHidden = true
        } else {
            cellIMDbRatingNumberLabel.text = model.iMDbRatingNumberLabelText
            cellIMDbRatingLabel.text = "IMDb Rating:"
        }
    }
    
    func configure(with model: Results) {
        cellNameLabel.text = model.title
        cellAdditionalInfoLabel.text = model.description
        cellImage.sd_setImage(with: URL(string: model.image))
        cellYearInfo.isHidden = true
        cellIMDbRankLabel.isHidden = true
        cellIMDbRatingLabel.isHidden = true
        cellIMDbRatingNumberLabel.isHidden = true
    }
    
    func configure(with model: FeaturedMoviesModel) {
        cellIMDbRankLabel.text = model.rank
        cellImage.sd_setImage(with: URL(string: model.image))
        cellNameLabel.text = model.title
        cellAdditionalInfoLabel.text = model.crew
        cellYearInfo.text = model.year
        cellIMDbRatingNumberLabel.text = model.imDbRating
    }
    
    func configure(with model: ComingSoonModel) {
        cellIMDbRankLabel.isHidden = true
        cellImage.sd_setImage(with: URL(string: model.image))
        cellNameLabel.text = model.title
        cellAdditionalInfoLabel.text = model.stars
        cellYearInfo.text = "Release Date: \(model.releaseState)"
        if model.imDbRating != "" {
            cellIMDbRatingLabel.text = "IMDb Rating:"
            cellIMDbRatingNumberLabel.text = model.imDbRating
        } else {
            cellIMDbRatingLabel.isHidden = true
            cellIMDbRatingNumberLabel.isHidden = true
        }
    }
}


