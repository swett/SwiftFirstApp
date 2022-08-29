//
//  AlertView.swift
//  Cleaner
//
//  Created by Vitaliy Gryza on 07.06.2022.
//

import UIKit


enum AlertType: Int {
    case AlertTypePermission = 0
    case AlertTypeContactsPermission
    case AlertTypePremium
    case AlertTypeCancelClean
    case AlertTypeClean
    case AlertTypeCleanContacts
    case AlertTypeCleanFiles
    case AlertTypeCleanFilesQuestion
}

class AlertView: UIView {

    typealias CompletionBlock = () -> Void
    typealias CompletionRememberBlock = (_ shouldRemember: Bool) -> Void

    
    var type: AlertType!
    var cancelCompletion: CompletionBlock?
    var doneCompletion: CompletionBlock?
    var rememberCompletion: CompletionRememberBlock?
    var blackView: UIView!
    //
    var shouldRemember = false
    
    static func showAlertWithType(alertType: AlertType, onView: UIView, doneCompletion: @escaping CompletionBlock, cancelCompletion: CompletionBlock? = nil, rememberCompletion: CompletionRememberBlock? = nil, cleanInfo: [String: Int] = [:]) {
        //Creating Alert and Black Views
        let alert = AlertView().then { v in
            v.type = alertType
            v.doneCompletion = doneCompletion
            if cancelCompletion != nil {
                v.cancelCompletion = cancelCompletion
            }
            if rememberCompletion != nil {
                v.rememberCompletion = rememberCompletion
            }
            v.backgroundColor = .white
            v.layer.cornerRadius = 18
        }
        alert.blackView = UIView().then { v in
            onView.addSubview(v)
            v.backgroundColor = UIColor.black
            v.alpha = 0
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        if alert.type == .AlertTypeCleanFilesQuestion {
            alert.blackView.addGestureRecognizer(UITapGestureRecognizer(target: alert, action: #selector(hideAlertIgnoreRemember)))
        } else {
            alert.blackView.addGestureRecognizer(UITapGestureRecognizer(target: alert, action: #selector(hideAlert)))
        }

        onView.addSubview(alert)
        //ConfigureAlert
        switch alert.type {
        case .AlertTypePermission: alert.configureWithPermission()
        case .AlertTypeContactsPermission: alert.configureWithContactsPermission()
        case .AlertTypePremium: alert.configureWithPremium()
        case .AlertTypeCancelClean: alert.configureWithCancelClean()
        case .AlertTypeClean:
            let photosCount = cleanInfo["photo"]!
            let videosCount = cleanInfo["video"]!
            alert.configureWithClean(photos: photosCount, videos: videosCount)
        case .AlertTypeCleanContacts: alert.configureWithCleanContacts()
        case .AlertTypeCleanFiles: alert.configureWithCleanFiles()
        case .AlertTypeCleanFilesQuestion: alert.configureWithCleanFilesQuestion()
        default:
            alert.configureWithPermission()
        }
        //Show Alert
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        //
        UIView.animate(withDuration: 0.3) {
            alert.blackView.alpha = 0.75
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                alert.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview().inset(20)
                    make.bottom.equalTo(alert.superview!.safeAreaLayoutGuide).inset(28)
                    make.height.equalTo(alert.snp.height)
                }
                alert.superview!.layoutIfNeeded()
            } completion: { com in
            }
        }
    }
    
    @objc func hideAlertIgnoreRemember() {
//        AppData.shared.rememberDeleteChoice = false
        //
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.blackView.alpha = 0
            self.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.top.equalTo(self.superview!.snp.bottom)
                make.height.equalTo(self.snp.height)
            }
            self.superview!.layoutIfNeeded()
        } completion: { com in
            self.removeFromSuperview()
        }
    }
    
    @objc func hideAlert() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.blackView.alpha = 0
            self.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.top.equalTo(self.superview!.snp.bottom)
                make.height.equalTo(self.snp.height)
            }
            self.superview!.layoutIfNeeded()
        } completion: { com in
            self.removeFromSuperview()
        }
    }
    
    @objc func cancelButtonAct() {
        if self.cancelCompletion != nil {
            self.cancelCompletion!()
        }
        hideAlert()
    }
    
    @objc func buttonAct() {
        if self.doneCompletion != nil {
            self.doneCompletion!()
        }
        hideAlert()
    }
    
    //
        
    @objc func rememberButtonAct(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        shouldRemember = sender.isSelected
        if self.rememberCompletion != nil {
            self.rememberCompletion!(_: shouldRemember)
        }
    }
    
    // MARK: - Configuring Alerts
    
    func configureWithPermission() {
        let cancelButton = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .appColor
            v.layer.cornerRadius = 12
            v.setTitle("PermissionAlertSettings", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.addTarget(self, action: #selector(cancelButtonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(self.snp.centerX).offset(-5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let _ = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .white
            v.layer.cornerRadius = 12
            v.setTitle("PermissionAlertOkay", for: .normal)
            v.setTitleColor(.gray, for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(buttonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(16)
                make.left.equalTo(self.snp.centerX).offset(5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let textLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "PermissionAlertText"
            v.textColor = .gray
            v.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(cancelButton.snp.top).offset(-32)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let titleLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "PermissionAlertTitle"
            v.textColor = .black.withAlphaComponent(0.7)
            v.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(textLabel.snp.top).offset(-8)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let _ = UIImageView(image: UIImage(named: "alertPermissionsIcon")).then { v in
            self.addSubview(v)
            v.contentMode = .scaleAspectFill
            v.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-21)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(82)
                make.top.equalToSuperview().inset(15)
            }
        }
        //
        self.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.superview!.snp.bottom)
        }
    }
    
    func configureWithContactsPermission() {
        let cancelButton = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .appColor
            v.layer.cornerRadius = 12
            v.setTitle("ContactsPermissionAlertSettings", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(cancelButtonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(self.snp.centerX).offset(-5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let _ = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .white
            v.layer.cornerRadius = 12
            v.setTitle("ContactsPermissionAlertOkay", for: .normal)
            v.setTitleColor(.black.withAlphaComponent(0.7), for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(buttonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(16)
                make.left.equalTo(self.snp.centerX).offset(5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let textLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "ContactsPermissionAlertText"
            v.textColor = .gray
            v.font = .monospacedDigitSystemFont(ofSize: 14, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(cancelButton.snp.top).offset(-32)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let titleLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "ContactsPermissionAlertTitle"
            v.textColor = .black.withAlphaComponent(0.7)
            v.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(textLabel.snp.top).offset(-8)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let _ = UIImageView(image: UIImage(named: "alertPermissionsIcon")).then { v in
            self.addSubview(v)
            v.contentMode = .scaleAspectFill
            v.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-21)
                make.left.right.equalToSuperview().inset(16)
                make.height.equalTo(82)
                make.top.equalToSuperview().inset(15)
            }
        }
        //
        self.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.superview!.snp.bottom)
        }
    }
    
    func configureWithPremium() {
        let doneButton = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .appColor
            v.layer.cornerRadius = 12
            v.setTitle("PremiumAlertContinue", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(buttonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let textLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "PremiumAlertText"
            v.textColor = .gray
            v.font = .monospacedDigitSystemFont(ofSize: 14, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(doneButton.snp.top).offset(-32)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let titleLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "PremiumAlertTitle"
            v.textColor = .black.withAlphaComponent(0.7)
            v.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(textLabel.snp.top).offset(-8)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let _ = UIImageView(image: UIImage(named: "alertCrownIcon")).then { v in
            self.addSubview(v)
            v.contentMode = .scaleAspectFill
            v.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-19)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(42)
                make.top.equalToSuperview().inset(31)
            }
        }
        //
        self.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.superview!.snp.bottom)
        }
    }
    
    func configureWithCancelClean() {
        let cancelButton = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .appColor
            v.layer.cornerRadius = 12
            v.setTitle("CancelCleanAlertCancel", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(cancelButtonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(self.snp.centerX).offset(-5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let _ = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .white
            v.layer.cornerRadius = 12
            v.setTitle("CancelCleanAlertLeave", for: .normal)
            v.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(buttonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(16)
                make.left.equalTo(self.snp.centerX).offset(5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let textLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "CancelCleanAlertText"
            v.textColor = .gray
            v.font = .monospacedDigitSystemFont(ofSize: 14, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(cancelButton.snp.top).offset(-32)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let titleLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "CancelCleanAlertTitle"
            v.textColor = .black.withAlphaComponent(0.7)
            v.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(textLabel.snp.top).offset(-8)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let _ = UIImageView(image: UIImage(named: "alertCrossIcon")).then { v in
            self.addSubview(v)
            v.contentMode = .scaleAspectFill
            v.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-19)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(42)
                make.top.equalToSuperview().inset(31)
            }
        }
        //
        self.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.superview!.snp.bottom)
        }
    }
    
    func configureWithClean(photos: Int, videos: Int) {
        let cancelButton = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .white
            v.layer.cornerRadius = 12
            v.setTitle("CleanAlertCancel", for: .normal)
            v.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(cancelButtonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(self.snp.centerX).offset(-5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let _ = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .appColor
            v.layer.cornerRadius = 12
            v.setTitle("CleanAlertClean", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(buttonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(16)
                make.left.equalTo(self.snp.centerX).offset(5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let textLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = String(format: "CleanAlertText", arguments: [photos, videos])
            v.textColor = .gray
            v.font = .monospacedDigitSystemFont(ofSize: 14, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(cancelButton.snp.top).offset(-32)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let titleLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "CleanAlertTitle"
            v.textColor = .black.withAlphaComponent(0.7)
            v.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(textLabel.snp.top).offset(-8)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let _ = UIImageView(image: UIImage(named: "alertCleanIcon")).then { v in
            self.addSubview(v)
            v.contentMode = .scaleAspectFill
            v.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-19)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(42)
                make.top.equalToSuperview().inset(31)
            }
        }
        //
        self.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.superview!.snp.bottom)
        }
    }
    
    func configureWithCleanContacts() {
        let cancelButton = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .appColor
            v.layer.cornerRadius = 12
            v.setTitle("CleanContactsAlertCancel", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(cancelButtonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(self.snp.centerX).offset(-5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let _ = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .white
            v.layer.cornerRadius = 12
            v.setTitle("CleanContactsAlertDelete", for: .normal)
            v.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.addTarget(self, action: #selector(buttonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(16)
                make.left.equalTo(self.snp.centerX).offset(5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let textLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "CleanContactsAlertText"
            v.textColor = .gray
            v.font = .monospacedDigitSystemFont(ofSize: 14, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(cancelButton.snp.top).offset(-32)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let titleLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "CleanContactsAlertTitle"
            v.textColor = .black.withAlphaComponent(0.7)
            v.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(textLabel.snp.top).offset(-8)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let _ = UIImageView(image: UIImage(named: "alertDeleteIcon")).then { v in
            self.addSubview(v)
            v.contentMode = .scaleAspectFill
            v.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-19)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(42)
                make.top.equalToSuperview().inset(31)
            }
        }
        //
        self.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.superview!.snp.bottom)
        }
    }
    
    func configureWithCleanFiles() {
        let cancelButton = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .appColor
            v.layer.cornerRadius = 12
            v.setTitle("CleanFilesAlertCancel", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(cancelButtonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(self.snp.centerX).offset(-5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let _ = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .white
            v.layer.cornerRadius = 12
            v.setTitle("CleanFilesAlertDelete", for: .normal)
            v.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(buttonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(16)
                make.left.equalTo(self.snp.centerX).offset(5.5)
                make.bottom.equalToSuperview().inset(16)
                make.height.equalTo(44)
            }
        }
        let textLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "CleanFilesAlertText"
            v.textColor = .gray
            v.font = .monospacedDigitSystemFont(ofSize: 14, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(cancelButton.snp.top).offset(-32)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let titleLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "CleanFilesAlertTitle"
            v.textColor = .black.withAlphaComponent(0.7)
            v.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(textLabel.snp.top).offset(-8)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let _ = UIImageView(image: UIImage(named: "alertDeleteIcon")).then { v in
            self.addSubview(v)
            v.contentMode = .scaleAspectFill
            v.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-19)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(42)
                make.top.equalToSuperview().inset(31)
            }
        }
        //
        self.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.superview!.snp.bottom)
        }
    }
    
    
    func configureWithCleanFilesQuestion() {
        let rememberButton = UIButton(type: .custom).then { v in
            self.addSubview(v)
            v.setImage(UIImage(named: "checkboxOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
            v.setImage(UIImage(named: "checkboxOn")?.withRenderingMode(.alwaysOriginal), for: .selected)
            v.setTitle("CleanPermissionAlertRememberChoice", for: .normal)
            v.setTitleColor(.gray, for: .normal)
            v.setTitleColor(.appColor, for: .selected)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.contentHorizontalAlignment = .center
//            v.setHorizontalMargins(imageTextSpacing: 10, contentXInset: 15)
            v.backgroundColor = .clear
            v.addTarget(self, action: #selector(rememberButtonAct(sender:)), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(48)
                make.height.equalTo(24)
                make.bottom.equalToSuperview().inset(18)
            }
        }
        let cancelButton = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .white
            v.layer.cornerRadius = 12
            v.setTitle("CleanPermissionAlertCancel", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(cancelButtonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(self.snp.centerX).offset(-5.5)
                make.bottom.equalTo(rememberButton.snp.top).offset(-23)
                make.height.equalTo(44)
            }
        }
        let _ = UIButton(type: .system).then { v in
            self.addSubview(v)
            v.backgroundColor = .appColor
            v.layer.cornerRadius = 12
            v.setTitle("CleanPermissionAlertDelete", for: .normal)
            v.setTitleColor(.white, for: .normal)
            v.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 16, weight: .thin)
            v.addTarget(self, action: #selector(buttonAct), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(16)
                make.left.equalTo(self.snp.centerX).offset(5.5)
                make.bottom.equalTo(rememberButton.snp.top).offset(-23)
                make.height.equalTo(44)
            }
        }
        let titleLabel = UILabel().then { v in
            self.addSubview(v)
            v.text = "CleanPermissionAlertTitle"
            v.textColor = .black.withAlphaComponent(0.7)
            v.font = .monospacedDigitSystemFont(ofSize: 20, weight: .thin)
            v.textAlignment = .center
            v.numberOfLines = 0
            v.lineBreakMode = .byWordWrapping
            v.snp.makeConstraints { make in
                make.bottom.equalTo(cancelButton.snp.top).offset(-32)
                make.left.right.equalToSuperview().inset(16)
            }
        }
        let _ = UIImageView(image: UIImage(named: "alertDeleteIcon")).then { v in
            self.addSubview(v)
            v.contentMode = .scaleAspectFill
            v.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel.snp.top).offset(-19)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(42)
                make.top.equalToSuperview().inset(31)
            }
        }
        //
        self.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(self.superview!.snp.bottom)
        }
    }
}
