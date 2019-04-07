//
//  LoginViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 06/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

struct Credentials {
    static fileprivate let login: String = "admin"
    static fileprivate let password: String = "123456"
}

class LoginViewController: UIViewController {

    //MARK: -@IBOutlet
    
    @IBOutlet private weak var logo: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    //MARK: -Properties
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = false
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        print("LoginViewController is deallocated")
    }

    //MARK: -Handlers
    
    @objc private func keyboardWasShown(_ notification: Notification) {
        logo.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        let bottomOffset = CGPoint(x: 0, y: 100)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }

    @objc private func keyboardWillBeHidden(_ notification: Notification) {
        logo.transform = .identity
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets

        scrollView.bounds = CGRect(x: 0.0, y: 0.0, width: scrollView.bounds.width, height: scrollView.bounds.height)
    }
    
    @objc private func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        loginTextField.text = "admin"
        passwordTextField.text = "123456"
        guard let login = loginTextField.text, !login.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {return}
        
        if login == Credentials.login && password == Credentials.password {
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            present(destinationVC, animated: true, completion: nil)
        } else {
            print("Login fail")
        }
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
