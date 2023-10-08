//
//  NotificationSettingDTO.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/24.
//

import Foundation

struct NotificationSettingDTO: Decodable {
    let familyRequest: Bool?
    let level: Bool?
    let stampRequest: Bool?
    let stampBoardComplete: Bool?
    let rewardRequest: Bool?
    let rewarded: Bool?
    let rewardFail: Bool?
    let createdStampBoard: Bool?
    let issuedCoupon: Bool?
}
