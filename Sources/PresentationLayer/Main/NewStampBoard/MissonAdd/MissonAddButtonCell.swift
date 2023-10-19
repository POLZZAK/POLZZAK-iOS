//
//  MissonAddButtonCell.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/09/16.
//

import Combine
import UIKit

import CombineCocoa
import SnapKit

class MissonAddButtonCell: UICollectionViewCell {
    static let reuseIdentifier = "MissonAddButtonCell"
    
    private var cancellablesForReuse = Set<AnyCancellable>()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let missionAddButton: UIButton = {
        let button = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("+ 미션 추가하기", attributes: .init([
            .font: UIFont.body14Md,
            .foregroundColor: UIColor.gray400
        ]))
        button.configuration = config
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellablesForReuse = .init()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        missionAddButton.addLineDashedStroke(pattern: [5, 4], radius: 8, color: UIColor.gray300.cgColor)
    }
    
    func bindAddButton(action: @escaping () -> Void) {
        missionAddButton.tapPublisher
            .sink {
                action()
            }
            .store(in: &cancellablesForReuse)
    }
}

extension MissonAddButtonCell {
    private func configureView() {
        deleteButton.alpha = 0
    }
    
    private func configureLayout() {
        [missionAddButton, deleteButton].forEach {
            contentView.addSubview($0)
        }
        
        missionAddButton.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.height.equalTo(45).priority(.init(999))
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(missionAddButton.snp.trailing)
            make.height.equalTo(45)
            make.width.equalTo(36)
        }
        
        deleteButton.setContentHuggingPriority(.init(1001), for: .horizontal)
        deleteButton.setContentCompressionResistancePriority(.init(1001), for: .horizontal)
    }
}

fileprivate extension UIView {
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) {
        layoutIfNeeded()
        
        let borderLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 8)
        borderLayer.path = path.cgPath
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        
        layer.addSublayer(borderLayer)
    }
}
