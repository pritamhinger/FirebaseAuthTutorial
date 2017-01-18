//
//  CommonFunctions.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 18/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import Foundation

extension FirebaseLoginHelper{
    
    func saveLoggedInUser(user:User) {
        let userDefault = UserDefaults.standard;
        let userData = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefault.set(userData, forKey: "LoggedInUser")
        userDefault.synchronize()
    }
    
    func getLoggedInUser() -> User? {
        let userDefault = UserDefaults.standard;
        let userData = userDefault.value(forKey: "LoggedInUser") as! Data
        if let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User{
            return user
        }
        
        return nil
    }
}
