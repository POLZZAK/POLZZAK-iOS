//
//  MissionExampleSelectingViewController.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 10/21/23.
//

import Combine
import UIKit

import CombineCocoa
import PanModal
import SnapKit

final class MissionExampleSelectingViewController: UIViewController, PanModalPresentable {
    private enum Constants {
        static let basicInset: CGFloat = 16
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let missionExamples = POLZZAK.Constants.Text.missionExamples
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray800
        label.font = .subtitle16Sbd
        return label
    }()
    
    private let missionExampleListView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
    
    private let addButton: UIButton = {
        let button = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.attributedTitle = .init("추가하기", attributes: .init([
            .font: UIFont.subtitle16Sbd,
            .foregroundColor: UIColor.white
        ]))
        button.layer.cornerRadius = 8
        button.configuration = config
        button.configurationUpdateHandler = { button in
            switch button.state {
            case .disabled:
                button.configuration?.background.backgroundColor = .blue200
            default:
                button.configuration?.background.backgroundColor = .blue500
            }
        }
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        titleLabel.text = "마음에 드는 미션들을 추가해보세요!"
        missionExampleListView.dataSource = self
        missionExampleListView.delegate = self
        missionExampleListView.allowsSelection = false
        missionExampleListView.register(StampAllowCell.self, forCellWithReuseIdentifier: StampAllowCell.reuseIdentifier)
    }
    
    private func configureLayout() {
        [titleLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        [labelStackView, missionExampleListView, addButton].forEach {
            view.addSubview($0)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        missionExampleListView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(Constants.basicInset)
            make.bottom.equalTo(addButton.snp.top).offset(-20)
        }
        
        addButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.basicInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - PanModalPresentable
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(UIApplication.shared.height * 0.85)
    }
    
    var dragIndicatorBackgroundColor: UIColor {
        return .gray200
    }
}

// MARK: - UICollectionViewDataSource

extension MissionExampleSelectingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missionExamples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StampAllowCell.reuseIdentifier, for: indexPath) as? StampAllowCell else {
            fatalError("StampAllowCell dequeue failed")
        }
        let text = missionExamples[indexPath.item]
        cell.configureTitleLabel(text: text)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MissionExampleSelectingViewController: UICollectionViewDelegate {
    
}

// MARK: - Layout

extension MissionExampleSelectingViewController {
    static func getLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}
