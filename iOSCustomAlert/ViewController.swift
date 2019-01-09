//
//  ViewController.swift
//  iOSCustomAlert
//
//  Created by MacBook on 1/7/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AkAlertTextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func singleAlertButtonPressed(_ sender: UIButton) {
        let alertView = AkAlertView()
        alertView.showAlert(in: self.view, with: "Enter Title Her", "Enter Message Here", .single) { (tappedButton) in
            guard tappedButton == .ok else{ return}
            print("OK Button Clicked")
        }
    }
    
    @IBAction func multiAlertButtonPressed(_ sender: UIButton) {
        let alertView = AkAlertView()
        alertView.showAlert(in: self.view, with: "Enter Title Her", "Enter Message Here", .multi) { (tappedButton) in
            guard tappedButton == .ok else{ return}
            print("OK Button Clicked")
        }
    }
    
    @IBAction func TextFieldAlertButtonPressed(_ sender: UIButton) {
        let alert = AkTextFieldAlert(frame: self.view.bounds)
        alert.titleText = "Enter Title Here"
        alert.actionButtonTitleText = "SignIn"
        alert.textFieldPlaceHolderText = "Enter User Name"
        alert.show(in: self.view)
        alert.delegate = self
    }
    
    func userTappedAcceptButton(with textFieldText: String?) {
        guard let userName = textFieldText else{return}
        print("User Name : ", userName)
    }
    
}

