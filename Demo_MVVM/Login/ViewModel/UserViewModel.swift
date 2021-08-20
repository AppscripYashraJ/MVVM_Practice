//
//  UserViewModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 19/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

enum UserValidationState {
    case Valid
    case Invalid(String)
}

class UserViewModel {
    private let minEmailCharacterLimit = 10
    private let minimumPasswordCharactersLimit = 8
    private var user = User()
    private let codeRefreshTime = 5.0 // evert 5 seconds we should getr new access code
    var email: String {
        return user.email
    }
    
    var password: String {
        return user.password
    }
    
    var accessCode : Box<String?> = Box(value: nil)// initializing with empty box. But it is still of type string
    
    init(user : User = User()) {
        self.user = user
        startAccessCodeTimer()
    }
}

extension UserViewModel {
    func updateEmail(_ email: String){
        user.email = email
    }
    
    func updatePassword(_ password: String){
        user.password = password
    }
    
    func validate()->UserValidationState{
        if user.email.isEmpty || user.password.isEmpty {
            return .Invalid("Email and Passowrd is required")
        }
        if user.email.count < minEmailCharacterLimit {
            return .Invalid("Email need to be atleast 10 characters")
        }
        
        if user.password.count < minimumPasswordCharactersLimit {
            return .Invalid("Password need to be atleast 8 characters")
        }
        return .Valid
    }
    
    func login(completion: @escaping(_ errorString: String?) -> Void) {
        LoginService.loginWithUser(user.email, password: user.password) { success in
            if success {
                completion(nil)
            } else {
                completion("Invalid Credentials")
            }
        }
    }
}

private extension UserViewModel {
    func startAccessCodeTimer(){
        accessCode.value = LoginService.generateAccessCode() 
        DispatchQueue.main.asyncAfter(deadline: .now() + codeRefreshTime) { [weak self] in // if we have got rid of login view then there wont be a retain cycle
            self?.startAccessCodeTimer()
        }
    }
}
