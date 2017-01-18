//
//  User.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 17/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import Foundation
import FirebaseAuth

public class User: NSObject, NSCoding {
    var emailAddress: String = ""
    var displayName:String = ""
    var isEmailVerified: Bool = false
    var isAnonymous:Bool = true
    //var photoURL:URL?
    //var authProvider: AuthProvider = AuthProvider.EmailAddress
    var providerId: String = ""
    var firebaseUserId: String = ""
    
    required public init?(coder aDecoder: NSCoder) {
        self.displayName = aDecoder.decodeObject(forKey: AppConstants.UserPropertyNames.DisplayName) as! String
        self.emailAddress = aDecoder.decodeObject(forKey: AppConstants.UserPropertyNames.EmailAddress) as! String
        self.isEmailVerified = aDecoder.decodeBool(forKey:AppConstants.UserPropertyNames.IsEmailVerified)
        self.isAnonymous = aDecoder.decodeBool(forKey:AppConstants.UserPropertyNames.IsAnonymous)
        self.providerId = aDecoder.decodeObject(forKey: AppConstants.UserPropertyNames.ProviderId) as! String
        self.firebaseUserId = aDecoder.decodeObject(forKey: AppConstants.UserPropertyNames.FirebaseUserId) as! String
        //self.authProvider = aDecoder.decodeObject(forKey: AppConstants.UserPropertyNames.AuthProvider) as!AuthProvider
        //self.photoURL = aDecoder.decodeObject(forKey: AppConstants.UserPropertyNames.PhotoURL) as? URL
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.displayName, forKey: AppConstants.UserPropertyNames.DisplayName)
        aCoder.encode(self.emailAddress, forKey: AppConstants.UserPropertyNames.EmailAddress)
        aCoder.encode(self.isEmailVerified, forKey: AppConstants.UserPropertyNames.IsEmailVerified)
        aCoder.encode(self.isAnonymous, forKey: AppConstants.UserPropertyNames.IsAnonymous)
        aCoder.encode(self.providerId, forKey: AppConstants.UserPropertyNames.ProviderId)
        aCoder.encode(self.firebaseUserId, forKey: AppConstants.UserPropertyNames.FirebaseUserId)
        //aCoder.encode(self.authProvider, forKey: AppConstants.UserPropertyNames.AuthProvider)
        //aCoder.encode(self.photoURL, forKey: AppConstants.UserPropertyNames.PhotoURL)
    }
    
    init(firebaseUser:FIRUser, authProvider:AuthProvider) {
        //self.authProvider = authProvider
        print(authProvider)
        if let displayUserName = firebaseUser.displayName{
            self.displayName = displayUserName
        }
        
        if let email = firebaseUser.email{
            self.emailAddress = email
        }
        
        self.isAnonymous = firebaseUser.isAnonymous
//        if let url = firebaseUser.photoURL{
//            self.photoURL = url
//        }
        
        self.isEmailVerified = firebaseUser.isEmailVerified
        self.firebaseUserId = firebaseUser.uid
        self.providerId = firebaseUser.providerID
        super.init()
    }
    
    public override var description: String{
        return "Email Address ==> \(emailAddress)\nDisplay Name ==> \(displayName)\nEmail Verified? ==> \(isEmailVerified)\nAnonymous User? ==> \(isAnonymous)\nProvider Id ==> \(providerId)\nFirebase User Id ==> \(firebaseUserId)";
    }
}
