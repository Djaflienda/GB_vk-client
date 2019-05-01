//
//  AuthService.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 25/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiseShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject {

    //MARK: -Properties
    
    private let appID = "6960783"
    private let vkSDK: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    //MARK: -Init
    
    override init() {
        self.vkSDK = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if let _ = error {
                print("There is an error occured during authorization!")
                delegate?.authServiceDidSignInFail()
            }
            if state == .authorized {
                print("VKAuthorizationState.authorized")
                delegate?.authServiceSignIn()
            } else {
                print("VKAuthorizationState.initialized, i.e Auth needed")
                VKSdk.authorize(scope)
            }
        }
    }
}

extension AuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        guard let _ = result.token else { return }
        self.delegate?.authServiceSignIn()
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
}

extension AuthService: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        self.delegate?.authServiseShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
