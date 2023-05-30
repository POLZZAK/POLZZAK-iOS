//
//  CompletedStampBoardCell.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/05/24.
//

import UIKit
import SnapKit

class CompletedStampBoardCell: UICollectionViewCell {
    static let reuseIdentifier = "CompletedStampBoardCell"
    
    private let stampNameLabel: UILabel = {
        let label = UILabel()
        label.setLabel(textColor: .blindTextColor, font: .title1)
        return label
    }()
    
    private let stampRewardView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    private let rewardLabelView: UIView = {
        let view = UIView()
        view.setCustomView(backgroundColor: .blue200.withAlphaComponent(0.6), cornerRadius: 4)
        return view
    }()
    
    private let rewardLabel: UILabel = {
        let label = UILabel()
        
        label.setLabel(text: "보상", textColor: .blue600, font: .caption1, textAlignment: .center)
        return label
    }()
    
    private let rewardTitleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(textColor: .blindTextColor, font: .body2)
        return label
    }()
    
    private let couponLabelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .couponCompleted
        return imageView
    }()
    
    private let blindView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CompletedStampBoardCell {
    func configure(with info: StampBoardSummary) {
        stampNameLabel.text = info.name
        rewardTitleLabel.text = info.reward
    }
    
    private func setUI() {
        setCustomView(cornerRadius: 8, borderWidth: 1, borderColor: .gray300)
        
        [rewardLabelView, rewardTitleLabel].forEach {
            stampRewardView.addArrangedSubview($0)
        }
        
        rewardLabelView.snp.makeConstraints {
            $0.width.equalTo(rewardLabelView.snp.height).multipliedBy(33.0/25.0)
        }
        
        [stampNameLabel, stampRewardView, blindView, couponLabelImageView].forEach {
            addSubview($0)
        }
        
        stampNameLabel.snp.makeConstraints {
            $0.top.equalTo(24)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
        }
        
        rewardLabelView.addSubview(rewardLabel)
        
        rewardLabel.snp.makeConstraints {
            $0.top.equalTo(4)
            $0.leading.equalTo(6)
            $0.trailing.equalTo(-6)
            $0.bottom.equalTo(-4)
        }
        
        stampRewardView.snp.makeConstraints {
            $0.top.equalTo(stampNameLabel.snp.bottom).offset(16)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
        }
        
        blindView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        couponLabelImageView.snp.makeConstraints {
            $0.top.equalTo(11)
            $0.trailing.equalTo(-16)
            $0.bottom.equalTo(-11)
        }
    }
}
 