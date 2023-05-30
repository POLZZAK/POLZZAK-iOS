//
//  EmptyCell.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/05/29.
//

import UIKit
import SnapKit

class EmptyCell: UICollectionViewCell {
    static let reuseIdentifier = "EmptyCell"
    private let placeHoldText = "완료된 도장판이 없어요"
    private let nickNamePlaceHoldText = "님은 아직\n완료된 도장판이 없어요"
    private let width = UIScreen.main.bounds.width * 60.0 / 375.0
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .sittingCharacter
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let placeHoldLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        removeDashedBorder()
    }
}

extension EmptyCell {
    private func setUI() {
        setCustomView(backgroundColor: .white, cornerRadius: 8)
        addDashedBorder(borderColor: .gray300, spacing: 3, cornerRadius: 8)
        
        [imageView, placeHoldLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(width)
        }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(93)
            $0.trailing.equalTo(-93)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(nickName: String = "") {
        placeHoldLabel.setLabelForRange(
            text: nickName, textFont: .body5, textColor: .gray700,
            rest: nickName == "" ? placeHoldText : nickNamePlaceHoldText, restFont: .body3, restColor: .gray700,
            textAlignment: .center)
    }
}