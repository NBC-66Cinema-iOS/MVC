//
//  MypageViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

// 예매내역 struct
struct Reservation {
    let movieTitle: String
    let date: Date
    let numberOfPeople: Int
    let totalAmount: Int
}

//extension UIImage {
//    func resizedImage(newSize: CGSize) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//        self.draw(in: CGRect(origin: .zero, size: newSize))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage
//    }
//}

class MypageViewController: UIViewController, CustomNavigationBarDelegate {
    // MARK: - Property
    // ID 레이블
    let mypageIdLabel = UILabel()
    // ID 텍스트 -> UserDefaults에서 ID 정보 가져오기
    let mypageIdText = UILabel()
    // 예매내역 타이틀 레이블
    let mypageReservationLabel = UILabel()
    // 로그아웃 버튼
    let mypageLogoutButton = CustomButton(fontColor: .white, backColor: .black, title: "로그아웃")
    // UserDefaults
    let memberUserDefaults = UserDefaults.standard
    // 예매내역 텍스트
    let mypageReservationsText = UITextView()
    
//    let navigationBar = UINavigationBar()
    let navigationBar = CustomNavigationBar(viewType: .withMypageButton, title: "예매하기")
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureUI()

        // id를 UserDefaults에서 가져오기
        getId()
        
        // 로그아웃 버튼 addTarget
        mypageLogoutButton.addTarget(self, action: #selector(mypageLogoutButtonTapped), for: .touchUpInside)
        navigationBar.delegate = self
    }
    
    func configureNavigationBar() {
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }

    // MARK: - @objc
    // 네비게이션바에서 뒤로가기 버튼 눌렀을때
//    @objc func backButtonTapped() {
//        let reservationVC = ReservationViewController()
//        self.navigationController?.popViewController(animated: true)
//    }
    
    // 로그아웃 버튼 눌렀을때 로그인 화면으로 가기 + 아이디랑 비밀번호 채워진것 없어지게 하기
    @objc func mypageLogoutButtonTapped() {
        memberUserDefaults.removeObject(forKey: "userId")
        memberUserDefaults.removeObject(forKey: "password")
        
        //스택 비우고 로그인 화면으로 가기
        navigationController?.setViewControllers([SignInViewController()], animated: true)
    }
    
    // MARK: - Custom Method
    // 예매내역
    func configureReservations() {
        view.addSubview(mypageReservationsText)
        mypageReservationsText.translatesAutoresizingMaskIntoConstraints = false
        
        //mypageReservationsText.text = "Lift 1/22 20:00 3명"
        mypageReservationsText.isEditable = false
        
        NSLayoutConstraint.activate([
            mypageReservationsText.topAnchor.constraint(equalTo: mypageReservationLabel.bottomAnchor, constant: 10),
            mypageReservationsText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mypageReservationsText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mypageReservationsText.heightAnchor.constraint(equalToConstant: 100) // Adjust this value as needed
        ])
        
        // textview 설정 - 텍스트, 폰트, 색상
        mypageReservationsText.font = UIFont.systemFont(ofSize: 16)
        mypageReservationsText.textColor = .gray
        
        if ReservationViewController.reservations.isEmpty {
               mypageReservationsText.text = "Lift 1/22 20:00 3명"
           } else {
               var reservationsText = ""
               for reservation in ReservationViewController.reservations {
                   reservationsText += "영화제목: \(reservation.movieTitle), 날짜: \(reservation.date), 인원: \(reservation.numberOfPeople), 총금액: \(reservation.totalAmount)\n"
               }
               mypageReservationsText.text = reservationsText
           }
       }
    
    // id를 userdefaults에서 가져오기
    func getId() {
        if let id = memberUserDefaults.string(forKey: "userId") {
            mypageIdText.text = id
        }
    }
    
    // MARK: - Layout
    func configureUI() {
        configureNavigationBar()
        configureMypageIdLabel()
        configureMypageIdText()
        configureMypageReservationLabel()
        configureMypageLogoutButton()
        configureReservations()
    }

    func configureMypageIdLabel() {
        view.addSubview(mypageIdLabel)
        mypageIdLabel.text = "ID"
        mypageIdLabel.font = UIFont.boldSystemFont(ofSize: mypageIdLabel.font.pointSize)
        mypageIdLabel.textAlignment = .left
        mypageIdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mypageIdLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 80),
            mypageIdLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mypageIdLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    func configureMypageIdText() {
        view.addSubview(mypageIdText)
        mypageIdText.textColor = .gray
        mypageIdText.textAlignment = .left
        mypageIdText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mypageIdText.topAnchor.constraint(equalTo: mypageIdLabel.bottomAnchor, constant: 10),
            mypageIdText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mypageIdText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    func configureMypageReservationLabel() {
        view.addSubview(mypageReservationLabel)
        mypageReservationLabel.text = "예매내역"
        mypageReservationLabel.font = UIFont.boldSystemFont(ofSize: mypageIdLabel.font.pointSize)
        mypageReservationLabel.textAlignment = .left
        mypageReservationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mypageReservationLabel.topAnchor.constraint(equalTo: mypageIdText.bottomAnchor, constant: 50),
            mypageReservationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mypageReservationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    func configureMypageLogoutButton() {
        view.addSubview(mypageLogoutButton)
        mypageLogoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mypageLogoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            mypageLogoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mypageLogoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
}
