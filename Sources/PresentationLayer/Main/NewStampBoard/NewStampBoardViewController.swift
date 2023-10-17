//
//  NewStampBoardViewController.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/09/15.
//

import Combine
import UIKit

import CombineCocoa
import SnapKit

final class NewStampBoardViewController: UIViewController {
    enum Constants {
        static let missionAddViewTopInset: CGFloat = 20
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let doneButton = UIBarButtonItem(title: "등록")
    private let cancelButton = UIBarButtonItem(image: UIImage(named: "new_stamp_board_arrow_back"))
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let headerView = NewStampBoardHeaderView()
    private let nameTextCheckView = TextCheckView(type: .stampBoardName)
    private let compensationTextCheckView = TextCheckView(type: .compensation)
    private let stampSizeSelectionView = StampSizeSelectionView()
    private let missionAddView = MissionAddView()
    
    private var isLayoutConfigured = false
    private var missionAddViewHeightConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
        configureBinding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isLayoutConfigured {
            updateMissionAddViewHeight()
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        stampSizeSelectionView.alwaysBounceVertical = false
        missionAddView.contentInset = .init(top: Constants.missionAddViewTopInset, left: 0, bottom: Constants.missionAddViewTopInset, right: 0)
        missionAddView.alwaysBounceVertical = false
        missionAddView.heightUpdateDelegate = self
    }
    
    private func configureLayout() {
        
        // MARK: -
        
        // FIXME: navigationBar
        let navigationBar = UINavigationBar()
        navigationBar.barTintColor = .white
        view.addSubview(navigationBar)

        let navigationItem = UINavigationItem(title: "도장판 생성")
        
        cancelButton.tintColor = .gray400
        
        navigationItem.leftBarButtonItem = cancelButton
        
        let doneButtonTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue500,
            .font: UIFont.subtitle16Sbd
        ]
        
        doneButton.setTitleTextAttributes(doneButtonTextAttributes, for: .normal)
        doneButton.setTitleTextAttributes(doneButtonTextAttributes, for: .highlighted)
        navigationItem.rightBarButtonItem = doneButton

        navigationBar.setItems([navigationItem], animated: false)
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        // MARK: -
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        // MARK: -
        
        scrollView.addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview().inset(16)
        }
        
        // MARK: -
        
        [headerView, nameTextCheckView, compensationTextCheckView, stampSizeSelectionView, missionAddView].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        nameTextCheckView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        compensationTextCheckView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        stampSizeSelectionView.snp.makeConstraints { make in
            make.height.equalTo(134)
        }
        
        missionAddView.snp.makeConstraints { make in
            missionAddViewHeightConstraint = make.height.equalTo(300).constraint
        }
        
        // MARK: -
        
        contentStackView.setCustomSpacing(32, after: headerView)
        
        // MARK: -
        
        isLayoutConfigured = true
    }
    
    private func configureBinding() {
        cancelButton.tapPublisher
            .sink { [weak self] in
                self?.dismiss(animated: true)
            }
            .store(in: &cancellables)
        
        doneButton.tapPublisher
            .sink { [weak self] in
                self?.dismiss(animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func updateMissionAddViewHeight(add height: CGFloat = 0) {
        missionAddView.layoutIfNeeded()
        let missionAddViewHeight = missionAddView.collectionViewLayout.collectionViewContentSize.height
        missionAddViewHeightConstraint?.deactivate()
        missionAddView.snp.makeConstraints { make in
            missionAddViewHeightConstraint = make.height.equalTo(missionAddViewHeight+Constants.missionAddViewTopInset*2+height).constraint
        }
    }
}

extension NewStampBoardViewController: MissionAddViewDelegate {
    func didUpdateHeight(add height: CGFloat) {
        updateMissionAddViewHeight(add: height) // 20을 추가한 이유는 MissionAddTextFieldCell의 높이가 20만큼 늘어나기 때문이다.
    }
}
