//
//  InfiniteScrollingViewModel.swift
//  InfiniteScrollLoader
//
//  Created by 이정환 on 10/9/23.
//

import Combine
import Foundation

public protocol InfiniteScrollingViewModel: AnyObject {
    var rechedBottomSubject: CurrentValueSubject<Bool, Never> { get }
    func setupBottomRefreshBindings()
}

extension InfiniteScrollingViewModel {
    public func resetBottomRefreshSubjects() {
        self.rechedBottomSubject.send(false)
    }
}
