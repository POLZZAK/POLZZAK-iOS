//
//  MemberType.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/30.
//

import Foundation

public struct MemberType: Equatable {
    public let name: String?
    public let detail: String?
    
    public init(name: String?, detail: String?) {
        self.name = name
        self.detail = detail
    }
}
