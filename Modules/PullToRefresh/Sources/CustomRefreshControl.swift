//
//  CustomRefreshControl.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/05/21.
//

import UIKit
import SnapKit
import SharedResources

public class CustomRefreshControl: UIRefreshControl {
    public var initialContentOffsetY: Double = 0.0
    private var refreshImageViewTopConstraint: Constraint?
    private var refreshIndicatorTopConstraint: Constraint?
    
    private var observation: NSKeyValueObservation?
    
    public let refreshImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 1.0
        imageView.image = .refreshDragImage
        return imageView
    }()
    
    public let refreshIndicator: UIActivityIndicatorView = {
        let refreshIndicator = UIActivityIndicatorView(style: .large)
        refreshIndicator.color = .blue400
        refreshIndicator.hidesWhenStopped = true
        refreshIndicator.isHidden = true
        refreshIndicator.stopAnimating()
        return refreshIndicator
    }()
    
    public init(topPadding: CGFloat = 0.0) {
        super.init()
        
        setupUI(topPadding: -topPadding)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        observation?.invalidate()
    }
    
    public override func beginRefreshing() {
        refreshImageView.alpha = 0
        refreshIndicator.startAnimating()
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
    }
}

extension CustomRefreshControl {
    private func setupUI(topPadding: CGFloat) {
        tintColor = .clear
        
        initialContentOffsetY = topPadding
        
        [refreshImageView, refreshIndicator].forEach {
            addSubview($0)
        }
        
        refreshImageView.snp.makeConstraints {
            refreshImageViewTopConstraint = $0.centerY.equalToSuperview().offset(topPadding).constraint
            $0.centerX.equalToSuperview()
        }
        
        refreshIndicator.snp.makeConstraints {
            refreshIndicatorTopConstraint = $0.centerY.equalToSuperview().offset(topPadding).constraint
            $0.centerX.equalToSuperview()
        }
    }
    
    public func observe(scrollView: UIScrollView) {
        observation = scrollView.observe(\.contentOffset, options: .new) { [weak self] scrollView, _ in
            guard let self = self else { return }
            
            let yOffset = scrollView.contentOffset.y
            if yOffset <= initialContentOffsetY {
                self.refreshImageView.transform = CGAffineTransform(translationX: 0, y: -yOffset/3)
                self.refreshIndicator.transform = CGAffineTransform(translationX: 0, y: -yOffset/3)
            } else {
                self.refreshImageView.transform = .identity
                self.refreshIndicator.transform = .identity
            }
        }
    }
    
    public func updateTopPadding(to newValue: CGFloat) {
        refreshImageViewTopConstraint?.update(offset: newValue)
        refreshIndicatorTopConstraint?.update(offset: newValue)
    }
    
    public func resetRefreshControl() {
        refreshImageView.alpha = 1
        refreshIndicator.stopAnimating()
    }
}
