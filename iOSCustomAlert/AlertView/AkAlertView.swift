//
//  AkAlertView.swift
//  iOSCustomAlert
//
//  Created by Ahil on 1/7/19.
//  Copyright © 2019 Ahil. All rights reserved.
//

import UIKit

class AkAlertView: UIView {
    
    private let titleLabel:UILabel = {
       let lbl = UILabel()
        lbl.text = "Title of Alert"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let messageLabel:UILabel = {
       let lbl = UILabel()
        lbl.text = "Message of Label"
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    private lazy var okButton:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        btn.setTitle("OK", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private lazy var cancelButton:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        btn.setTitle("CANCEL", for: .normal)
        return btn
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCustomLayoutSubViews()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addCustomLayoutSubViews(){
        
        let alertContainer = UIView()
        alertContainer.clipsToBounds = true
        alertContainer.layer.cornerRadius = 9
        alertContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        alertContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 1
        buttonStackView.alignment = .fill
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.addArrangedSubview(okButton)
        buttonStackView.addArrangedSubview(cancelButton)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(messageLabel)
        mainStackView.addArrangedSubview(buttonStackView)
        
        self.addSubview(alertContainer)
        alertContainer.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.leadingAnchor.constraint(equalTo:alertContainer.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor),
                                     mainStackView.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor),
                                     mainStackView.topAnchor.constraint(equalTo: alertContainer.topAnchor)
            ])
        
        NSLayoutConstraint.activate([alertContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     alertContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     alertContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
                                     alertContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([titleLabel.heightAnchor.constraint(equalToConstant: 30),
                                     titleLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.9),
                                     messageLabel.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 0.9),
                                     buttonStackView.heightAnchor.constraint(equalToConstant: 40),
                                     buttonStackView.widthAnchor.constraint(equalTo: alertContainer.widthAnchor, multiplier: 1 )
            ])
        
    }
    
    func showAlert(in targetView:UIView, with title:String, _ alertMessage:String){
        
        targetView.addSubview(self)
        self.frame = targetView.bounds
        
        titleLabel.text = title.capitalized
        messageLabel.text = alertMessage
    }
    
    
}
