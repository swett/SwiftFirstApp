//
//  ViewController.swift
//  TestApp
//
//  Created by Nikita Kurochka on 18.05.2022.
//

import UIKit
import SnapKit
import Then



class ViewController: UIViewController {


    // layout colors
    let color1: UIColor = .appColor
    let color2 = UIColor(named: "appDarkBlue2")
    let blueDark = UIColor(named: "BackGroundColor1")
    let blueDark2 = UIColor(named: "BackGroundColor2")
    let buttonColor = UIColor(named: "ButtonColor")
    let greenGradientFirstColor = UIColor(named: "GreenGradient1")
    let greenGradientSecondColor = UIColor(named: "GreeenGradient2")
    let yesButton = UIColor(named: "YesButton")
    let redGradientFirstColor = UIColor(named: "RedGradient")
    let redGradientSecondColor = UIColor(named: "RedGradient2")
    let redButton = UIColor(named: "RedButton")
   // layout components
    var accountButton: UIButton!
    var statisticButton: UIButton!
    var settingsImage: UIImage!
    var infoImage: UIImage!
    var counter: Int = 0
    var descriptioTextView: UILabel!
    var partyButton: UIButton!
    var yesOrNoButton: UIButton!
    var gradientLayer: CAGradientLayer!
    var topImageContainerView: UIView!
    var ethernetButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    
    
    @objc func goToParty() {
        counter += 1
        
        if counter >= 2 {
            self.navigationController?.pushViewController(PartyVC(), animated: true)
        }
    }
    
    @objc func goToStatistic(){
        UIView.animate(withDuration: 0.1) {
            self.statisticButton.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            self.statisticButton.transform = .identity
        }

        self.navigationController?.pushViewController(StatisticView(), animated: true)
    }
    
