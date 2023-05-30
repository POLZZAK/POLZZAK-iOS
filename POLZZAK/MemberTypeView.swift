//
//  MemberTypeView.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/05/27.
//

import UIKit
import SnapKit

class MemberTypeView: UIView {
    private let memberTypeLabel: UILabel = {
        let label = UILabel()
        label.setLabel(textColor:.gray700, font: .body2, textAlignment: .center)
        return label
    }()
    
    init(with text: String) {
        memberTypeLabel.text = text
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension MemberTypeView {
    private func setUI() {
        setCustomView(backgroundColor: .gray200, cornerRadius: 8, borderWidth: 1, borderColor: UIColor(white: 0, alpha: 0.12))
        
        addSubview(memberTypeLabel)
        
        memberTypeLabel.snp.makeConstraints {
            $0.top.equalTo(4)
            $0.leading.equalTo(12)
            $0.trailing.equalTo(-12)
            $0.bottom.equalTo(-4)
        }
    }
    
    func configure(with text: String) {
        memberTypeLabel.text = text
    }
}