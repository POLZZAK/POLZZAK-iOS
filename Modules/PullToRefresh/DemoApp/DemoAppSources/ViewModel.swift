//
//  ViewModel.swift
//  PullToRefreshDemoApp
//
//  Created by 이정환 on 10/6/23.
//

import UIKit
import Combine
import PullToRefresh

final class ViewModel: PullToRefreshProtocol {
    var cancellables = Set<AnyCancellable>()
    var isApiFinishedLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    var didEndDraggingSubject = PassthroughSubject<Bool, Never>()
    var shouldEndRefreshing = PassthroughSubject<Bool, Never>()
    
    @Published var data: [UIColor] = [UIColor](repeating: UIColor.rainbow, count: 20)
    
    init() {
        setupPullToRefreshBinding()
    }
} 

extension ViewModel {
    func refreshData() {
        Task {
            defer {
                isApiFinishedLoadingSubject.send(true)
            }
            
            data = await fetchData()
        }
    }
    
    func fetchData() async -> [UIColor] {
        return [UIColor](repeating: UIColor.rainbow, count: 20)
    }
}
