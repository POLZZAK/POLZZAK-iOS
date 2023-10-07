//
//  NotificationSettingType.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/25.
//

import Foundation

enum NotificationSettingType: CaseIterable {
    case familyRequest
    case level
    case stampRequest
    case stampBoardComplete
    case rewardRequest
    case rewarded
    case rewardFail
    case createdStampBoard
    case issuedCoupon
}

extension NotificationSettingType {
    func titleText(userType: UserType) -> String {
        switch self {
        case .familyRequest:
            return "연동알림"
        case .level:
            return "레벨알림"
        case .stampRequest:
            return "도장요청 알림"
        case .stampBoardComplete:
            return "도장판 완성 알림"
        case .rewardRequest:
            return "선물 조르기 알림"
        case .rewarded:
            return userType == .child ? "선물 수령 알림" : "선물 전달 확인 알림"
        case .rewardFail:
            return "선물 약속 미이행 알림"
        case .createdStampBoard:
            return "새로운 도장판 알림"
        case .issuedCoupon:
            return "쿠폰 발급 알림"
        }
    }
    
    func detailText(userType: UserType) -> String {
        switch self {
        case .familyRequest:
            return "연동 요청이 들어오거나 연동에 성공한 경우 알림을 받을래요"
        case .level:
            return "레벨 변동에 대한 알림을 받을래요"
        case .stampRequest:
            return "아이의 도장 요청 알림을 받을래요"
        case .stampBoardComplete:
            return "도장판이 모두 채워졌다는 알림을 받을래요"
        case .rewardRequest:
            return "아이의 선물 조르기 알림을 받을래요"
        case .rewarded:
            return userType == .child ? "아이가 선물을 받았다고 보내는 감사 인사를 받을래요" : "선물 전달이 완료되었는지 확인하는 알림을 받을래요"
        case .rewardFail:
            return "선물 약속 날짜를 어겼다는 알림을 받을래요"
        case .createdStampBoard:
            return "새로운 도장판이 만들어졌다는 알림을 받을래요"
        case .issuedCoupon:
            return "보호자가 선물 쿠폰을 발급해줬다는 알림을 받을래요"
        }
    }
}
