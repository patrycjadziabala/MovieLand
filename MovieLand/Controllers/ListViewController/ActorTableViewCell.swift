//
//  TableViewCell.swift
//  MovieLand
//
//  Created by Patka on 08/03/2023.
//

import UIKit
import SDWebImage

class ActorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textLabelDetails: UILabel!
    @IBOutlet weak var image1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(named: "Blue")
        contentView.layer.cornerRadius = CGFloat(20)
        
    }
    
    func configure(with model: Results) {
        textLabelDetails.text = model.title
        image1.sd_setImage(with: URL(string: model.image))
    }
}
