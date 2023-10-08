//
//  FullScreenLoadingView.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/06/22.
//

import UIKit
import SnapKit

public final class FullScreenLoadingView: UIView {
    private let loadingView = LoadingView()
    private var topConstraint: Constraint?
    public var topSpacing: CGFloat = 251 {
        didSet {
            topConstraint?.update(offset: topSpacing)
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        isHidden = true
        
        addSubview(loadingView)
        
        loadingView.snp.makeConstraints {
            topConstraint = $0.top.equalTo(topSpacing).constraint
            $0.centerX.equalToSuperview()
        }
    }
    
    public func startLoading() {
        isHidden = false
    }

    public func stopLoading() {
        isHidden = true
    }
}
