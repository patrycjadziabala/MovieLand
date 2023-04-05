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
    @IBOutlet weak var cellAdditionalInfoLabel: UILabel!
    @IBOutlet weak var cellYearInfo: UILabel!
    @IBOutlet weak var cellIMDbRatingLabel: UILabel!
    @IBOutlet weak var cellIMDbRatingNumberLabel: UILabel!
    
    let apiManager: APIManagerProtocol = APIManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor(named: Constants.customLightPink)
        configureDefaultImage()
    }
    
    func configure(with model: TableViewCellPresentable) {
        cellNameLabel.text = model.nameLabelText
        cellAdditionalInfoLabel.text = model.additionalInfoLabelText
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
            cellIMDbRatingLabel.text = Constants.iMDbRating
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
        self.cellImage.image = Constants.defaultImage
    }
}


