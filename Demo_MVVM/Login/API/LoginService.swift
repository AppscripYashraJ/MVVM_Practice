//
//  LoginService.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 19/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

 class LoginService {
    static func loginWithUser(_ userName : String,password:String,completion:(Bool)->Void) {
        completion(true)
    }
    
    static func generateAccessCode() -> String{
        return UUID().uuidString.replacingOccurrences(of: "-", with: "").prefix(10).description.lowercased()
    }
}
