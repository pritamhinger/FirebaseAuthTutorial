//
//  LoginViewController.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 14/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func login(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == ""{
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                if error == nil{
                    if let firebaseUser = user! as FIRUser!{
                        let loggedInUser = User(firebaseUser: firebaseUser, authProvider: AuthProvider.EmailAddress)
                        print(loggedInUser)
                        FirebaseLoginHelper.sharedInstance.saveLoggedInUser(user: loggedInUser)
                    }
                    print("You have successfully logged in.")
                    
                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(homeViewController!, animated: true, completion: nil)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
