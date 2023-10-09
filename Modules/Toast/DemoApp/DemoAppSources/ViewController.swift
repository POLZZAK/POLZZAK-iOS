//
//  ViewController.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import UIKit

import Toast

final class ViewController: UIViewController {
    
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
        
        let stackView = UIStackView(arrangedSubviews: [successButton, errorButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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
