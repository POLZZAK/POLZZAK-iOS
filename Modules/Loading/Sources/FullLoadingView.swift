//
//  FullLoadingView.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/14.
//

import UIKit

import SnapKit

public final class FullLoadingView: UIView {
    private let loadingView = LoadingView()
    
    public init(frame: CGRect = .zero, backgroundColor: UIColor = .black.withAlphaComponent(0.4)) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
            
        if self.window != nil && false == isHidden {
            loadingView.startRotating()
        } else {
            loadingView.stopRotating()
        }
    }
    
    private func setupView() {
        isHidden = true
        
        addSubview(loadingView)
        
        loadingView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    public func startLoading() {
        isHidden = false
        loadingView.startRotating()
    }
    
    public func stopLoading() {
        isHidden = true
        loadingView.stopRotating()
    }
}
