//
//  ActorTableViewCell.swift
//  MovieLand
//
//  Created by Patka on 09/03/2023.
//

import UIKit
import SDWebImage

class ActorTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model: Results) {
        titleLabel.text = model.title
        titleImageView.sd_setImage(with: URL(string: model.image))
    }
}
