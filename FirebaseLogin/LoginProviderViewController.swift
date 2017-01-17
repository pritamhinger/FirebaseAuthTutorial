//
//  LoginProviderViewController.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 17/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class LoginProviderViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate, GIDSignInDelegate {
    @IBOutlet weak var signInButton: GIDSignInButton!

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile","email","user_friends"]
        signInButton.colorScheme = GIDSignInButtonColorScheme.light
        signInButton.style = GIDSignInButtonStyle.standard
    }

    // MARK: - Facebook SignIn Methods
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
    
    // MARK: - Google SignIn Methods
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
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.present(homeViewController!, animated: true, completion: nil)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        GIDSignIn().signOut()
    }
}
