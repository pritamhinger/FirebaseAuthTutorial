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
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate, GIDSignInDelegate {

    // MARK: - IBoutlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        //GIDSignIn.sharedInstance().signIn()
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile","email","user_friends"]
        signInButton.colorScheme = GIDSignInButtonColorScheme.light
        signInButton.style = GIDSignInButtonStyle.standard
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
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil{
            print("Token from FB is \(result.token.tokenString)")
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            FIRAuth.auth()?.signIn(with: credential){ (user, error) in
                if let error = error{
                    print(error.localizedDescription)
                    FBSDKLoginManager().logOut()
                    return;
                }
                else{
                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(homeViewController!, animated: true, completion: nil)
                }
            }
        }
        else{
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        FBSDKLoginManager().logOut()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        print(credential.provider)
        
        FIRAuth.auth()?.signIn(with: credential){ (user, error) in
            if let error = error{
                print(error.localizedDescription)
                GIDSignIn().signOut()
                return
            }
            else{
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.present(homeViewController!, animated: true, completion: nil)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        GIDSignIn().signOut()
    }
}
