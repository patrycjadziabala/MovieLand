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
    var awardsCellOutcomeYear: String? { get }
    var awardsCellOutcomeTitle: String? { get }
    var awardsCellOutcomeCategory: String? { get }
    var awardsCellType: CellContentType { get }
}

class AwardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var awardsCellContentView: UIView!
    @IBOutlet weak var awardsCellImageView: UIImageView!
    @IBOutlet weak var awardsCellEventTitle: UILabel!
    @IBOutlet weak var awardsCellOutcomeYear: UILabel!
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
        awardsCellEventTitle.text = model.awardsCellEventTitle
        awardsCellAwardName.text = model.awardsCellAwardName
        awardsCellOutcomeYear.text = model.awardsCellOutcomeYear
        awardsCellOutcomeTitle.text = model.awardsCellOutcomeTitle
        awardsCellOutcomeCategory.text = model.awardsCellOutcomeCategory
    }
}
