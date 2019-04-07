//
//  ViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 06/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: -Handlers
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(destinationVC, animated: true, completion: nil)
    }
}

