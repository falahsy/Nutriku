//
//  LoginVC.swift
//  Nutriku
//
//  Created by Syamsul Falah on 19/09/19.
//  Copyright © 2019 Falah. All rights reserved.
//

import UIKit
import LocalAuthentication

// The available states of being logged in or not.
enum AuthenticationState {
    case loggedin, loggedout
}

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    // An authentication context stored at class scope so it's available for use during UI updates.
    var context = LAContext()
    
    // The current authentication state.
    var state = AuthenticationState.loggedout {
        // Update the UI on a change.
        didSet {
            loginButton.isHighlighted = state == .loggedin  // The button text changes on highlight.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        state = .loggedout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        state = .loggedout
    }
    
    @IBAction func tapLoggin(_ sender: UIButton) {
        if state == .loggedin {
            state = .loggedout
        } else {
            context = LAContext()
            context.localizedCancelTitle = "Enter Username/Password"
            
            // First check if we have the needed hardware support.
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                
                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                    if success {
                        // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async { [unowned self] in
                            self.state = .loggedin
                            self.performSegue(withIdentifier: "toHomeSegue", sender: self)
                        }
                    } else {
                        print(error?.localizedDescription ?? "Failed to authenticate")
                        // Fall back to a asking for username and password.
                        // ...
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Can't evaluate policy")
                // Fall back to a asking for username and password.
                // ...
            }
        }
    }
}
