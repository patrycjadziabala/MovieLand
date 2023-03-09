//
//  MovieViewController.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    @IBOutlet weak var awardsTextView: UITextView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var actor1Image: UIImageView!
    @IBOutlet weak var actor1NameLabel: UILabel!
    @IBOutlet weak var actor1AsCharacterLabel: UILabel!
    @IBOutlet weak var actor2Image: UIImageView!
    @IBOutlet weak var actor2NameLabel: UILabel!
    @IBOutlet weak var actor2AsCharacterLabel: UILabel!
    @IBOutlet weak var actor3Image: UIImageView!
    @IBOutlet weak var actor3NameLabel: UILabel!
    @IBOutlet weak var actor3AsCharacterLabel: UILabel!
    @IBOutlet weak var actor4Image: UIImageView!
    @IBOutlet weak var actor4NameLabel: UILabel!
    @IBOutlet weak var actor4AsCharacterLabel: UILabel!
    @IBOutlet weak var moreLikeThisLabel: UILabel!
    @IBOutlet weak var movie1PosterImage: UIImageView!
    @IBOutlet weak var movie1TitleLabel: UILabel!
    @IBOutlet weak var movie2PosterImage: UIImageView!
    @IBOutlet weak var movie2TitleLabel: UILabel!
    @IBOutlet weak var movie3PosterImage: UIImageView!
    @IBOutlet weak var movie3TitleLabel: UILabel!
    @IBOutlet weak var movie4PosterImage: UIImageView!
    @IBOutlet weak var movie4TitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        scrollView.showsVerticalScrollIndicator = false
    
        let apiManager = APIManager()
        apiManager.fetchTitle(id: "tt0411008") { [weak self] result in
            print(result)
            //zrob switcha, zrob metody handleSuccess i handleError tak jak w SearchViewController
            // w success pokaż dane czyli titleLabel.text = titleModel.title
            // itd
            // wyświetlić obrazek w imageView za pomocą biblioteki SDWebImage:
            // na imageView wywołać tak: self.cośtamImageView.sd_setImage(with: url)
            /*
             skąd wziąć urla?
             let url = URL(string: titleModel.image)
             i wtedy wysołujesz
             self.cośtamImageView.sd_setImage(with: url)
             */
        }
        // Do any additional setup after loading the view.
    }
}
    
