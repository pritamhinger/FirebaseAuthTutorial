//
//  HomeViewController.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 14/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var logInStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = FirebaseLoginHelper.sharedInstance.getLoggedInUser(){
            logInStatus.text = "Welcome, \(user.emailAddress)"
        }
        else{
            logInStatus.text = "Welcome, Anonymous User"
        }
    }

    // MARK: - IBActions
    @IBAction func logout(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {
            do{
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginProvider")
                present(vc, animated: true, completion: nil)
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
}
