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
