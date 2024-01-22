//
//  ReservationViewController.swift
//  NBC-Team6-iOS
//
//  Created by Joon Baek on 2024/01/16.
//

import UIKit

final class ReservationViewController: BaseViewController, CustomNavigationBarDelegate {
    // 마이페이지와 연동되는 부분
    static var reservations: [Reservation] = []

    let navigationBar = CustomNavigationBar(viewType: .standard, title: "예매하기")
    
    let backButton = UINavigationItem()
    let centerReservationText = UITextView()
    let myPageButton = UIButton()
    let movieTitleLabel = UILabel()
    let dateLabel = UILabel()
    let numberOfPersonLabel = UILabel()
    let totalAmountlabel = UILabel()
    let movieTitle = UILabel()
    let date = UIDatePicker()
    let stepperCount = UILabel()
    let numberOfPersonstepper = UIStepper()
    let totalAmount = UILabel()
    
    var reservationButton = CustomButton(fontColor: .white, backColor: .black, title: "예약하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
    }
    //moveToReservationView 로 교체
    @objc func reservationView(){
        navigationController?.pushViewController(ReservationViewController(), animated: true)
    }
   
    func configureNavigationBar() {
        navigationBar.delegate = self
        
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
    
    // 마이페이지와 연동되는 부분
    
    func addReservation() {
        let reservation = Reservation(movieTitle: movieTitle.text ?? "", date: date.date, numberOfPeople: Int(stepperCount.text ?? "0") ?? 0, totalAmount: Int(totalAmount.text ?? "0") ?? 0)
        ReservationViewController.reservations.append(reservation)
    }
    
    func configureUI() {
        configureCenterReservationText()
        configureMovieTitleLabel()
        configureDateLabel()
        configureNumberOfPersonLabel()
        configureTotalAmountlabel()
        configureMovieTitle()
        configureDate()
        configureStepperCount()
        configureNumberOfPersonstepper()
        configureTotalAmount()
        configureReservationButton()
    }
    
    func configureCenterReservationText() {
        centerReservationText.text = nil
        centerReservationText.textAlignment = .center
        centerReservationText.font = UIFont.boldSystemFont(ofSize: 20)
        centerReservationText.textColor = .black
        centerReservationText.backgroundColor = .systemBackground
        view.addSubview(centerReservationText)
        centerReservationText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerReservationText.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 10),
            centerReservationText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerReservationText.widthAnchor.constraint(equalToConstant: 100),
            centerReservationText.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureMovieTitleLabel() {
        movieTitleLabel.text = "영화제목"
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        movieTitleLabel.textColor = .black
        movieTitleLabel.backgroundColor = .systemBackground
        view.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: centerReservationText.bottomAnchor, constant: 150),
            movieTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            movieTitleLabel.widthAnchor.constraint(equalToConstant: 100),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureDateLabel() {
        dateLabel.text = "날짜"
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.boldSystemFont(ofSize: 25)
        dateLabel.textColor = .black
        dateLabel.backgroundColor = .systemBackground
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 30),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureNumberOfPerson() {
        numberOfPersonLabel.text = "인원"
        numberOfPersonLabel.textAlignment = .left
        numberOfPersonLabel.font = UIFont.boldSystemFont(ofSize: 15)
        numberOfPersonLabel.textColor = .black
        numberOfPersonLabel.backgroundColor = .systemBackground
        view.addSubview(numberOfPersonLabel)
        numberOfPersonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfPersonLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            numberOfPersonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            numberOfPersonLabel.widthAnchor.constraint(equalToConstant: 100),
            numberOfPersonLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureTotalAmountlabel() {
        totalAmountlabel.text = "총금액"
        totalAmountlabel.textAlignment = .left
        totalAmountlabel.font = UIFont.boldSystemFont(ofSize: 35)
        totalAmountlabel.textColor = .black
        totalAmountlabel.backgroundColor = .systemBackground
        view.addSubview(totalAmountlabel)
        totalAmountlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalAmountlabel.topAnchor.constraint(equalTo: numberOfPersonLabel.bottomAnchor, constant: 100),
            totalAmountlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            totalAmountlabel.widthAnchor.constraint(equalToConstant: 100),
            totalAmountlabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureMovieTitle() {
        movieTitle.text = "영화이름"
        movieTitle.textAlignment = .right
        movieTitle.font = UIFont.boldSystemFont(ofSize: 20)
        movieTitle.textColor = .black
        movieTitle.backgroundColor = .systemBackground
        movieTitle.adjustsFontSizeToFitWidth = true
        view.addSubview(movieTitle)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: centerReservationText.bottomAnchor, constant: 150),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            movieTitle.widthAnchor.constraint(equalToConstant: 100),
            movieTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureDate() {
        date.datePickerMode = .dateAndTime
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM-dd HH:mm"
        if let initialDate = dateformatter.date(from: "01-25 20:00") {
            date.date = initialDate
            date.preferredDatePickerStyle = .compact
            date.backgroundColor = .systemBackground
            view.addSubview(date)
            date.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                date.topAnchor.constraint(equalTo: dateLabel.topAnchor),
                date.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -130),
                date.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
                date.heightAnchor.constraint(equalToConstant: 35)
            ])
        }
    }
    //함께 변경됨
    func configureNumberOfPersonLabel() {
        numberOfPersonLabel.text = "인원"
        numberOfPersonLabel.textAlignment = .left
        numberOfPersonLabel.font = UIFont.boldSystemFont(ofSize: 25)
        numberOfPersonLabel.textColor = .black
        numberOfPersonLabel.backgroundColor = .systemBackground
        view.addSubview(numberOfPersonLabel)
        numberOfPersonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfPersonLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30),
            numberOfPersonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            numberOfPersonLabel.widthAnchor.constraint(equalToConstant: 100),
            numberOfPersonLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureStepperCount() {
        stepperCount.text = "1"
        stepperCount.textAlignment = .center
        stepperCount.font = UIFont.boldSystemFont(ofSize: 25)
        stepperCount.textColor = .black
        stepperCount.backgroundColor = .systemBackground
        view.addSubview(stepperCount)
        stepperCount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepperCount.topAnchor.constraint(equalTo: numberOfPersonLabel.topAnchor),
            stepperCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            stepperCount.widthAnchor.constraint(equalToConstant: 100),
            stepperCount.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureNumberOfPersonstepper() {
        numberOfPersonstepper.minimumValue = 1
        numberOfPersonstepper.maximumValue = 10
        numberOfPersonstepper.stepValue = 1
        numberOfPersonstepper.addTarget(self, action: #selector(numberOfPersonstepperValueChanged(_:)), for: .valueChanged)
        view.addSubview(numberOfPersonstepper)
        numberOfPersonstepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfPersonstepper.topAnchor.constraint(equalTo: numberOfPersonLabel.topAnchor),
            numberOfPersonstepper.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            numberOfPersonstepper.widthAnchor.constraint(equalToConstant: 100),
            numberOfPersonstepper.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func numberOfPersonstepperValueChanged(_ sender: UIStepper) {
        stepperCount.text = "\(Int(sender.value))"
        totalAmount.text = "\(Int(sender.value) * 16000)원"
    }
    
    func configureTotalAmount() {
        totalAmount.text = "총금액"
        totalAmount.textAlignment = .right
        totalAmount.font = UIFont.boldSystemFont(ofSize: 25)
        totalAmount.textColor = .black
        totalAmount.backgroundColor = .systemBackground
        totalAmount.adjustsFontSizeToFitWidth = true
        view.addSubview(totalAmount)
        totalAmount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalAmount.topAnchor.constraint(equalTo: numberOfPersonLabel.bottomAnchor, constant: 100),
            totalAmount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            totalAmount.widthAnchor.constraint(equalToConstant: 100),
            totalAmount.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureReservationButton() {
        reservationButton = CustomButton(fontColor: .white, backColor: .black, title: "예매하기")
        reservationButton.layer.cornerRadius = 10
        reservationButton.addTarget(self, action: #selector(reservationButtonTapped), for: .touchUpInside)
        view.addSubview(reservationButton)
        NSLayoutConstraint.activate([
            reservationButton.topAnchor.constraint(equalTo: totalAmountlabel.bottomAnchor, constant: 180),
            reservationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            reservationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            reservationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func reservationButtonTapped() {
        let alertController = UIAlertController(title: nil, message: "예매가 완료되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            let movieListViewController = MovieListViewController()
            
            self.navigationController?.pushViewController(movieListViewController, animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
