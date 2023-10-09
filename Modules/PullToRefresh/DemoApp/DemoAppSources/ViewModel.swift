//
//  ViewModel.swift
//  PullToRefreshDemoApp
//
//  Created by 이정환 on 10/6/23.
//

import Combine
import UIKit

import PullToRefresh

final class ViewModel: PullToRefreshProtocol {
    enum Constants {
        static let sleepTime = 1
    }
    var cancellables = Set<AnyCancellable>()
    var isApiFinishedLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    var didEndDraggingSubject = PassthroughSubject<Bool, Never>()
    var shouldEndRefreshing = PassthroughSubject<Void, Never>()
    
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
            
            isApiFinishedLoadingSubject.send(false)
            data = await fetchData()
        }
    }
    
    func fetchData() async -> [UIColor] {
        try? await Task.sleep(nanoseconds: UInt64(Constants.sleepTime) * 1_000_000_000)
        return [UIColor](repeating: UIColor.rainbow, count: 20)
    }
}
