//
//  FamilyMember.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/30.
//

import Foundation

public struct FamilyMember: Equatable {
    public let memberID: Int
    public let nickname: String
    public let memberType: MemberType
    public let profileURL: String?
    public let familyStatus: FamilyStatus?
    
    public init(memberID: Int, nickname: String, memberType: MemberType, profileURL: String?, familyStatus: FamilyStatus?) {
        self.memberID = memberID
        self.nickname = nickname
        self.memberType = memberType
        self.profileURL = profileURL
        self.familyStatus = familyStatus
    }
}
