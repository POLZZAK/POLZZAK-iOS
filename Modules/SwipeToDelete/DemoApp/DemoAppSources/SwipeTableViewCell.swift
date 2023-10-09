//
//  SwipeTableViewCell.swift
//  SwipeToDeleteDemoApp
//
//  Created by 이정환 on 10/9/23.
//

import UIKit

import SwipeToDelete

final class SwipeTableViewCell: SwipeableTableViewCell {
    static let reuseIdentifier = "SwipeTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "TableViewCell"
        return label
    }()
    
    private let subView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [subView, titleLabel].forEach {
            panGestureView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func configure(color: UIColor) {
        subView.backgroundColor = color
    }
}
