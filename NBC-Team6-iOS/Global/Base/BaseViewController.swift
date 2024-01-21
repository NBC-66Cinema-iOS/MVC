//
//  BaseViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        navigationController?.isNavigationBarHidden = true
    }
}
