//
//  LoadingViewModelProtocol.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/27.
//

import Foundation
import Combine

public protocol LoadingViewModelProtocol: AnyObject {
    var isSkeleton: CurrentValueSubject<Bool, Never> { get }
    var isCenterLoading: CurrentValueSubject<Bool, Never> { get }
    
    func hideSkeletonView()
    func showLoading(for centerLoading: Bool)
    func hideLoading(for centerLoading: Bool)
}

extension LoadingViewModelProtocol {
    public func hideSkeletonView() {
        isSkeleton.send(false)
    }
    
    public func showLoading(for centerLoading: Bool = true) {
        if true == centerLoading {
            isCenterLoading.send(true)
        }
    }
    
    public func hideLoading(for centerLoading: Bool = true) {
        if isSkeleton.value == true {
            self.hideSkeletonView()
        } else if true == centerLoading {
            isCenterLoading.send(false)
        }
    }
}
