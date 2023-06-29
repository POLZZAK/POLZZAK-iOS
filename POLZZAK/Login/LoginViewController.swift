//
//  LoginViewController.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/06/27.
//

import UIKit

import SnapKit

class LoginViewController: UIViewController {
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let greetingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greeting")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionLabel1: UILabel = {
        let label = UILabel()
        label.font = .title4
        label.numberOfLines = 1
        label.text = "참 잘 했어요 도장 쾅!"
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel2: UILabel = {
        let label = UILabel()
        label.font = .body8
        label.textColor = .gray600
        label.numberOfLines = 2
        label.textAlignment = .center
        let fullText = "미션을 수행하고 칭찬 도장을 모으며\n폴짝 성장해요"
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "폴짝")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.blue600, range: range)
        label.attributedText = attribtuedString
        return label
    }()
    
    private let socialDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .gray700
        label.numberOfLines = 1
        label.text = "다음 소셜 계정으로 시작하기"
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 23
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    // TODO: 버튼 2개 다 configuration 써서 하도록 바꿔야 할듯
    
    private let kakaoLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "kakao_logo"), for: .normal)
        button.setImage(UIImage(named: "kakao_logo"), for: .highlighted)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    // TODO: apple 로고 리젝 안당할지 확인
    
    private let appleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        button.setImage(UIImage(named: "apple_logo"), for: .normal)
        button.setImage(UIImage(named: "apple_logo"), for: .highlighted)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        view.backgroundColor = .gray100
    }
    
    private func configureLayout() {
        view.addSubview(entireStackView)
        
        [greetingImageView, descriptionLabel1, descriptionLabel2, socialDescriptionLabel, buttonStackView].forEach {
            entireStackView.addArrangedSubview($0)
        }
        
        [kakaoLoginButton, appleLoginButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        entireStackView.setCustomSpacing(26, after: greetingImageView)
        entireStackView.setCustomSpacing(16, after: descriptionLabel1)
        entireStackView.setCustomSpacing(110, after: descriptionLabel2)
        entireStackView.setCustomSpacing(18, after: socialDescriptionLabel)
        
        entireStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        greetingImageView.snp.makeConstraints { make in
            make.width.equalTo(206)
            make.height.equalTo(199)
        }
        
        let buttonHeight: CGFloat = 60
        
        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonHeight)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonHeight)
        }
        
        kakaoLoginButton.layer.cornerRadius = buttonHeight/2
        appleLoginButton.layer.cornerRadius = buttonHeight/2
        
        kakaoLoginButton.clipsToBounds = true
        appleLoginButton.clipsToBounds = true
    }
}
