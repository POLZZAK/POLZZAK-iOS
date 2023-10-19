//
//  MissonAddTextFieldCell.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/09/16.
//

import Combine
import UIKit

import SnapKit

protocol MissonAddTextFieldCellDelegate: AnyObject {
    func didUpdateHeight(add height: CGFloat)
}

class MissonAddTextFieldCell: UICollectionViewCell {
    static let reuseIdentifier = "MissonAddTextFieldCell"
    
    private var cancellables = Set<AnyCancellable>()
    private var cancellablesForReuse = Set<AnyCancellable>()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let textCheckView = TextCheckView(type: .mission)
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "misson_delete_image")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20)
        button.configuration = config
        return button
    }()
    
    private var cellHeightConstraint: Constraint?
    weak var cellHeightUpdateDelegate: MissonAddTextFieldCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
        configureBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellablesForReuse = .init()
    }
    
    func bindTextField(action: @escaping (String?) -> Void) {
        textCheckView.textFieldTextPublisher
            .sink { text in
                action(text)
            }
            .store(in: &cancellablesForReuse)
    }
    
    func bindDeleteButton(action: @escaping () -> Void) {
        deleteButton.tapPublisher
            .sink {
                action()
            }
            .store(in: &cancellablesForReuse)
    }
    
    func configureTextField(text: String?) {
        textCheckView.text = text
    }
}

extension MissonAddTextFieldCell {
    enum Constants {
        static let activeHeight: CGFloat = 70
        static let inactiveHeight: CGFloat = 50
    }
    
    private func configureView() {
        
    }
    
    private func configureBinding() {
        textCheckView.textFieldFirstResponderChanged
            .sink { [weak self] event in
                switch event {
                case .become:
                    self?.updateHeight(Constants.activeHeight)
                    self?.cellHeightUpdateDelegate?.didUpdateHeight(add: 20)
                case .resign:
                    self?.updateHeight(Constants.inactiveHeight)
                    self?.cellHeightUpdateDelegate?.didUpdateHeight(add: 0)
                }
            }
            .store(in: &cancellables)
    }
    
    private func configureLayout() {
        [textCheckView, deleteButton].forEach {
            contentView.addSubview($0)
        }
        
        textCheckView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            cellHeightConstraint = make.height.equalTo(Constants.inactiveHeight).priority(.init(999)).constraint
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(textCheckView.snp.trailing)
            make.height.equalTo(45)
            make.width.equalTo(36)
        }
        
        deleteButton.setContentHuggingPriority(.init(1001), for: .horizontal)
        deleteButton.setContentCompressionResistancePriority(.init(1001), for: .horizontal)
    }
    
    private func updateHeight(_ height: CGFloat) {
        cellHeightConstraint?.deactivate()
        textCheckView.snp.makeConstraints { make in
            cellHeightConstraint = make.height.equalTo(height).priority(.init(999)).constraint
        }
    }
}
