//
//  TableViewCell.swift
//  MovieLand
//
//  Created by Patka on 10/03/2023.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var cellNameLabel: UILabel!
    
    @IBOutlet weak var cellAdditionalInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(with model: Results) {
        cellNameLabel.text = model.title
        cellAdditionalInfoLabel.text = model.description
        cellImage.sd_setImage(with: URL(string: model.image))
    }
    
    }
    

