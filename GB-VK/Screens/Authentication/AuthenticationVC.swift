//
//  ViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 06/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    //MARK: -Properties
    
    private var authService: AuthService! = AppDelegate.shared().authService
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -Handlers
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

