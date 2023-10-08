//
//  NotificationSettingModel.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/24.
//

import Foundation

struct NotificationSettingModel: Codable {
    var familyRequest: Bool?
    var level: Bool?
    var stampRequest: Bool?
    var stampBoardComplete: Bool?
    var rewardRequest: Bool?
    var rewarded: Bool?
    var rewardFail: Bool?
    var createdStampBoard: Bool?
    var issuedCoupon: Bool?
}

extension NotificationSettingModel {
    func toDictionary() -> [String: Bool] {
        var dictionary = [String: Bool]()
        
        if let familyRequest = familyRequest {
            dictionary["familyRequest"] = familyRequest
        }
        
        if let level = level {
            dictionary["level"] = level
        }
        
        if let stampRequest = stampRequest {
            dictionary["stampRequest"] = stampRequest
        }
        
        if let stampBoardComplete = stampBoardComplete {
            dictionary["stampBoardComplete"] = stampBoardComplete
        }
        
        if let rewardRequest = rewardRequest {
            dictionary["rewardRequest"] = rewardRequest
        }
        
        if let rewarded = rewarded {
            dictionary["rewarded"] = rewarded
        }
        
        if let rewardFail = rewardFail {
            dictionary["rewardFail"] = rewardFail
        }
        
        if let createdStampBoard = createdStampBoard {
            dictionary["createdStampBoard"] = createdStampBoard
        }
        
        if let issuedCoupon = issuedCoupon {
            dictionary["issuedCoupon"] = issuedCoupon
        }
        
        return dictionary
    }
    
    func toOrderedArray(userType: UserType) -> [SettingItem] {
        var result = [SettingItem]()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            for type in NotificationSettingType.allCases {
                guard let title = child.label, title == "\(type)" else { continue }
                guard let bool = child.value as? Bool else { continue }
                let item = SettingItem(type: type, isEnabled: bool)
                result.append(item)
                break
            }
        }
        return result
    }
}

extension NotificationSettingModel {
    init(type: NotificationSettingType, value: Bool) {
        self.familyRequest = nil
        self.level = nil
        self.stampRequest = nil
        self.stampBoardComplete = nil
        self.rewardRequest = nil
        self.rewarded = nil
        self.rewardFail = nil
        self.createdStampBoard = nil
        self.issuedCoupon = nil
        
        switch type {
        case .familyRequest:
            self.familyRequest = value
        case .level:
            self.level = value
        case .stampRequest:
            self.stampRequest = value
        case .stampBoardComplete:
            self.stampBoardComplete = value
        case .rewardRequest:
            self.rewardRequest = value
        case .rewarded:
            self.rewarded = value
        case .rewardFail:
            self.rewardFail = value
        case .createdStampBoard:
            self.createdStampBoard = value
        case .issuedCoupon:
            self.issuedCoupon = value
        }
    }
}

extension NotificationSettingModel {
    init(settingItems: [SettingItem], bool: Bool) {
        self.init()
        
        for item in settingItems {
            switch item.type {
            case .familyRequest: self.familyRequest = bool
            case .level: self.level = bool
            case .stampRequest: self.stampRequest = bool
            case .stampBoardComplete: self.stampBoardComplete = bool
            case .rewardRequest: self.rewardRequest = bool
            case .rewarded: self.rewarded = bool
            case .rewardFail: self.rewardFail = bool
            case .createdStampBoard: self.createdStampBoard = bool
            case .issuedCoupon: self.issuedCoupon = bool
            }
        }
    }
}
