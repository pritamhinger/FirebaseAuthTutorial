//
//  ResetPasswordViewController.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 14/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func resetPassword(_ sender: Any) {
        if emailTextField.text == ""{
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email address", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else{
            FIRAuth.auth()?.sendPasswordReset(withEmail: emailTextField.text!){ (error) in
                var title = ""
                var message = ""
                if error != nil{
                    title = "Error"
                    message = (error?.localizedDescription)!
                }
                else{
                    title = "Success!"
                    message = "Password reset mail set to \(self.emailTextField.text!)"
                    self.emailTextField.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
