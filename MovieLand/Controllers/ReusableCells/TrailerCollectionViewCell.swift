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
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    private var currentModel: WelcomeScreenTrailerModel?
    private let apiManager: APIManagerProtocol = TMDBAPIManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: WelcomeScreenTrailerModel) {
        cancelCurrentTasks()
        
        self.currentModel = model
        let posterUrl = URL(string: model.comingSoonModel.image)
        posterImage.sd_setImage(with: posterUrl)
        movieTitleLabel.text = model.comingSoonModel.title
        
        if let trailerModel = model.trailerModel {
            configure(with: trailerModel)
        } else {
            apiManager.fetchTrailer(id: model.comingSoonModel.id) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let trailer):
                        self?.currentModel?.trailerModel = trailer
                        self?.configure(with: trailer)
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
        }
    }
    
    func cancelCurrentTasks() {
        apiManager.cancelCurrentTasks()
        trailerImage.sd_cancelCurrentImageLoad()
        posterImage.sd_cancelCurrentImageLoad()
    }
    
    private func configure(with model: TrailerModel) {
        if let thumbnailUrlString = model.thumbnailUrl, let url = URL(string: thumbnailUrlString) {
            trailerImage.sd_setImage(with: url)
        } else {
            trailerImage.sd_setImage(with: URL(string: currentModel?.comingSoonModel.image ?? ""))
        }
        if model.videoDescription?.isEmpty ?? true {
            trailerTextView.isHidden = true
        } else {
            trailerTextView.isHidden = false
            trailerTextView.text = model.videoDescription
        }
        playImage.isHidden = (model.link == nil)
    }
}
