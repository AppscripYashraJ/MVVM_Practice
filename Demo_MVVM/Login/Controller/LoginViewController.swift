//
//  LoginViewController.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 19/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passowordTextField: UITextField!
    
    @IBOutlet weak var loginAccessCodeLabel: UILabel!
    var loginSuccess : (()-> Void)?
    
    private var userViewModel = UserViewModel()
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel.accessCode.bind { [unowned self] (value)  in // box uis retaining self. This will create retain cycle.
            self.loginAccessCodeLabel.text = value
        }
        emailIdTextField.delegate = self
        passowordTextField.delegate = self
    }
    
    
    //MARK:- ACTIONS
    @IBAction func loginTapped(_ sender: UIButton) {
        switch userViewModel.validate() {
        case .Valid:
            userViewModel.login { (errorMesssage) in
                if let msg = errorMesssage {
                    self.displayErrorMesssage(msg)
                } else {
                    print("login Success")
                    self.loginSuccess?()
                }
            }
            break
        case .Invalid(let error):
            self.displayErrorMesssage(error)
            break
        }
        
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailIdTextField {
            textField.text = userViewModel.email
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailIdTextField {
            textField.text = userViewModel.email
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailIdTextField {
            passowordTextField.becomeFirstResponder()
        } else {
            //            authenticate()
            loginTapped(UIButton())
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == emailIdTextField {
            userViewModel.updateEmail(newString)
        } else if textField == passowordTextField {
            userViewModel.updatePassword(newString)
        }
        
        return true
    }
}

