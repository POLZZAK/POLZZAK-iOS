//
//  TabView.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/06/11.
//

import UIKit
import SnapKit

protocol TabViewDelegate: AnyObject {
    func tabViewDidSelect(_ tabView: TabView)
}

final class TabView: UIView {
    weak var delegate: TabViewDelegate?
    
    let tabLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        return view
    }()
    
    var selectTextColor: UIColor = .blue500
    var selectFont: UIFont = .subtitle2
    var selectLineColor: UIColor = .blue500
    var selectLineHeight: CGFloat = 2.0 {
        didSet {
            underlineHeightConstraint?.update(offset: selectLineHeight)
        }
    }
    
    var deselectTextColor: UIColor = .gray300
    var deselectFont: UIFont = .subtitle2
    var deselectLineColor: UIColor = .gray300
    var deselectLineHeight: CGFloat = 2.0 {
        didSet {
            underlineHeightConstraint?.update(offset: deselectLineHeight)
        }
    }
    
    var textAliment: NSTextAlignment = .center
    var underlineHeightConstraint: Constraint?
    var isSelected: Bool = false
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabView {
    func setUI() {
        [tabLabel, underlineView].forEach {
            addSubview($0)
        }
        
        tabLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            if true == isSelected {
                underlineHeightConstraint = $0.height.equalTo(selectLineHeight).constraint
            } else {
                underlineHeightConstraint = $0.height.equalTo(deselectLineHeight).constraint
            }
            
        }
    }
    
    @objc private func handleTap() {
        delegate?.tabViewDidSelect(self)
    }
    
    func selectedTab(selectTextColor: UIColor, selectFont: UIFont, selectLineColor: UIColor, selectLineHeight: CGFloat) {
        tabLabel.textColor = selectTextColor
        underlineView.backgroundColor = selectLineColor
        underlineHeightConstraint?.update(offset: selectLineHeight)
        self.selectLineHeight = selectLineHeight
        setNeedsLayout()
    }
    
    func deselectedTab(deselectTextColor: UIColor, deselectFont: UIFont, deselectLineColor: UIColor, deselectLineHeight: CGFloat) {
        tabLabel.textColor = deselectTextColor
        underlineView.backgroundColor = deselectLineColor
        underlineHeightConstraint?.update(offset: deselectLineHeight)
        self.deselectLineHeight = deselectLineHeight
    }
}
