//
//  Filterable.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/28.
//

import Foundation

public protocol Filterable {
    func handleAllFilterButtonTap()
    func handleSectionFilterButtonTap(isParent: Bool, nickname: String, memberName: String)
}

extension Filterable where Self: BaseFilterView {
    public func handleAllFilterButtonTap() {
        sectionStackView.isHidden = true
        filterLabel.isHidden = false
    }
    
    public func handleSectionFilterButtonTap(isParent: Bool, nickname: String, memberName: String) {
        nickNameLabel.text = nickname
        memberTypeLabel.text = memberName
        sectionStackView.isHidden = false
        memberTypeLabel.isHidden = isParent
        filterLabel.isHidden = true
    }
}
