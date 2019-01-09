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
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
    
    //Check this
    @objc private func okButtonPressed(_ sender:UIButton){
        
        hide { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc private func cancelButtonPressed(_ sender:UIButton){
        hide { _ in
            self.removeFromSuperview()
        }
        
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
    
    func showAlert(in targetView:UIView, with title:String, _ alertMessage:String, _ alertType:AkAlertType, perform buttonAction: ((AkAlertAction)-> Void)? = nil) {
        
        titleLabel.text = title.capitalized
        messageLabel.text = alertMessage
        
        
        self.frame = targetView.bounds
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        self.alpha = 0
        targetView.addSubview(self)
        
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.transform = .identity
            
        }, completion: nil)
        
        //Add ok or OK and Cancel Button to Alert View
        cancelButton.isHidden = alertType == .single ? true : false
        
        
        guard let _buttonAction = buttonAction else{
            
            //fatalError("fatal error")
            if alertType == .single || alertType == .multi {
                okButton.addTarget(self, action: #selector(okButtonPressed(_:)), for: .touchUpInside)
            }
            if alertType == .multi{
                cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
            }
            return
        }
        
        if(alertType == .single || alertType == .multi){
            okButton.addtargetClouser { [weak self]_ in
                self?.hide({ _ in
                    _buttonAction(.ok)
                })
            }
        }
        
        if alertType == .multi{
            cancelButton.addtargetClouser { [weak self]_ in
                self?.hide({ _ in
                    _buttonAction(.cancel)
                })
            }
        }
    }
    
    func hide(_ completed:@escaping(Bool)->Void){
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (isCompleted) in
            completed(isCompleted)
        }
    }
    
    enum AkAlertType {
        case single
        case multi
    }
    
    enum AkAlertAction {
        case ok
        case cancel
    }
    
}

//MARK:- SUPPORT EXTENSION AND TYPEALISE FOR UIBUTTON CLOUSER ACTION
typealias UIButtonTargetClouser = (UIButton) -> ()

extension UIButton{
    private struct AssociateKeys{
        static var teargetClouser = "targetClouser"
    }
    
    private var targetClouser:UIButtonTargetClouser?{
        get{
            guard let clouserWrapped = objc_getAssociatedObject(self, &AssociateKeys.teargetClouser) as? ClouserWrapped else{return nil}
            return clouserWrapped.clouser
        }
        set{
            guard let _newVal = newValue else{return}
            objc_setAssociatedObject(self, &AssociateKeys.teargetClouser, ClouserWrapped(_newVal), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addtargetClouser(clouser:@escaping UIButtonTargetClouser){
        targetClouser = clouser
        addTarget(self, action: #selector(UIButton.clouserAction), for: .touchUpInside)
    }
    
    @objc func clouserAction(){
        guard let _targetClouser = targetClouser else {return}
        _targetClouser(self)
    }
}
class ClouserWrapped:NSObject{
    let clouser:UIButtonTargetClouser
    init(_ clouser:@escaping UIButtonTargetClouser) {
        self.clouser = clouser
    }
}


