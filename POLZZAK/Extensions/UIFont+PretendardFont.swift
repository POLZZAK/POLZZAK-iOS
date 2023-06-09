//
//  UIFont+PretendardFont.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/05/14.
//

import UIKit

// MARK: - Pretendard Font

extension UIFont {
    enum FamilyForPretendard: String {
        case bold = "Bold"
        case medium = "Medium"
        case semiBold = "SemiBold"
    }
    
    static func pretendard(size: CGFloat, family: FamilyForPretendard) -> UIFont {
        return UIFont(name: "Pretendard-\(family.rawValue)", size: size)!
    }
}

// MARK: - Project Typo

extension UIFont {
    static var title1: UIFont {
        return .pretendard(size: 24, family: .semiBold)
    }
    
    static var title2: UIFont {
        return .pretendard(size: 22, family: .semiBold)
    }
    
    static var title3: UIFont {
        return .pretendard(size: 20, family: .bold)
    }
    
    static var subtitle1: UIFont {
        return .pretendard(size: 18, family: .semiBold)
    }
    
    static var subtitle2: UIFont {
        return .pretendard(size: 16, family: .bold)
    }
    
    static var subtitle3: UIFont {
        return .pretendard(size: 16, family: .semiBold)
    }
    
    static var body1: UIFont {
        return .pretendard(size: 15, family: .medium)
    }
    
    static var body2: UIFont {
        return .pretendard(size: 14, family: .semiBold)
    }
    
    static var body3: UIFont {
        return .pretendard(size: 14, family: .medium)
    }
    
    static var body4: UIFont {
        return .pretendard(size: 13, family: .medium)
    }
    
    static var caption1: UIFont {
        return .pretendard(size: 12, family: .semiBold)
    }
    
    static var caption2: UIFont {
        return .pretendard(size: 12, family: .medium)
    }
}
