//
//  NewStampBoardHeaderView.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 9/30/23.
//

import UIKit

import SnapKit

final class NewStampBoardHeaderView: UIView {
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .caption12Md
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .gray800
        label.text = "해린해린"
        return label
    }()
    
    private let balloonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "new_stamp_board_needs_stamp")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "new_stamp_board_refresh_image")
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [userImageView, usernameLabel, balloonImageView, refreshButton].forEach {
            addSubview($0)
        }
        
        let userImageViewHeight: CGFloat = 60
        
        userImageView.layer.cornerRadius = userImageViewHeight/2
        
        userImageView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.height.equalTo(userImageViewHeight)
        }
        
        let usernameLabelHeight: CGFloat = 25
        
        usernameLabel.layer.cornerRadius = usernameLabelHeight/2
        usernameLabel.clipsToBounds = true
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.centerX).offset(10)
            make.bottom.equalTo(userImageView)
            make.width.equalTo(58)
            make.height.equalTo(usernameLabelHeight)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.trailing).offset(8)
            make.centerY.equalTo(usernameLabel)
            make.width.height.equalTo(16)
        }
        
        balloonImageView.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(3)
            make.bottom.equalTo(usernameLabel.snp.top).offset(-8)
            make.width.equalTo(179)
            make.height.equalTo(42)
            make.top.equalToSuperview()
        }
    }
    
    func setNameLabel(text: String?) {
        usernameLabel.text = text
    }
    
    func setImage(image: UIImage?) {
        userImageView.image = image
    }
}
