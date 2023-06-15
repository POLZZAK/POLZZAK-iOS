//
//  ReceivedTabCell.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/06/15.
//

import UIKit
import SnapKit

final class ReceivedTabCell: UITableViewCell {
    static let reuseIdentifier = "ReceivedTabCell"
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .defaultProfileCharacter
        imageView.contentMode = .scaleAspectFit
        imageView.setCustomView(cornerRadius: 16)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(textColor: .gray800, font: .body2)
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let acceptButton: UIButton = {
        let button = UIButton()
        let labelStyle = LabelStyle(title: "수락", titleColor: .white, font: .body2)
        let borderStyle = BorderStyle(cornerRadius: 6)
        button.setCustomButton(labelStyle: labelStyle, borderStyle: borderStyle, backgroundColor: .blue500)
        return button
    }()
    
    private let rejectButton: UIButton = {
        let button = UIButton()
        let labelStyle = LabelStyle(title: "거절", titleColor: .white, font: .body2)
        let borderStyle = BorderStyle(cornerRadius: 6)
        button.setCustomButton(labelStyle: labelStyle, borderStyle: borderStyle, backgroundColor: .error500)
        return button
    }()
    
    private let stampRewardView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func setUI() {
        [acceptButton, rejectButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        acceptButton.snp.makeConstraints {
            $0.width.equalTo(57)
        }
        
        rejectButton.snp.makeConstraints {
            $0.width.equalTo(57)
        }
        
        [profileImage, titleLabel, buttonStackView].forEach {
            addSubview($0)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(profileImage.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(18)
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(family: FamilyMember) {
        profileImage.loadImage(from: family.profileURL)
        titleLabel.text = family.nickname
    }
    
    private func reset() {
        profileImage.image = .defaultProfileCharacter
    }
}