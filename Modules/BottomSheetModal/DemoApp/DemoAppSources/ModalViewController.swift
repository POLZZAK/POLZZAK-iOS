//
//  ModalViewController.swift
//  BottomSheetModalDemoApp
//
//  Created by 이정환 on 10/9/23.
//

import UIKit

import BottomSheetModal
import Extension

class ModalViewController: BottomSheetViewController {

    enum Constants {
        static let demoText = "This is a bottom sheet."
        static let handleName = "Handle"
        static let statusBarHeight = UIApplication.shared.statusBarHeight
    }
    
    let demoLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.demoText
        label.textAlignment = .center
        label.accessibilityLabel = Constants.demoText
        label.accessibilityIdentifier = "\(Constants.statusBarHeight)"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(demoLabel)
        
        demoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        dragHandleView.accessibilityLabel = Constants.handleName
    }
}
