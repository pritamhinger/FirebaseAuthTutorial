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
                        if let displayUserName = firebaseUser.displayName{
                            print(displayUserName)
                        }
                        
                        if let email = firebaseUser.email{
                            print(email)
                        }
                        
                        print(firebaseUser.isAnonymous)
                        if let url = firebaseUser.photoURL{
                            print(url)
                        }
                        
                        print(firebaseUser.isEmailVerified)
                        print(firebaseUser.providerID)
                        print(firebaseUser.uid)
                        
                    }
                    print("You have successfully logged in.")
                    let loggedInUser = User()
                    loggedInUser.emailAddress = self.emailTextField.text!
                    loggedInUser.authProvider = AuthProvider.EmailAddress
                    loggedInUser.userName = self.emailTextField.text!
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
