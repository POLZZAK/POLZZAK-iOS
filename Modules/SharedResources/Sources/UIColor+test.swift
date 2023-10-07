//
//  UIColor+test.swift
//  SharedResourcesModule
//
//  Created by 이정환 on 10/7/23.
//

import UIKit

public extension UIColor {
    static var random: UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private static var rainbowIndex = 0
    
    static var rainbowColors: [UIColor] = [
        UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0),
        UIColor(red: 1.0, green: 0.5, blue: 0, alpha: 1.0),
        UIColor(red: 1.0, green: 1.0, blue: 0, alpha: 1.0),
        UIColor(red: 0, green: 1.0, blue: 0, alpha: 1.0),
        UIColor(red: 0, green: 0, blue: 1.0, alpha: 1.0),
        UIColor(red: 0.5, green: 0, blue: 1.0, alpha: 1.0),
        UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 1.0)
    ]
    
    static var rainbow: UIColor {
        let color = rainbowColors[rainbowIndex]
        rainbowIndex = (rainbowIndex + 1) % rainbowColors.count
        return color
    }
    
    var accessibilityDescription: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return "R:\(red), G:\(green), B:\(blue), A:\(alpha)"
    }
}
