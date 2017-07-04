//
//  HNExtensions.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit

extension UIColor {
    func brightened(by factor: CGFloat) -> UIColor {
        var hueValue: CGFloat = 0, saturationValue: CGFloat = 0, brightnessValue: CGFloat = 0, alphaValue: CGFloat = 0
        getHue(&hueValue, saturation: &saturationValue, brightness: &brightnessValue, alpha: &alphaValue)
        return UIColor(hue: hueValue, saturation: saturationValue, brightness: brightnessValue * factor, alpha: alphaValue)
    }
}

