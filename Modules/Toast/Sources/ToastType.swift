//
//  ToastType.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/03.
//

import UIKit

public enum ToastType {
    case success(String, UIImage? = nil)
    case error(String, UIImage? = nil)
}

extension ToastType: Equatable {
    public static func == (lhs: ToastType, rhs: ToastType) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success),
            (.error, .error):
            return true
        default:
            return false
        }
    }
}
