//
//  MissionAddView.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/09/16.
//

import UIKit

protocol MissionAddViewDelegate: AnyObject {
    func didUpdateHeight(add height: CGFloat)
}

final class MissionAddView: UICollectionView {
    private var missionList: [String?] = [nil, nil, nil]
    
    weak var heightUpdateDelegate: MissionAddViewDelegate?
    
    init() {
        let layout = MissionAddView.getLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        register(MissonAddTextFieldCell.self, forCellWithReuseIdentifier: MissonAddTextFieldCell.reuseIdentifier)
        register(MissonAddButtonCell.self, forCellWithReuseIdentifier: MissonAddButtonCell.reuseIdentifier)
        register(MissionExampleButtonCell.self, forCellWithReuseIdentifier: MissionExampleButtonCell.reuseIdentifier)
        dataSource = self
    }
    
    private func configureLayout() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray200.cgColor
    }
}

// MARK: - UICollectionViewDataSource

extension MissionAddView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return missionList.count
        case 1...2:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MissonAddTextFieldCell.reuseIdentifier, for: indexPath) as? MissonAddTextFieldCell else { fatalError("Couldn't dequeue MissonAddTextFieldCell") }
            cell.configureTextField(text: missionList[indexPath.item])
            cell.cellHeightUpdateDelegate = self
            cell.bindTextField { [weak self] text in
                print(indexPath.item)
                guard let self, indexPath.item < missionList.count else { return }
                missionList[indexPath.item] = text
            }
            cell.bindDeleteButton { [weak self] in
                guard let self else { return }
                performBatchUpdates {
                    guard let indexPath = collectionView.indexPath(for: cell) else { return }
                    self.missionList.remove(at: indexPath.item)
                    self.deleteItems(at: [indexPath])
                }
                heightUpdateDelegate?.didUpdateHeight(add: 0)
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MissonAddButtonCell.reuseIdentifier, for: indexPath) as? MissonAddButtonCell else { fatalError("Couldn't dequeue MissonAddButtonCell") }
            cell.bindAddButton { [weak self] in
                guard let self else { return }
                performBatchUpdates {
                    self.missionList.append(nil)
                    let indexPath = IndexPath(item: self.missionList.count - 1, section: 0)
                    self.insertItems(at: [indexPath])
                }
                heightUpdateDelegate?.didUpdateHeight(add: 0)
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MissionExampleButtonCell.reuseIdentifier, for: indexPath) as? MissionExampleButtonCell else { fatalError("Couldn't dequeue MissionExampleButtonCell") }
            
            return cell
        default:
            fatalError("")
        }
    }
}

// MARK: - MissonAddTextFieldCellDelegate

extension MissionAddView: MissonAddTextFieldCellDelegate {
    func didUpdateHeight(add height: CGFloat) {
        performBatchUpdates {
            self.collectionViewLayout.invalidateLayout()
            self.heightUpdateDelegate?.didUpdateHeight(add: height)
        }
    }
}

// MARK: - Layout

extension MissionAddView {
    static func getLayout() -> UICollectionViewLayout {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50.0)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
