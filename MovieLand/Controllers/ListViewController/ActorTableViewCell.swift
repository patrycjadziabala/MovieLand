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
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(named: "System Teal Color")
        contentView.layer.cornerRadius = CGFloat(20)
        
    }
}
