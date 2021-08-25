//
//  Demo_MVVMTests.swift
//  Demo_MVVMTests
//
//  Created by Rahul Sharma on 24/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import XCTest
@testable import Demo_MVVM
class Demo_MVVMTests: XCTestCase {
    
    func test_Email_Validation_NotEmpty(){
        let viewModel = makeSUT(email: "yashraj@gmail.com", password: "yashrajGujar")
        XCTAssertTrue(!viewModel.email.isEmpty)
    }
    
    func test_password_validation_NotEmpty(){
         let viewModel = makeSUT(email: "yashraj@gmail.com", password: "yashrajGujar")
        XCTAssertTrue(!viewModel.password.isEmpty)
    }
    
    func test_email_pasword_minumumCharacters(){
        let viewModel = makeSUT(email: "yashraj@gmail.com", password: "yashrajGujar")
        let valid = viewModel.validate()
        XCTAssertEqual(valid, UserValidationState.Valid)
    }
    
    func test_email_lessthan10Characters(){
        let viewModel = makeSUT(email: "yashraj1", password: "yashrajGujar")
        let valid = viewModel.validate()
        XCTAssertEqual(valid, UserValidationState.Invalid(ErrorMessages.emailMinLength.rawValue))

    }
    
    func test_password_lessThan8Characters(){
        let viewModel = makeSUT(email: "yashraj1123@gmail.com", password: "yash")
        let valid = viewModel.validate()
        XCTAssertEqual(valid, UserValidationState.Invalid(ErrorMessages.passwordMinLength.rawValue))
        
    }
    
    func makeSUT(email:String,password:String)->UserViewModel{
        let viewModel = UserViewModel()
        viewModel.updateEmail(email)
        viewModel.updatePassword(password)
        return viewModel
    }
    
}
