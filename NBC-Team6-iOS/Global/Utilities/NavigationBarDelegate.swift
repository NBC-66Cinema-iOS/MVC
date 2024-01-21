//
//  NavigationBarDelegate.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/22.
//

import UIKit

protocol CustomNavigationBarDelegate: AnyObject {
    func didTapBackButton()
    func didTapMypageButton()
}

extension CustomNavigationBarDelegate where Self: UIViewController {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapMypageButton() {
        let myPageVC = MypageViewController()
        navigationController?.pushViewController(myPageVC, animated: true)
    }
}

