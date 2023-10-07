//
//  CouponFilterView.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/28.
//

import UIKit

import Extension
import FilterBottomSheet
import PolzzakUIKit
import SnapKit

public final class CouponFilterView: BaseFilterView {
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.setStackView(axis: .horizontal, spacing: 8)
        stackView.alignment = .center
        stackView.isHidden = true
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.setLabel(textColor: .blue500, font: .subtitle16Bd)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func commonSetup() {
        super.commonSetup()
        
        [headerLabel, sectionStackView].forEach {
            nameStackView.addArrangedSubview($0)
        }
        
        filterStackView.insertArrangedSubview(nameStackView, at: 1)
    }
    
    func handleAllFilterButtonTap() {
        super.handleAllFilterButtonTap()
        nameStackView.isHidden = true
    }
    
    func handleChildSectionFilterButtonTap(with family: FamilyMember) {
        super.handleChildSectionFilterButtonTap(with: family)
        nameStackView.isHidden = false
        headerLabel.text = "From"
    }
    
    func handleParentSectionFilterButtonTap(with family: FamilyMember) {
        super.handleParentSectionFilterButtonTap(with: family)
        nameStackView.isHidden = false
        headerLabel.text = "To"
    }
}

