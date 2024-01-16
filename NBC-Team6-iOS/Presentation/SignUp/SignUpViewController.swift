//
//  SignUpViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Property
    let introLabel = UILabel()
    let iconImageView = UIImageView()
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    let signupButton = CustomButton(fontColor: .white, backColor: .black, title: "회원가입")
    
    // UserDefaults
    //let memberUserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureUI()
    }
    
    // MARK: - Layout 
    // configurations
    func configureUI() {
        configureIconImageView()
        configureIntroLable()
        configureIdTextField()
        configureSignUpButton()
        configurePasswordTextField()
    }
    
    // 아이콘
    func configureIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.image = UIImage(systemName: "film.stack")
        iconImageView.contentMode = .center
        iconImageView.tintColor = .black
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            iconImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            iconImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
            //iconImageView.heightAnchor.constraint(equalToConstant: 100) -> image 넣을때 heightAnchor 설정해줘야 함
        ])
    }
    
    // 인트로 레이블
    func configureIntroLable() {
        view.addSubview(introLabel)
        introLabel.text = "MOVIE66\n회원이 되어보세요!"
        introLabel.numberOfLines = 0
        introLabel.textAlignment = .center
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            introLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            introLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            introLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    // 아이디 입력
    func configureIdTextField() {
        view.addSubview(idTextField)
        idTextField.placeholder = "아이디 입력"
        idTextField.borderStyle = .roundedRect
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 60),
            idTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            idTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    // 비밀번호 입력
    func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.placeholder = "비밀번호 입력"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
   
    // 회원가입 버튼
    func configureSignUpButton() {
        view.addSubview(signupButton)
        //signupButton.addTarget(self, action: #selector(toSignupView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 420),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}
