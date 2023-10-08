//
//  BaseAlertViewController.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/08/19.
//

import UIKit

import Extension
import SnapKit

open class BaseAlertViewController: UIViewController {
    enum Constants {
        static let alertWidth = UIApplication.shared.width * 343.0 / 375.0
    }
    
    public var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overCurrentContext
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(Constants.alertWidth)
        }
    }
}

