//
//  ViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/15.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Properties
    
    // UILabel 선언 - 뭘 어떻게 만들건지
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "박천재님 화이팅입니다"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        setLayout()
    }
}

extension ViewController {
    
    func setUI() {
        // 배경색 지정
        view.backgroundColor = .white
    }

    func setLayout() {
        // 계층에 추가 - 계층에 뭘 올릴건지
        view.addSubview(testLabel)
        
        // 오토레이아웃 적용 - 어디에 그릴건지
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
