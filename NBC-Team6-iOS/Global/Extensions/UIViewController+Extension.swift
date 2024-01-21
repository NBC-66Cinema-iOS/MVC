//
//  UIViewController+Extension.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/22.
//

import UIKit

extension UIViewController {
    func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDeviceHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
