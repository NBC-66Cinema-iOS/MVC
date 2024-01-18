//
//  SignInViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Property
    let introLabel = UILabel()
    let iconImageView = UIImageView()
    // textfield
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    // 버튼
    let loginButton = CustomButton(fontColor: .white, backColor: .black, title: "로그인")
    let signupButton = CustomButton(fontColor: .black, backColor: .clear, title: "회원가입")
    
    // UserDefaults
        let memberUserDefaults = UserDefaults.standard
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureUI()
        
        // 자동으로 로그인 정보 채우기
        autoSignIn()
        
        // 로그인 버튼
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc func toSignUpView(){
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

    // 로그인 버튼 눌렀을때 -> 아무것도 입력 안해도 로그인 버튼 누르면 다음 화면으로 넘어가버리는 것 수정해야함 ㄷㄷ
    @objc private func loginButtonTapped() {
        guard let enteredUserId = idTextField.text,
              let enteredPassword = passwordTextField.text else {
            print("Error: Text fields are empty")
            return
        }

        guard let savedUserId = memberUserDefaults.string(forKey: "userId"),
              let savedPassword = memberUserDefaults.string(forKey: "password") else {
            print("Error: No saved credentials")
            return
        }

        if enteredUserId == savedUserId && enteredPassword == savedPassword {
            print("Login successful")
    
                let movieListVC = MovieListViewController()
                
            // MovieListViewController 푸쉬하기
            //self.navigationController?.pushViewController(movieListVC, animated: true)
            
            //스택 비우고 영화리스트 화면으로 가기
            navigationController?.setViewControllers([movieListVC], animated: true)
            
        } else {
            // 로그인 정보 틀릴 경우에 alert 띄우기
            let alert = UIAlertController(title: "로그인 실패", message: "로그인에 실패하였습니다", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Custom Method
    // 회원가입하고 나면 자동으로 로그인 정보 채우는 기능
    func autoSignIn() {
        if let savedUserId = memberUserDefaults.string(forKey: "userId"),
           let savedPassword = memberUserDefaults.string(forKey: "password") {
            idTextField.text = savedUserId
            passwordTextField.text = savedPassword
        }
    }
    
    // MARK: - Layout
    // configurations
    func configureUI() {
        configureIconImageView()
        configureIntroLabel()
        configureIdTextField()
        configureLoginButton()
        configureSignUpButton()
        configurePasswordTextField()
    }
    
    // 아이콘
    func configureIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.image = UIImage(systemName: "film.stack")
        iconImageView.contentMode = .center
        iconImageView.tintColor = .red
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            iconImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            iconImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    // 인트로 레이블
    func configureIntroLabel() {
        view.addSubview(introLabel)
        introLabel.text = "안녕하세요!\nMOVIE66 입니다."
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
    
    // 로그인 버튼
    func configureLoginButton() {
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            //loginButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -100)
        ])
    }
    
    // 회원가입 버튼
    func configureSignUpButton() {
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(toSignUpView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}

