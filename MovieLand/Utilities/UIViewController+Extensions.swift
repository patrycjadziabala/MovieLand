//
//  UIViewController+Extensions.swift
//  MovieLand
//
//  Created by Patka on 17/04/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func toggleActivity(active: Bool) {
        if active {
            let activityOverlay = ActivityOverlayView(frame: view.frame)
            view.addSubview(activityOverlay)
            activityOverlay.constraint(to: view)
            view.bringSubviewToFront(activityOverlay)
        } else {
            DispatchQueue.main.async {
                for subview in self.view.subviews {
                    if subview.isKind(of: ActivityOverlayView.self) {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
}

class ActivityOverlayView: UIView {
    var activityIndicator: UIActivityIndicatorView
    
    override init(frame: CGRect) {
        activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.color = UIColor(named: Constants.customDarkPink)
        super.init(frame: frame)
        doConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func doConfiguration() {
        addSubview(activityIndicator)
        backgroundColor = UIColor(named: Constants.customDarkBlue)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
}
