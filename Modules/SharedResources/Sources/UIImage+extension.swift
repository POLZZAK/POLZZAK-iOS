//
//  UIImage+extension.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/05/14.
//

import UIKit

public extension UIImage {
    
    //MARK: - TabBarItem
    
    static let mainTabBarIcon = UIImage.bundledImage(named: "mainTabBarIcon")
    static let couponTabBarIcon = UIImage.bundledImage(named: "couponTabBarIcon")
    static let notificationTabBarIcon = UIImage.bundledImage(named: "notificationTabBarIcon")
    static let myPageTabBarIcon = UIImage.bundledImage(named: "myPageTabBarIcon")
    
    //MARK: - Button
    
    static let myConnectionsButton = UIImage.bundledImage(named: "myConnectionsButton")
    static let rightArrowButton = UIImage.bundledImage(named: "rightArrowButton")
    static let addStampBoardButton = UIImage.bundledImage(named: "addStampBoardButton")
    static let searchButton = UIImage.bundledImage(named: "searchButton")
    static let closeButton = UIImage.bundledImage(named: "closeButton")
    static let informationButton = UIImage.bundledImage(named: "informationButton")
    static let notificationSettingButton = UIImage.bundledImage(named: "notificationSettingButton")
    static let trashButton = UIImage.bundledImage(named: "trashButton")
    static let acceptButton = UIImage.bundledImage(named: "acceptButton")
    static let rejectButton = UIImage.bundledImage(named: "rejectButton")
    static let pictureButton = UIImage.bundledImage(named: "pictureButton")
    
    //MARK: - Character
    
    static let raisingOneHandCharacter = UIImage.bundledImage(named: "raisingOneHandCharacter")
    static let raisingTwoHandCharacter = UIImage.bundledImage(named: "raisingTwoHandCharacter")
    static let sittingCharacter = UIImage.bundledImage(named: "sittingCharacter")
    static let defaultProfileCharacter = UIImage.bundledImage(named: "defaultProfileCharacter")
    static let couponEmptyCharacter = UIImage.bundledImage(named: "couponEmptyCharacter")
    
    //MARK: - Common
    
    static let couponCompleted = UIImage.bundledImage(named: "couponCompleted")
    static let rewardCompleted = UIImage.bundledImage(named: "rewardCompleted")
    static let refreshDragImage = UIImage.bundledImage(named: "refreshDragImage")
    static let searchImage = UIImage.bundledImage(named: "searchImage")
    static let barcode = UIImage.bundledImage(named: "barcode")
    static let requestGradationView = UIImage.bundledImage(named: "requestGradationView")
    static let completedGradationView = UIImage.bundledImage(named: "completedGradationView")
    
    //MARK: - Icon
    static let circle4 = UIImage.bundledImage(named: "circle4")
    static let circle6 = UIImage.bundledImage(named: "circle6")
    static let checkmarkIcon = UIImage.bundledImage(named: "checkmarkIcon")
    static let chevronRightIcon = UIImage.bundledImage(named: "chevronRightIcon")
}

extension UIImage {
    static func bundledImage(named name: String) -> UIImage? {
        return UIImage(named: name, in: Bundle.module, compatibleWith: nil)
    }
}
