//
//  TableViewCell.swift
//  MovieLand
//
//  Created by Patka on 10/03/2023.
//

import UIKit
import SDWebImage

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


