//
//  ViewController.swift
//  iOSCustomAlert
//
//  Created by MacBook on 1/7/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let alertView = AkAlertView()
//        alertView.showAlert(in: self.view, with: "Enter Title Her", "Enter Message Here", .multi) { (tappedButton) in
//            guard tappedButton == .ok else{ return}
//            print("yes bro ok clicked")
//
//        }

        let alert = AkTextFieldAlert(frame: self.view.bounds)
        alert.titleText = "Enter Title Here"
        alert.actionButtonTitleText = "SignIn"
        alert.textFieldPlaceHolderText = "Enter User Name"
        alert.show(in: self.view)
        
        
    }


}

