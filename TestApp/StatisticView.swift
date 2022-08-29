//
//  StatisticView.swift
//  TestApp
//
//  Created by Nikita Kurochka on 08.06.2022.
//

import UIKit

class StatisticView: UIViewController {
    
    var TitleLabel: UILabel!
    var YesTittleLabel: UILabel!
    var NoTittleLabel: UILabel!
    var PercentOfYes: UILabel!
    var PercentOfNo: UILabel!
    var ResetButton: UIButton!
    var yesData = AppData.shared.readValue(forKey: "yesCounter")
    var noData = AppData.shared.readValue(forKey: "noCounter")
    var gradientLayer: CAGradientLayer!
    var darkColor = UIColor(named: "StatisticGradient1")
    var cyanColor = UIColor(named: "StatisticGradient2")
    var percentDropOfYes = AppData.shared.countPercent(forKey: "yesCounter")
    var percentDropOfNo = AppData.shared.countPercent(forKey: "noCounter")
    var allTaps = AppData.shared.allTaps()
    var percentYes: CircularProgressView!
    var percentNo: CircularProgressView!
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = true
        
        gradientLayer = CAGradientLayer().then({ v in
            self.view.layer.addSublayer(v)
            v.colors = [darkColor!.cgColor,cyanColor!.cgColor]
            v.locations = [0.0, 1.0]
        })
        
        TitleLabel = UILabel().then({ titlelabel in
            view.addSubview(titlelabel)
            titlelabel.text = "Statistic"
            titlelabel.alpha = 0;
            titlelabel.textColor = .black
            titlelabel.font = UIFont.monospacedDigitSystemFont(ofSize: 40, weight: .light)
            titlelabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(100)
                make.centerX.equalToSuperview()
            }
        })
        YesTittleLabel = UILabel().then({ yesTittle in
            view.addSubview(yesTittle)
            yesTittle.sizeToFit()
            yesTittle.text = "Dropped Yes: "
            yesTittle.textColor = .black
            yesTittle.font = UIFont.monospacedDigitSystemFont(ofSize: 28, weight: .thin)
            yesTittle.snp.makeConstraints { make in
                make.top.equalTo(TitleLabel).offset(90)
                make.left.equalToSuperview().offset(30)
            }
        })
//        NoTittleLabel = UILabel().then({ noTittle in
//            view.addSubview(noTittle)
//            noTittle.sizeToFit()
//            noTittle.text = "Dropped No: \(String(noData))"
//            noTittle.textColor = .black
//            noTittle.font = UIFont.monospacedDigitSystemFont(ofSize: 28, weight: .thin)
//            noTittle.snp.makeConstraints { make in
//                make.top.equalTo(YesTittleLabel).offset(50)
//                make.left.equalToSuperview().offset(30)
//            }
//        })
        percentYes = CircularProgressView(innerColor: .gray, outerColor: .red).then { progress in
            view.addSubview(progress)
            progress.trackLayer.strokeEnd = 0
            progress.snp.makeConstraints { make in
                make.top.equalTo(YesTittleLabel.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(150)
            }
            
        }
                PercentOfYes = UILabel().then({ percentOfYes in
                    percentYes.addSubview(percentOfYes)
                    percentOfYes.sizeToFit()
                    percentOfYes.text = "Load"
                    percentOfYes.font = UIFont.monospacedDigitSystemFont(ofSize: 28, weight: .thin)
                    percentOfYes.snp.makeConstraints { make in
                        make.centerX.centerY.equalToSuperview()
                    }
        
                })
        
        
       
        
            
        
        
//        shapeLayer = CircularProgressView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
//        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
//        shapeLayer.strokeEnd = 0
        
        
        


        NoTittleLabel = UILabel().then({ NoTittleLabel in
            view.addSubview(NoTittleLabel)
            NoTittleLabel.sizeToFit()
            NoTittleLabel.text = "Drop percent of No:"
            NoTittleLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 28, weight: .thin)
            NoTittleLabel.snp.makeConstraints { make in
                make.top.equalTo(percentYes).offset(170)
                make.left.equalToSuperview().offset(30)

            }
        })
        

        
//  circularView of percent no
        
//        percentNo = CircularProgressView(frame: <#T##CGRect#>, innerColor: <#T##UIColor#>, outerColor: <#T##UIColor#>)
        
        percentNo = CircularProgressView(innerColor: .gray, outerColor: .red).then({ progress in
            view.addSubview(progress)
            progress.trackLayer.strokeEnd = 0
            progress.snp.makeConstraints { make in
                make.top.equalTo(NoTittleLabel.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(150)
            }
            
        })
        
        PercentOfNo = UILabel().then({ percentOfNo in
            percentNo.addSubview(percentOfNo)
            percentOfNo.sizeToFit()
            percentOfNo.text = "Load"
            percentOfNo.font = UIFont.monospacedDigitSystemFont(ofSize: 28, weight: .thin)
            percentOfNo.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
        })
//        ResetButton = UIButton().then({ resetButton in
//            view.addSubview(resetButton)
//
//            resetButton.setTitle("Reset", for: .normal)
//            resetButton.backgroundColor = .darkGray
//
//            resetButton.snp.makeConstraints { make in
//                make.top.equalTo(PercentOfNo).offset(100)
//                make.centerX.equalToSuperview()
//                make.width.equalTo(80)
//                make.height.equalTo(50)
//            }
//        })
        
        loadAnimation()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
//
    }
//
    func showPercent(){
        percentYes.trackLayer.strokeEnd = 0
        percentNo.trackLayer.strokeEnd = 0
        DispatchQueue.main.async {
            let yesPercentValue = self.percentDropOfYes.isNaN ? 0.0 : self.percentDropOfYes
            let noPercentValue = self.percentDropOfNo.isNaN ? 0.0 : self.percentDropOfYes
            self.PercentOfYes.text = "\(Int(yesPercentValue * 100))%"
            self.PercentOfNo.text = "\(Int(noPercentValue * 100))%"
            self.percentYes.trackLayer.strokeEnd = CGFloat(self.percentDropOfYes)
            self.percentNo.trackLayer.strokeEnd = CGFloat(self.percentDropOfNo)
        }
    }
    
//    fileprivate func animateCircle() {
//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        basicAnimation.toValue = 1
//        basicAnimation.duration = 2
//        basicAnimation.fillMode = .forwards
//        basicAnimation.isRemovedOnCompletion = false
//        shapeLayer.add(basicAnimation, forKey: "basicFill")
//    }
//
    @objc func handleTap () {
        print("i pushed")
        showPercent()
//        animateCircle()
    }

    func loadAnimation(){
        self.TitleLabel.alpha = 0
        self.YesTittleLabel.alpha = 0
        self.PercentOfYes.alpha = 0
        self.percentYes.alpha = 0
        self.NoTittleLabel.alpha = 0
        self.PercentOfNo.alpha = 0
        self.percentNo.alpha = 0
        UIView.animate(withDuration: 0.65) {
            self.TitleLabel.alpha = 1
        }
        UIView.animate(withDuration: 0.85) {
            self.YesTittleLabel.alpha = 1
        }
        UIView.animate(withDuration: 1.05) {
            self.PercentOfYes.alpha = 1
            self.percentYes.alpha = 1
        }
        UIView.animate(withDuration: 1.25) {
            self.NoTittleLabel.alpha = 1
        }
        UIView.animate(withDuration: 1.45) {
            self.PercentOfNo.alpha = 1
            self.percentNo.alpha = 1
        }
    }
}

