//
//  Swipeable.swift
//  SwipeToDelete
//
//  Created by 이정환 on 10/9/23.
//

import UIKit

protocol Swipeable {
    var isSwipeRemove: Bool { get set}
    
    func setupSwipeToDeleteGesture()
    func handleSwipeGesture(gesture: UIPanGestureRecognizer)
}
