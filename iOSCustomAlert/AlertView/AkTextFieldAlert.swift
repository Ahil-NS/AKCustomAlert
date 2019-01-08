//
//  AkTextFieldAlert.swift
//  iOSCustomAlert
//
//  Created by MacBook on 1/8/19.
//  Copyright © 2019 Ahil. All rights reserved.
//

import UIKit

class AkTextFieldAlert: UIView {
    
    private lazy var inputTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Text Here"
        tf.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tf.borderStyle = .none
        let paddingView = UIView()
        paddingView.frame = CGRect(origin: .zero, size: CGSize(width: 20, height: 40))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tf
    }()
    
    private lazy var actionButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("OK", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = #colorLiteral(red: 0.8010929823, green: 0.1427796483, blue: 0.08222163469, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    private lazy var titleLabel:UILabel = {
        var lbl = UILabel()
        lbl.text = "Enter title here"
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private lazy var closeButton:UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "close_btn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViewAlert()
        self.backgroundColor?.withAlphaComponent(0.5)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func layoutViewAlert(){
        
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        containerView.layer.cornerRadius = 9
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(inputTextField)
        mainStack.addArrangedSubview(actionButton)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(containerView)
        
    
     
        containerView.addSubview(mainStack)
        
        containerView.addSubview(closeButton)
        NSLayoutConstraint.activate([closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
                                     closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
                                     closeButton.heightAnchor.constraint(equalToConstant: 25),
                                     closeButton.widthAnchor.constraint(equalToConstant: 25)])
        
        
        NSLayoutConstraint.activate([containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
                                     containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
            ])
        
        
        NSLayoutConstraint.activate([mainStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     mainStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                                     mainStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
                                     mainStack.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.9),
                                     ])
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: mainStack.widthAnchor),
            inputTextField.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.8),
            actionButton.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9)
            ])
    }
    
    func showAlert(in parentView:UIView, addTitle title:String,addMsg message:String){
        
        
                self.frame = parentView.frame
        //parentView.frame = self.frame
                parentView.addSubview(self)
        
        
//
//        parentView.addSubview(self)
//        parentView.frame = self.frame
        
        titleLabel.text = title
        inputTextField.text = message
    }
}
