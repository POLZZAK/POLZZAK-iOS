//
//  MissonAddButtonCell.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/09/16.
//

import UIKit

import SnapKit

class MissonAddButtonCell: UICollectionViewCell {
    static let reuseIdentifier = "MissonAddButtonCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let missonAddButton: UIButton = {
        let button = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("+ 미션 추가하기", attributes: .init([
            .font: UIFont.body14Md,
            .foregroundColor: UIColor.gray400
        ]))
        button.configuration = config
//        button.layer.borderColor = UIColor.gray300.cgColor
//        button.layer.borderWidth = 1
//        button.layer.cornerRadius = 8
        button.backgroundColor = .green
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MissonAddButtonCell {
    private func configureView() {
        deleteButton.alpha = 0
    }
    
    private func configureLayout() {
        [missonAddButton, deleteButton].forEach {
            contentView.addSubview($0)
        }
        
        missonAddButton.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.height.equalTo(45).priority(.init(999))
        }
        
        missonAddButton.addLineDashedStroke(pattern: [2, 2], radius: 8, color: UIColor.gray.cgColor)
        self.layoutIfNeeded()
        
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(missonAddButton.snp.trailing)
            make.height.equalTo(45)
            make.width.equalTo(36)
        }
        
        deleteButton.setContentHuggingPriority(.init(1001), for: .horizontal)
        deleteButton.setContentCompressionResistancePriority(.init(1001), for: .horizontal)
    }
}

extension UIView {
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) {
//        let borderLayer = CAShapeLayer()
//
//        borderLayer.strokeColor = color
//        borderLayer.lineDashPattern = pattern
//        borderLayer.frame = bounds
//        borderLayer.fillColor = nil
//        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
//
//        layer.addSublayer(borderLayer)
        
        let layer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 8)
        layer.path = path.cgPath;
        layer.strokeColor = UIColor.red.cgColor;
        layer.lineDashPattern = [3,3];
        layer.backgroundColor = UIColor.clear.cgColor;
        layer.fillColor = UIColor.clear.cgColor;
        self.layer.addSublayer(layer);
    }
}
