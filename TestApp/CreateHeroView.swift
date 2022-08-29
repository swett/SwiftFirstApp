//
//  CreateHeroView.swift
//  TestApp
//
//  Created by Nikita Kurochka on 11.07.2022.
//

import UIKit

class CreateHeroView: UIViewController,UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UITextViewDelegate, UIColorPickerViewControllerDelegate {

    var textLabel: UILabel!
    var imageView: UIImageView!
    var photoButton: UIButton!
    var descripttionLabel: UILabel!
    var descriptionText: UITextView!
    var scrollView: UIScrollView!
    var contentView: UIView!
    var pidorItem = PidorItem()
    var presentColor : UIView!
    var roflLabel: UILabel!
    var buttonSave: UIButton!
    var chooseColorLabel: UILabel!
    var chooseColorButton: UIButton!
    var gradientLayer: CAGradientLayer!
    var darkColor = UIColor(named: "StatisticGradient1")
    var cyanColor = UIColor(named: "StatisticGradient2")
    var activeTextView: UITextView? = nil
    
    
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = self.view.bounds
        imageView.layer.cornerRadius = 10
        imageView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        imageView.layer.shadowRadius = 6
        imageView.layer.shadowOffset = .init(width: 0, height: 6)
        imageView.layer.shadowOpacity = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isTranslucent = true
        NotificationCenter.default.addObserver(self, selector: #selector(CreateHeroView.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateHeroView.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        gradientLayer = CAGradientLayer().then({ v in
            self.view.layer.addSublayer(v)
            v.colors = [darkColor!.cgColor,cyanColor!.cgColor]
            v.locations = [0.0, 1.0]
        })
        
        scrollView = UIScrollView().then({ scroll in
            view.addSubview(scroll)
//            scroll.backgroundColor = .red
            scroll.delegate = self
            scroll.isScrollEnabled = true
            scroll.frame = view.bounds
            scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 400)
            scroll.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            
            }
        })
        
        contentView = UIView().then({ view in
            scrollView.addSubview(view)
//            view.backgroundColor =
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.centerX.equalToSuperview()
            }
        })
        
        textLabel = UILabel().then({ label in
            contentView.addSubview(label)
            label.text = "Create Your Idiot"
            label.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: .thin)
            label.numberOfLines = 0
            label.snp.makeConstraints { make in
                make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
                make.centerX.equalToSuperview()
                
            }
        })
    
        imageView = UIImageView().then({ imageView in
            contentView.addSubview(imageView)
//            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "defPhoto")
            imageView.snp.makeConstraints { make in
                make.top.equalTo(textLabel.snp.bottom).offset(20)
                make.left.right.equalToSuperview()
                make.height.equalTo(300)
            }
        })
        
        photoButton = UIButton().then({ button in
            contentView.addSubview(button)
            button.setTitle("Chose photo", for: .normal)
            button.backgroundColor = .darkGray.withAlphaComponent(0.7)
            button.layer.cornerRadius = 10
            button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .thin)
            button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.width.equalTo(150)
                make.height.equalTo(50)
            }
        })
        
        descripttionLabel = UILabel().then({ descripttionLabel in
            contentView.addSubview(descripttionLabel)
            descripttionLabel.text = "Input Name Of Your Hero:"
            descripttionLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: .thin)
            descripttionLabel.numberOfLines = 0
            descripttionLabel.snp.makeConstraints { make in
                make.top.equalTo(photoButton.snp.bottom).offset(10)
                make.left.equalToSuperview().inset(10)
                
            }
        })
        descriptionText = UITextView().then({ textview in
            contentView.addSubview(textview)
            textview.backgroundColor = .white
            textview.textAlignment = .left
            textview.layer.cornerRadius = 10
            textview.font = .monospacedDigitSystemFont(ofSize: 18, weight: .thin)
            textview.delegate = self
            textview.isEditable = true
            textview.keyboardType = .default
            textview.text = "placeholder"
            textview.textColor = .lightGray
            textview.delegate = self
            textview.layer.borderWidth = 1
            textview.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
            textview.snp.makeConstraints { make in
                make.top.equalTo(descripttionLabel.snp.bottom).offset(10)
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(150)
            }
        })
        
        chooseColorLabel = UILabel().then({ colorLabel in
            contentView.addSubview(colorLabel)
            colorLabel.text = "Chose Color:"
            colorLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: .thin)
            colorLabel.numberOfLines = 0
            colorLabel.snp.makeConstraints { make in
                make.top.equalTo(descriptionText.snp.bottom).offset(10)
                make.left.equalToSuperview().inset(10)
                
            }
        })
        
        chooseColorButton = UIButton().then({ colorButton in
            contentView.addSubview(colorButton)
            colorButton.setTitle("Color", for: .normal)
            colorButton.backgroundColor = .darkGray.withAlphaComponent(0.7)
            colorButton.layer.cornerRadius = 10
            colorButton.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .thin)
            colorButton.addTarget(self, action: #selector(didTapSelectColor), for: .touchUpInside)
            colorButton.snp.makeConstraints { make in
                make.top.equalTo(chooseColorLabel.snp.bottom).offset(20)
                make.left.equalToSuperview().inset(10)
                make.height.equalTo(50)
                make.width.equalTo(150)
//                make.bottom.equalToSuperview()
            }
        })
        
        presentColor = UIView().then({ presentColor in
            contentView.addSubview(presentColor)
            presentColor.backgroundColor = .white
            presentColor.layer.cornerRadius = 10
            presentColor.layer.borderWidth = 1
            presentColor.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
            presentColor.snp.makeConstraints { make in
                make.top.equalTo(chooseColorLabel.snp.bottom).offset(20)
                make.right.equalToSuperview().inset(10)
                make.height.equalTo(50)
                make.width.equalTo(150)
            }
        })
        
        roflLabel = UILabel().then({ rofl in
            contentView.addSubview(rofl)
            rofl.font = UIFont.monospacedDigitSystemFont(ofSize: 25, weight: .thin)
            rofl.text = ""
            rofl.numberOfLines = 0
            rofl.snp.makeConstraints { make in
                make.top.equalTo(chooseColorButton.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
            }
            
        })
        
        buttonSave = UIButton().then({ button in
            contentView.addSubview(button)
            button.setTitle("Save", for: .normal)
            button.backgroundColor = .darkGray.withAlphaComponent(0.7)
            button.layer.cornerRadius = 10
            button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .thin)
            button.addTarget(self, action: #selector(createEblan), for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(roflLabel.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
                make.height.equalTo(50)
                make.width.equalTo(150)
                make.bottom.equalToSuperview().inset(20)
            }
        })

    }
    
    
    @objc func createEblan() {
        UIView.animate(withDuration: 0.1) {
            self.buttonSave.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            UIView.animate(withDuration: 0.1) {
                self.buttonSave.transform = .identity
            }
        }
        
        if descriptionText.textColor != UIColor.lightGray && imageView.image != UIImage(named: "defPhoto") && self.pidorItem.color != nil{
            
            self.pidorItem.image = imageView.image?.jpegData(compressionQuality: 0.5)
            self.pidorItem.text = descriptionText.text
            print("saved")
            print(self.pidorItem.color)
            AppData.shared.pidorsArray.append(pidorItem)
            AppData.shared.saveData()
            
            imageView.image = UIImage(named: "defPhoto")
            descriptionText.text = "placeHolder"
            presentColor.backgroundColor = .white
            roflLabel.text = ""
        } else {
            
            showSimpleAlert()
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      var shouldMoveViewUp = false
        if let activeTextView = activeTextView {
            let bottomOfTextField = activeTextView.convert(activeTextView.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
      // move the root view up by the distance of keyboard height
        if shouldMoveViewUp {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
      
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    func showSimpleAlert() {
            
        let alert = UIAlertController(title: "Кончене?", message: "Ти чого нічого не написав і не обрав фотку. Охуїв?",         preferredStyle: UIAlertController.Style.alert)

       let yesAction = UIAlertAction(title: "Я кончене", style: .default) { (action) -> Void in
           self.roflLabel.text = "Я кончений лох"
    }
     
        let noAction = UIAlertAction(title: "Та я забув", style: .default) { (action) -> Void in
        self.roflLabel.text = "Забувашка"
    }
        alert.addAction(yesAction)
        alert.addAction(noAction)
       
        
            self.present(alert, animated: true, completion: nil)
        }
    
    @objc func didTapSelectColor (){
        UIView.animate(withDuration: 0.1) {
            self.chooseColorButton.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            UIView.animate(withDuration: 0.1) {
                self.chooseColorButton.transform = .identity
            }
        }
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        presentColor.backgroundColor = color
        self.pidorItem.color = color.encode()
        print(color)
    }
    
    
    @objc func showActionSheet(){
        UIView.animate(withDuration: 0.1) {
            self.photoButton.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            UIView.animate(withDuration: 0.1) {
                self.photoButton.transform = .identity
            }
        }
    //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
    actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
        print("Cancel")
    }
        actionSheetController.addAction(cancelActionButton)

        let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
    { action -> Void in
        self.camera()
    }
        actionSheetController.addAction(saveActionButton)

        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
    { action -> Void in
        self.gallery()
    }
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
}

    func camera(){
        let myPickerControllerCamera = UIImagePickerController()
        myPickerControllerCamera.delegate = self
        myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
        myPickerControllerCamera.allowsEditing = true
        self.present(myPickerControllerCamera, animated: true, completion: nil)

    }

    func gallery(){

        let myPickerControllerGallery = UIImagePickerController()
        myPickerControllerGallery.delegate = self
        myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerControllerGallery.allowsEditing = true
        self.present(myPickerControllerGallery, animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
            guard let selectedImage = info[.originalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            // Set photoImageView to display the selected image.
            imageView.image = selectedImage
            // Dismiss the picker.
            dismiss(animated: true, completion: nil)
        }

    func textViewDidBeginEditing(_ textView: UITextView) {
        self.activeTextView = textView
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
        self.activeTextView = nil
    }
    
}

