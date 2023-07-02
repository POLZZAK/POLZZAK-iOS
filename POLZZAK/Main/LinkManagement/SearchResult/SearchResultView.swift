//
//  SearchResultView.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/06/21.
//

import UIKit
import SnapKit

protocol SearchResultViewDelegate: AnyObject {
    func linkRequest(nickName: String, memberId: Int)
    func linkRequestCancel(memberId: Int)
}

final class SearchResultView: UIView {
    private var imageViewSize: Constraint?
    weak var delegate: SearchResultViewDelegate?
    var familyMember: FamilyMember?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .defaultProfileCharacter
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let placeholder: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let button = PaddedLabel()
    
    var underLineButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setUnderlinedTitle(text: "앗 실수, 요청 취소 할래요", textColor: .gray500, font: .body9)
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    private func setUI() {
        isHidden = true
        backgroundColor = .white
        
        [imageView, placeholder, button, underLineButton].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(175)
            $0.centerX.equalToSuperview()
            self.imageViewSize = $0.width.height.equalTo(100).constraint
        }
        
        placeholder.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(placeholder.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        underLineButton.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setType(type: SearchResultState) {
        switch type {
        case .unlinked(let member):
            familyMember = member
            imageView.loadImage(from: member.profileURL)
            placeholder.setLabel(text: member.nickName, textColor: .black, font: .body5)
            button.setLabel(text: "연동요청", textColor: .white, font: .caption3, textAlignment: .center, backgroundColor: .blue500)
            button.addBorder(cornerRadius: 4)
            //TODO: - 패딩값이 고정이 아닌 이유가 피그마에는 13, 12, 13, 12로 표기되어있습니다. 그래서 설정이 되도록 만들었는데 육안상으로 13, 24, 13, 24가 맞는것같습니다...
            button.padding = UIEdgeInsets(top: 13, left: 24, bottom: 13, right: 24)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkRequest))
            button.isUserInteractionEnabled = true
            button.addGestureRecognizer(tapGesture)

        case .linked(let member):
            familyMember = member
            imageView.loadImage(from: member.profileURL)
            placeholder.setLabel(text: member.nickName, textColor: .black, font: .body5)
            button.setLabel(text: "이미 연동됐어요", textColor: .gray400, font: .caption3, textAlignment: .center)
            button.addBorder(cornerRadius: 4, borderWidth: 1, borderColor: .gray400)
            button.padding = UIEdgeInsets(top: 13, left: 24, bottom: 13, right: 24)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkRequest))
            button.isUserInteractionEnabled = true
            button.addGestureRecognizer(tapGesture)
        case .linkedRequestComplete(let member):
            familyMember = member
            imageView.loadImage(from: member.profileURL)
            button.setLabel(text: "연동 요청 완료!", textColor: .blue500, font: .caption3, textAlignment: .center)
            button.addBorder(cornerRadius: 4, borderWidth: 1, borderColor: .blue400)
            button.padding = UIEdgeInsets(top: 13, left: 24, bottom: 13, right: 24)
        case .nonExist(let nickName):
            imageView.image = .sittingCharacter
            let emphasisRange = NSRange(location: 0, length: nickName.count)
            let emphasisLabelStyle = EmphasisLabelStyle(text: "\(nickName)님을\n찾을 수 없어요", textColor: .gray700, font: .body3, textAlignment: .center, emphasisRange: emphasisRange, emphasisColor: .gray700, emphasisFont: .body5)
            placeholder.setLabel(style: emphasisLabelStyle)
            updateButtonUI(imageViewSize: 100)
        case .notSearch:
            break
        }
        
        underLineButton.addTarget(self, action: #selector(linkRequestCancel), for: .touchUpInside)
    }
    
    @objc private func linkRequest() {
        if let nickName = familyMember?.nickName, let memberId = familyMember?.memberId {
            delegate?.linkRequest(nickName: nickName, memberId: memberId)
        }
    }
    
    @objc private func linkRequestCancel() {
        if let memberId = familyMember?.memberId {
            delegate?.linkRequestCancel(memberId: memberId)
        }
    }
    
    func updateButtonUI(imageViewSize: CGFloat) {
        imageView.snp.updateConstraints {
            self.imageViewSize = $0.width.height.equalTo(imageViewSize).constraint
        }
    }
    
    func requestCompletion() {
        guard let familyMember = familyMember else { return }
        setType(type: .linkedRequestComplete(familyMember))
        underLineButton.isHidden = false
    }
    
    func requestCancel() {
        guard let familyMember = familyMember else { return }
        setType(type: .unlinked(familyMember))
        underLineButton.isHidden = true
    }
}
