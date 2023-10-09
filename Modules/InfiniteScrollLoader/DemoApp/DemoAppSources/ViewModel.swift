//
//  ViewModel.swift
//  InfiniteScrollLoaderDemoApp
//
//  Created by 이정환 on 10/9/23.
//

import Combine
import UIKit

import InfiniteScrollLoader
import SharedResources

final class ViewModel: InfiniteScrollingViewModel {
    var cancellables = Set<AnyCancellable>()
    
    var rechedBottomSubject = CurrentValueSubject<Bool, Never>(false)
    var didEndDraggingSubject = PassthroughSubject<Bool, Never>()
    
    @Published var data: [UIColor] = [UIColor](repeating: UIColor.rainbow, count: 10)
    
    init() {
        setupBottomRefreshBindings()
    }
}

extension ViewModel {
    func setupBottomRefreshBindings() {
        rechedBottomSubject
            .filter { $0 }
            .sink { [weak self] _ in
                self?.loadMoreData()
            }
            .store(in: &cancellables)
    }
    
    func loadMoreData() {
        Task {
            data = await fetchData()
        }
    }
    
    private func fetchData() async -> [UIColor] {
        return data + [UIColor](repeating: UIColor.rainbow, count: 10)
    }
}

