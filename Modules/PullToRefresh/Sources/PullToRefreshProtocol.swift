//
//  PullToRefreshProtocol.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/13.
//

import Combine
import Foundation

public protocol PullToRefreshProtocol: AnyObject {
    var isApiFinishedLoadingSubject: CurrentValueSubject<Bool, Never> { get }
    var didEndDraggingSubject: PassthroughSubject<Bool, Never> { get }
    var shouldEndRefreshing: PassthroughSubject<Void, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
    func setupPullToRefreshBinding()
    func resetPullToRefreshSubjects()
}

extension PullToRefreshProtocol {
    public func setupPullToRefreshBinding() {
        
        didEndDraggingSubject.combineLatest(isApiFinishedLoadingSubject)
            .filter {$0 == true && $1 == true}
            .map { _, apiFinished -> Bool in
                return apiFinished
            }
            .filter { $0 }
            .sink { [weak self] apiFinished in
                self?.shouldEndRefreshing.send()
            }
            .store(in: &cancellables)
    }
    
    public func resetPullToRefreshSubjects() {
        self.didEndDraggingSubject.send(false)
        self.isApiFinishedLoadingSubject.send(true)
    }
}
