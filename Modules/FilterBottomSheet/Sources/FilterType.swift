//
//  FilterType.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/24.
//

import Foundation

public enum FilterType {
    case all
    case section(Int)
    case none
}

extension FilterType: Equatable {
    public static func == (lhs: FilterType, rhs: FilterType) -> Bool {
        switch (lhs, rhs) {
        case (.all, .all), (.none, .none):
            return true
        case let (.section(leftMember), .section(rightMember)):
            return leftMember == rightMember
        default:
            return false
        }
    }
}
