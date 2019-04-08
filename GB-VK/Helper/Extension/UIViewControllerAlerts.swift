//
//  UIViewControllerAlerts.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 08/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showNewGroupCreationAlert() {
        let alert = UIAlertController(title: "Coming soon..", message: "This functionality will be available in next releases", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
