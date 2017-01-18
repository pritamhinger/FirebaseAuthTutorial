//
//  Constants.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 18/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import Foundation

class AppConstants {
    
    class func sharedInstance() -> AppConstants{
        struct Singleton{
            static var instance = AppConstants()
        }
        
        return Singleton.instance
    }
    
    struct UserPropertyNames {
        static let EmailAddress = "emailAddress"
        static let DisplayName = "displayName"
        static let IsEmailVerified = "isEmailVerified"
        static let IsAnonymous = "isAnonymous"
        static let PhotoURL = "photoURL"
        static let AuthProvider = "authProvider"
        static let ProviderId = "providerId"
        static let FirebaseUserId = "firebaseUserId"
    }
}
