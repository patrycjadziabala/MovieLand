//
//  AwardsTableViewCell.swift
//  MovieLand
//
//  Created by Patka on 04/04/2023.
//

import UIKit
import SDWebImage

protocol AwardsTableViewCellPresentable {
    var id: String { get }
    var awardsCellEventTitle: String? { get }
    var awardsCellAwardName: String? { get }
    var awardsCellOutcomeTitle: String? { get }
    var awardsCellOutcomeCategory: String? { get }
    var awardsCellImage: String? { get }
    var awardsCellType: CellContentType { get }
}

class AwardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var awardsCellContentView: UIView!
    @IBOutlet weak var awardsCellImageView: UIImageView!
    @IBOutlet weak var awardsCellEventTitle: UILabel!
    @IBOutlet weak var awardsCellOutcomeTitle: UILabel!
    @IBOutlet weak var awardsCellOutcomeCategory: UILabel!
    @IBOutlet weak var awardsCellAwardName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellView()
    }
    
    //MARK: - Configure Cell View
    
    func configureCellView() {
        contentView.backgroundColor = UIColor(named: Constants.customLightOrange)
    }
    
    //MARK: - Cell configuration
    
    func configure(with model: AwardsTableViewCellPresentable) {
        awardsCellAwardName.text = model.awardsCellAwardName
        awardsCellOutcomeCategory.text = model.awardsCellOutcomeCategory
        awardsCellEventTitle.text = model.awardsCellEventTitle
        if let imageUrlString = model.awardsCellImage {
            awardsCellImageView.sd_setImage(with: URL(string: imageUrlString))
        } else {
            awardsCellImageView.image = Constants.oscarImage
        }
        awardsCellOutcomeTitle.text = model.awardsCellOutcomeTitle
        
    }
}
