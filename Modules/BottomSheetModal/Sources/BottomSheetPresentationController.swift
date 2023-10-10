//
//  BottomSheetPresentationController.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/16.
//

import UIKit

final class BottomSheetPresentationController: UIPresentationController {
    private let initialState: BottomSheetState
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.isOpaque = false
        return view
    }()
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, initialState: BottomSheetState) {
        self.initialState = initialState
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        return CGRect(x: 0, y: initialState.position, width: containerView.bounds.width, height: initialState.height)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        dimmingView = UIView(frame: containerView.bounds)
        containerView.addSubview(dimmingView)
        if let presentedView {
            containerView.addSubview(presentedView)
        }
        
        let coordinator = presentingViewController.transitionCoordinator
        coordinator?.animate(alongsideTransition: { [weak self] context in
            self?.dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        })
    }
    
    override func dismissalTransitionWillBegin() {
        let coordinator = presentingViewController.transitionCoordinator
        coordinator?.animate(alongsideTransition: { [weak self] context in
            self?.dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0)
        })
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
}
