//
//  RegisterUserTypeViewController.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/06/29.
//

import Combine
import UIKit

import CombineCocoa
import SnapKit

class RegisterUserTypeViewController: UIViewController {
    enum Constants {
        static let basicInset: CGFloat = 16
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let descriptionLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray800
        label.font = .title22Bd
        label.text = "어떤 회원으로 활동하시겠어요?"
        return label
    }()
    
    private let descriptionLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray600
        label.font = .body15Md
        label.text = "나중에 변경이 불가하니 신중하게 선택해 주세요"
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let parentButton = UserTypeSelectButton(userType: .parent)
    private let childButton = UserTypeSelectButton(userType: .child)
    
    private let nextButton: RegisterNextButton = {
        let nextButton = RegisterNextButton()
        nextButton.isEnabled = false
        return nextButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureView()
        configureBinding()
    }
    
    private func configureLayout() {
        [labelStackView, buttonStackView, nextButton].forEach {
            view.addSubview($0)
        }
        
        [descriptionLabel1, descriptionLabel2].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        [parentButton, childButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview().inset(Constants.basicInset)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-89)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(Constants.basicInset)
            make.height.equalTo(230)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.basicInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.basicInset)
            make.height.equalTo(50)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .gray100
    }
    
    private func configureBinding() {
        parentButton.tapPublisher
            .sink { [weak self] _ in
                self?.determineButtonSelection(parentButtonSelected: true)
            }
            .store(in: &cancellables)
        
        childButton.tapPublisher
            .sink { [weak self] _ in
                self?.determineButtonSelection(parentButtonSelected: false)
            }
            .store(in: &cancellables)
        
        parentButton.tapPublisher.merge(with: childButton.tapPublisher)
            .sink { [weak self] _ in
                guard let self else { return }
                self.nextButton.isEnabled = self.parentButton.isSelected || self.childButton.isSelected
            }
            .store(in: &cancellables)
        
        nextButton.tapPublisher
            .sink { [weak self] _ in
                guard let self else { return }
                if self.parentButton.isSelected {
                    self.navigationController?.pushViewController(RegisterParentTypeViewController(), animated: true)
                } else if self.childButton.isSelected {
                    self.navigationController?.pushViewController(RegisterNicknameViewController(), animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    private func determineButtonSelection(parentButtonSelected: Bool) {
        parentButton.isSelected = parentButtonSelected
        childButton.isSelected = !parentButtonSelected
    }
}
