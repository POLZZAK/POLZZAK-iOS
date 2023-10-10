//
//  ViewController.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import UIKit

import Toast

final class ViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var successButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Success Toast", for: .normal)
        button.addTarget(self, action: #selector(showSuccessToast), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Error Toast", for: .normal)
        button.addTarget(self, action: #selector(showErrorToast), for: .touchUpInside)
        return button
    }()
    
    private var toast: Toast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [successButton, errorButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func showSuccessToast() {
        toast = Toast(type: .success("Success Toast"))
        toast?.show()
    }
    
    @objc private func showErrorToast() {
        toast = Toast(type: .error("Error Toast"))
        toast?.show()
    }
}
