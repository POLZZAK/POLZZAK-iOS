//
//  MissionExampleSelectingViewModel.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 10/23/23.
//

import Combine
import Foundation

import Toast

final class MissionExampleSelectingViewModel {
    private var cancellables: Set<AnyCancellable> = .init()
    
    private let missionCountUserCanAdd: Int
    private let missionExamples = Constants.Text.missionExamples
    private lazy var cellViewModels: [MissionExampleCellViewModel] = missionExamples.map { MissionExampleCellViewModel(missionExample: $0, missionCountUserCanAdd: missionCountUserCanAdd, addedMission: addedMission) }
    
    private let addedMission = CurrentValueSubject<[MissionExample], Never>([])
    
    init(missionCountUserCanAdd: Int) {
        self.missionCountUserCanAdd = missionCountUserCanAdd
    }
    
    func getSelectedMissionExamples() -> [String] {
        return addedMission.value.map { $0.missionExample }
    }
    
    func getCellViewModel(index: Int) -> MissionExampleCellViewModel {
        return cellViewModels[index]
    }
    
    func numberOfItems() -> Int {
        return cellViewModels.count
    }
}

final class MissionExampleCellViewModel {
    private var cancellables: Set<AnyCancellable> = .init()
    
    let missionExample: MissionExample
    @Published var isSelected: Bool = false
    let userDidTapCell = PassthroughSubject<Void, Never>()
    
    private let toast = Toast(type: .error("미션은 총 50개까지 등록할 수 있어요", nil))
    
    init(missionExample: String, missionCountUserCanAdd: Int, addedMission: CurrentValueSubject<[MissionExample], Never>) {
        self.missionExample = MissionExample(missionExample: missionExample)
        
        userDidTapCell
            .sink { [weak self] in
                guard let self else { return }
                let canAddMoreMission = missionCountUserCanAdd > addedMission.value.count
                
                if !isSelected && !canAddMoreMission {
                    toast.show()
                    return
                }
                
                if !isSelected {
                    addedMission.value.append(self.missionExample)
                } else {
                    addedMission.value.removeAll(where: { $0.id == self.missionExample.id })
                }
                
                isSelected.toggle()
            }
            .store(in: &cancellables)
    }
}

struct MissionExample {
    let missionExample: String
    let id = UUID()
}
