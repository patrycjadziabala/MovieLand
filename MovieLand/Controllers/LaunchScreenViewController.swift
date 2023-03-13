//
//  ViewController.swift
//  MovieLand
//
//  Created by Patka on 01/03/2023.
//

import UIKit
import Tweener
import SDWebImage

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextView!
    
    @IBOutlet weak var movieIcon: UIImageView!
    
    @IBOutlet weak var gifImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        
        titleTextField.text = "MovieLand"
        
        let gif = UIImage.gifImageWithName("cinema")
        gifImage.image = gif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rotate(view: movieIcon)
        animateFallDown(view: titleTextField)
    }
    
    var rotationCounter = 0
    
    func rotate(view: UIView) {
        
        let myRotationAim = RotationAim(target: view)
        
        Tween(myRotationAim)
            .from(.key(\.angle, 0.0))
            .to(.key(\.angle, 360.0))
            .duration(3.0)
            .play()
            .onComplete {
                if self.rotationCounter <= 3 {
                    self.rotationCounter += 1
                    self.rotate(view: view)
                }
            }
    }
    
    func animateFallDown(view: UIView) {
        view.flyTop()
    }
}
