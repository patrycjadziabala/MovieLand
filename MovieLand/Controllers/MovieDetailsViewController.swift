//
//  MovieViewController.swift
//  MovieLand
//
//  Created by Patka on 03/03/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
