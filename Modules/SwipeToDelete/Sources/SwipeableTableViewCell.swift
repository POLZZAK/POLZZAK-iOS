//
//  SwipeableTableViewCell.swift
//  SwipeToDelete
//
//  Created by 이정환 on 10/9/23.
//

import UIKit

import SnapKit
import SharedResources

public protocol SwipeableTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(_ cell: UITableViewCell)
}

open class SwipeableTableViewCell: UITableViewCell, Swipeable {
    public weak var swipeableDelegate: SwipeableTableViewCellDelegate?
    
    public var isSwipeRemove = true
    private var originalCenterCheck = false
    private var isSwipe = false
    private var swipeOnOriginalCenter = CGFloat()
    private var swipeOffOriginalCenter = CGFloat()
    private var beganOriginalCenter = CGFloat()
    
    public let panGestureView = UIView()
    
    public let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(.trashButton, for: .normal)
        return button
    }()
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = panGestureRecognizer.velocity(in: self)
            return abs(velocity.y) < abs(velocity.x)
        }
        return true
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSwipeToDeleteGesture()
        setupPanGesture()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        isSwipe = false
        panGestureView.center.x = contentView.center.x
        originalCenterCheck = false
    }
}

extension SwipeableTableViewCell {
    private func setupPanGesture() {
        selectionStyle = .none
        contentView.backgroundColor = .error500
        panGestureView.backgroundColor = .white
        
        [deleteButton, panGestureView].forEach {
            contentView.addSubview($0)
        }
        
        panGestureView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    func setupSwipeToDeleteGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        gesture.delegate = self
        panGestureView.addGestureRecognizer(gesture)
    }
    
    @objc func handleSwipeGesture(gesture: UIPanGestureRecognizer) {
        if false == isSwipeRemove {
            return
        }
        
        if false == originalCenterCheck {
            originalCenterCheck = true
            self.swipeOnOriginalCenter = panGestureView.center.x - 56
            self.swipeOffOriginalCenter = panGestureView.center.x
        }
        
        let originalCenter = isSwipe ? swipeOnOriginalCenter : swipeOffOriginalCenter
        let translationX = gesture.translation(in: panGestureView).x
        
        if gesture.state == .began {
            beganOriginalCenter = panGestureView.center.x
        }
        
        if gesture.state == .changed {
            if originalCenter > panGestureView.center.x {
                if beganOriginalCenter + translationX <= originalCenter {
                    panGestureView.center.x = beganOriginalCenter + translationX
                }  else if translationX >= 0 {
                    panGestureView.center.x = swipeOffOriginalCenter
                }
            } else {
                if false == isSwipe {
                    if panGestureView.center.x > beganOriginalCenter + translationX {
                        panGestureView.center.x = beganOriginalCenter + translationX
                    }
                } else {
                    if swipeOffOriginalCenter >= beganOriginalCenter + translationX {
                        panGestureView.center.x = beganOriginalCenter + translationX
                    } else {
                        panGestureView.center.x = swipeOffOriginalCenter
                    }
                }
            }
        } else if gesture.state == .ended {
            if translationX < -20 {
                isSwipe = true
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.panGestureView.center.x = self?.swipeOnOriginalCenter ?? 0
                })
            } else if translationX > 10  {
                isSwipe = false
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.panGestureView.center.x = self?.swipeOffOriginalCenter ?? 0
                })
            } else {
                panGestureView.center.x = (isSwipe ? swipeOnOriginalCenter : swipeOffOriginalCenter)
            }
        }
    }
    
    @objc private func deleteButtonTapped() {
        swipeableDelegate?.didTapDeleteButton(self)
    }
}
