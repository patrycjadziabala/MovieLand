//
//  UIView+Extensions.swift
//  MovieLand
//
//  Created by Patka on 11/03/2023.
//

import Foundation
import UIKit

extension UIView {
    
    func constraint(to view: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
    }
    
    func applyShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    func makeRound() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    func makeRound(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    func rotate(degrees: CGFloat) {
        
        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        
        // If you like to use layer you can uncomment the following line
        //layer.transform = CATransform3DMakeRotation(degreesToRadians(degrees), 0.0, 0.0, 1.0)
    }
}


extension UINavigationController {
    func setNavigationBarCustomTitle(title: String, font: UIFont) {
        let navBar = self.navigationBar
        let titleFrame = CGRect(x: 0, y: 0, width: navBar.frame.width, height: navBar.frame.height)
        let titleLabel = UILabel(frame: titleFrame)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = font
        titleLabel.textColor = UIColor(named: Constants.customDarkPink)
        titleLabel.applyShadow()
        navBar.addSubview(titleLabel)
    }
    
    func clearNavigationBar() {
        let navBar = self.navigationBar
        for view in navBar.subviews {
            view.removeFromSuperview()
        }
    }
}
