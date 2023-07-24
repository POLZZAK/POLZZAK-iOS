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
        label.textColor = .gray700
        label.font = .body3
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        removeDashedBorder()
    }
}

extension EmptyCell {
    private func setUI() {
        backgroundColor = .white
        addBorder(cornerRadius: 8)
        addDashedBorder(borderColor: .gray300, spacing: 3, cornerRadius: 8)
        
        [imageView, placeHoldLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(width)
        }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(93)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(nickName: String) {
        placeHoldLabel.text = "\(nickName)님은 아직\n완료된 도장판이 없어요"
        let emphasisRang = [NSRange(location: 0, length: nickName.count)]
        placeHoldLabel.setEmphasisRanges(emphasisRang, color: .gray700, font: .body5)
    }
}
