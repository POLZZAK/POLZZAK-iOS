//
//  MissionExampleSelectingCell.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 10/23/23.
//

import Combine
import UIKit

import CombineCocoa

final class MissionExampleSelectingCell: StampAllowCell {
    override var reuseIdentifier: String? {
        return "MissionExampleSelectingCell"
    }
    
    private var cancellables: Set<AnyCancellable> = .init()
    private let tapGesture = UITapGestureRecognizer(target: nil, action: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables = .init()
    }
    
    private func configureView() {
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    func configure(from cellViewModel: MissionExampleCellViewModel) {
        configureTitleLabel(text: cellViewModel.missionExample.missionExample)
        
        cellViewModel.$isSelected
            .sink { [weak self] isSelected in
                guard let self else { return }
                if isSelected {
                    selectCell()
                } else {
                    deselectCell()
                }
            }
            .store(in: &cancellables)
        
        tapGesture.tapPublisher
            .sink { _ in
                cellViewModel.userDidTapCell.send(())
            }
            .store(in: &cancellables)
    }
}

