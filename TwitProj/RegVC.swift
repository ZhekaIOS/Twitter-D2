//
//  RegVC.swift
//  TwitProj
//
//  Created by Zhekon on 26.04.2018.
//  Copyright © 2018 Yacir. All rights reserved.
//

import UIKit
import TwitterKit

class RegVC: UIViewController {
    
    @IBAction func regButton(_ sender: UIButton) {
        TWTRTwitter.sharedInstance().logIn { session, error in}

    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }



}
