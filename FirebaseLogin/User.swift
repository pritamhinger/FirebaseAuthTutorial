//
//  User.swift
//  FirebaseLogin
//
//  Created by Pritam Hinger on 17/01/17.
//  Copyright © 2017 AppDevelapp. All rights reserved.
//

import Foundation

public class User: NSObject {
    var emailAddress: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var userName:String = ""
    var authProvider: AuthProvider = AuthProvider.EmailAddress
}
