//
//  Constants.swift
//  MovieLand
//
//  Created by Patka on 07/03/2023.
//

import Foundation
import UIKit

struct Constants {
    
    // MARK: - Images
    static let heartImage = UIImage(systemName: "heart")
    static let heartFillImage = UIImage(systemName: "heart.fill")
    static let listBulletImage = UIImage(systemName: "list.bullet")
    static let magnifyingGlassImage = UIImage(systemName: "magnifyingglass")
    static let featuredImageHeart = UIImage(systemName: "suit.heart")
    static let homekitImage = UIImage(systemName: "homekit")
    static let defaultImage = UIImage(named: "camera")
    static let eyeNotSeenIcon = UIImage(systemName: "eye")
    static let eyeSeenIcon = UIImage(systemName: "eye.fill")
    static let wantToWatch = UIImage(systemName: "plus")
    static let onWantToWatchList = UIImage(systemName: "doc.text.fill")

    // MARK: - Titles/Names
   
    static let regularTableViewCell = "TableViewCell"
    static let awardsTableViewCell = "AwardsTableViewCell"
    static let collectionViewCell = "CollectionViewCell"
    static let iMDbRating = "IMDb Rating:"
    
 
    // MARK: - Colors
    
    static let customBeige = "CustomBeige"
    static let customDarkBlue = "CustomDarkBlue"
    static let customDarkPink = "CustomDarkPink"
    static let customLightGrey = "CustomLightGrey"
    static let customLightOrange = "CustomLightOragne"
    static let customLightPink = "CustomLightPink"
    static let customOrange = "CustomOrange"
    static let customPink = "CustomPink"
    static let customWhite = "CustomWhite"
    
    // MARK: - Alerts
    
    static let noInternet = "No internet"
    static let offlineMessage = "Ooops you appear to be offline. This app required internet connection."
    static let ok = "Ok"
    static let okButtonTapped = "Ok button tapped"
    static let urlWasNotCreatedCorrectly = "Url Was Not Created Correctly"
    static let failedUrl = "Ooops could not fetch awards"
}
