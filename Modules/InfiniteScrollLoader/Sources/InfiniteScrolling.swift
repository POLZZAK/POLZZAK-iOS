//
//  InfiniteScrolling.swift
//  InfiniteScrollLoader
//
//  Created by 이정환 on 10/9/23.
//

import UIKit

public protocol InfiniteScrolling: AnyObject {
    associatedtype InfiniteScrollingViewModelType: InfiniteScrollingViewModel
    var viewModel: InfiniteScrollingViewModelType { get set }
    
    func scrollViewDidReachEnd(_ scrollView: UIScrollView)
}

extension InfiniteScrolling where Self: UIViewController, Self: UIScrollViewDelegate {
    public func scrollViewDidReachEnd(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY >= contentHeight - frameHeight + 100 {
            viewModel.rechedBottomSubject.send(true)
        }
    }
}

