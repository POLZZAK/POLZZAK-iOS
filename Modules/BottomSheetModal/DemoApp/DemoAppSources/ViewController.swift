//
//  ViewController.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import UIKit

import BottomSheetModal
import SnapKit

class ViewController: UIViewController {

    private let showBottomSheetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Bottom Sheet", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addAction()
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(showBottomSheetButton)
        
        showBottomSheetButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func addAction() {
        showBottomSheetButton.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
    }

    @objc func showBottomSheet() {
        let modalViewController = ModalViewController()
        modalViewController.modalPresentationStyle = .custom
        present(modalViewController, animated: true, completion: nil)
    }

}

