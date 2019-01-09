//
//  AkTextFieldAlert.swift
//  iOSCustomAlert
//
//  Created by MacBook on 1/8/19.
//  Copyright © 2019 Ahil. All rights reserved.
//

import UIKit

protocol AkAlertTextFieldDelegate{
    func userTappedAcceptButton(with textFieldText:String?)
}

class AkTextFieldAlert: UIView {
    
    var textFieldPlaceHolderText:String = "Place holder"{
        didSet{
            inputTextField.placeholder = textFieldPlaceHolderText
        }
    }
    
    var titleText:String = "Title"{
        didSet{
            titleLabel.text = titleText
        }
    }
    
    var actionButtonTitleText:String = "OK"{
        didSet{
            actionButton.setTitle(actionButtonTitleText, for: .normal)
        }
    }
    
    private lazy var titleLabel:UILabel = {
        var lbl = UILabel()
        lbl.text = "Enter title here"
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private lazy var inputTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Text Here"
        tf.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.borderStyle = .none
        let paddingView = UIView()
        paddingView.frame = CGRect(origin: .zero, size: CGSize(width: 20, height: 40))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tf
    }()
    
    var delegate: AkAlertTextFieldDelegate?
    
    private lazy var actionButton:UIButton = {
        let btn = UIButton()
        btn.setTitle(actionButtonTitleText, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = #colorLiteral(red: 0.8010929823, green: 0.1427796483, blue: 0.08222163469, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    @objc func acceptButtonPressed(){
        delegate?.userTappedAcceptButton(with: inputTextField.text)
        remove()
    }
    
    private lazy var closeButton:UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "close_btn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(remove), for: .touchUpInside)
        return btn
    }()
    
    @objc func closeButtonPressed(){
        animateAlert(toShow: false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(in view:UIView){
        showAlert(in: view)
        animateAlert(toShow: true)
    }
    
    @objc private func remove(){
        self.endEditing(true)
        animateAlert(toShow: false)
    }
    func showAlert(in parentView:UIView){
        
        self.alpha = 0
        
        parentView.addSubview(self)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
                                         self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor),
                                         self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                                         self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
                ])
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: parentView.topAnchor),
                                         self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                                         self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                                         self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
                ])
            
        }
        
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        containerView.layer.cornerRadius = 9
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(containerView)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
                                     containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
            ])
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(inputTextField)
        mainStack.addArrangedSubview(actionButton)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([mainStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     mainStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                                     mainStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
                                     mainStack.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.9),
                                     ])
        
        
        containerView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
                                     closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
                                     closeButton.heightAnchor.constraint(equalToConstant: 25),
                                     closeButton.widthAnchor.constraint(equalToConstant: 25)])
        
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: mainStack.widthAnchor),
            inputTextField.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.8),
            actionButton.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9)
            ])
        
    }
    
    func animateAlert(toShow isShow:Bool){
        var transformTo:CGAffineTransform!
        var duration:Double!
        var alphaTo:CGFloat!
        
        switch isShow {
        case true:
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            transformTo = .identity
            duration = 0.3
            alphaTo = 1
        case false:
            transformTo = CGAffineTransform(scaleX: 1.1, y: 1.1)
            duration = 0.2
            alphaTo = 0
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = transformTo
            self.alpha = alphaTo
        }) { _ in
            guard !isShow else{return}
            self.removeFromSuperview()
        }
    }
    
}
