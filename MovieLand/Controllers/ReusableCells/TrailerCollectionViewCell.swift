//
//  TrailerCollectionViewCell.swift
//  MovieLand
//
//  Created by Patka on 29/04/2023.
//

import UIKit
import SDWebImage

class TrailerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trailerViewContainer: UIView!
    @IBOutlet weak var trailerImage: UIImageView!
    @IBOutlet weak var trailerTextView: UITextView!
    @IBOutlet weak var trailerWebButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: WelcomeScreenTrailerModel) {
        let posterUrl = URL(string: model.comingSoonModel.image)
        posterImage.sd_setImage(with: posterUrl)
        movieTitleLabel.text = model.comingSoonModel.title
    }
}
