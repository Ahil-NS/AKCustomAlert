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
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let alertView = AkAlertView()
        alertView.showAlert(in: self.view, with: "Alert Title Here", "Alert Message here")
    }


}