    @objc func goToEthernet() {
        UIView.animate(withDuration: 0.1) {
            self.ethernetButton.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            self.ethernetButton.transform = .identity
        }
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true) {
            
        }
    }
    
    @objc func goToAccountData(){
        UIView.animate(withDuration: 0.1) {
            self.accountButton.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            self.accountButton.transform = .identity
        }

        self.navigationController?.pushViewController(TableDataShow(), animated: true)
    }
    
    @objc func buttonTapped () {
//        var rnd = Int.random(in: 0..<2)
        UIView.animate(withDuration: 0.1) {
            self.yesOrNoButton.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            UIView.animate(withDuration: 0.1) {
                self.yesOrNoButton.transform = .identity
            }
        }
        var yesCounter = (AppData.shared.defaultData.value(forKey: "yesCounter") != nil)  ? AppData.shared.defaultData.value(forKey: "yesCounter"): 0
        var noCounter = (AppData.shared.defaultData.value(forKey: "noCounter") != nil) ? AppData.shared.defaultData.value(forKey: "noCounter") : 0
        let rndBool = Bool.random()
        if rndBool == true{
            yesOrNoButton.alpha = 0.1
            AppData.shared.saveValue(value: yesCounter as! Int+1, forKey: "yesCounter")
            UIView.animate(withDuration: 0.3) {
                self.yesOrNoButton.alpha = 1
            }
            yesOrNoButton.setTitle("YES", for: .normal)
            yesOrNoButton.backgroundColor = yesButton
            gradientLayer.colors = [greenGradientFirstColor!.cgColor, greenGradientSecondColor!.cgColor]
            print("I`m yesCounter: \(AppData.shared.readValue(forKey: "yesCounter"))")
        } else {
            yesOrNoButton.alpha = 0.1
            AppData.shared.saveValue(value: noCounter as! Int+1, forKey: "noCounter")
            UIView.animate(withDuration: 0.3) {
                self.yesOrNoButton.alpha = 1
            }
            yesOrNoButton.setTitle("NO", for: .normal)
            yesOrNoButton.backgroundColor = redButton
            gradientLayer.colors = [redGradientFirstColor!.cgColor, redGradientSecondColor!.cgColor]
            print("I`m noCounter: \(AppData.shared.readValue(forKey: "noCounter"))")
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        // this method called when all constrains are set on views
        // all graphick things like gradient and shadows
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
        statisticButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        statisticButton.layer.shadowRadius = 2
        statisticButton.layer.shadowOffset = .init(width: 0, height: 5)
        statisticButton.layer.shadowOpacity = 1
        
        accountButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        accountButton.layer.shadowRadius = 2
        accountButton.layer.shadowOffset = .init(width: 0, height: 5)
        accountButton.layer.shadowOpacity = 1
        
        yesOrNoButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        yesOrNoButton.layer.shadowRadius = 2
        yesOrNoButton.layer.shadowOffset = .init(width: 0, height: 5)
        yesOrNoButton.layer.shadowOpacity = 1
        //how to make button like a circle beneath this comment line of code about it
        yesOrNoButton.layer.cornerRadius = 0.5 * yesOrNoButton.bounds.size.width
        partyButton.layer.cornerRadius = 0.5 * partyButton.bounds.size.width
        descriptioTextView.layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
        descriptioTextView.layer.shadowRadius = 10
        descriptioTextView.layer.shadowOffset = .init(width: 0, height: 10)
        descriptioTextView.layer.shadowOpacity = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        defaultData.set(0, forKey: "counterYes")
//        defaultData.set(0, forKey: "counterNo")
        gradientLayer = CAGradientLayer().then({ v in
            self.view.layer.addSublayer(v)
            v.colors = [blueDark!.cgColor,blueDark2!.cgColor]
            v.locations = [0.0, 1.0]
        })
        settingsImage = UIImage(named:"settings3")
        infoImage = UIImage(named: "infoIconW")
        accountButton = UIButton().then({ accountButton in
            view.addSubview(accountButton)
//            accountButton.backgroundColor = .red
            accountButton.setImage(infoImage, for: .normal)
            accountButton.addTarget(self, action: #selector(goToAccountData), for: .touchUpInside)
            accountButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
                make.left.equalTo(20)
                make.height.width.equalTo(50)
                
            }
        })
        
        partyButton = UIButton().then({ partyButton in
            view.addSubview(partyButton)
            partyButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            partyButton.backgroundColor = .clear
//            partyButton.setTitle("Go", for: .normal)
            
            partyButton.addTarget(self, action: #selector(goToParty), for: .touchUpInside)
            partyButton.snp.makeConstraints { make in
                make.top.equalTo(accountButton.snp.bottom).offset(30)
                make.left.equalTo(20)
                make.height.equalTo(60)
                make.width.equalTo(60)
            }
        })
        
//        view.backgroundColor = blueDark
        statisticButton = UIButton().then({ statisticButton in
            view.addSubview(statisticButton)
            statisticButton.setImage(settingsImage, for: .normal)
//            statisticButton.imageView?.contentMode = .scaleAspectFit
//            statisticButton.backgroundColor = .green
            statisticButton.addTarget(self, action: #selector(goToStatistic), for: .touchUpInside)
            statisticButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
                make.right.equalToSuperview().inset(20)
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
        })
        
        
        ethernetButton = UIButton().then({ ethernetButton in
            view.addSubview(ethernetButton)
            ethernetButton.backgroundColor = .red
            ethernetButton.addTarget(self, action: #selector(goToEthernet), for: .touchUpInside)
            ethernetButton.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(20)
                make.width.equalTo(50)
                make.height.equalTo(50)
                make.bottom.equalToSuperview().inset(50)
            }
        })
        
            
        descriptioTextView = UILabel().then({ label in
            view.addSubview(label)
            let textMessage = "Yes or No?"
            label.text = textMessage
            label.sizeToFit()
            label.textColor = .white
            label.font = UIFont.monospacedDigitSystemFont(ofSize: 48, weight: .thin)
            label.textAlignment = .center
            
            label.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(180)
                make.centerX.equalToSuperview()
//                make.centerY.equalToSuperview()
            }
        })
        
        yesOrNoButton = UIButton().then({ button in
            view.addSubview(button)
            button.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
            button.backgroundColor = buttonColor
//            button.layer.cornerRadius = 8
            button.setTitle("Tap Me", for: .normal)
            button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .thin)
            button.addTarget(self, action:#selector(buttonTapped) , for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(descriptioTextView.snp.bottom).offset(50)
                make.centerX.equalToSuperview()
                make.height.equalTo(120)
                make.width.equalTo(120)
            
            }
        })
        
      
        
        

        

    }

}
