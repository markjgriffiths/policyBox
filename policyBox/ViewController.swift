//
//  ViewController.swift
//  policyBox
//
//  Created by Mark Griffiths on 08/11/2016.
//  Copyright © 2016 MarkGriffiths. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    var loginTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    
    var loginButton: UIButton!
    var signUpButton: UIButton!
    
    func setupTextFields() {
        loginTextField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 80, height: 50)
        loginTextField.center = CGPoint(x: view.bounds.width / 2, y: 100)
        //        loginTextField.backgroundColor = UIColor.lightGray
        loginTextField.textColor = UIColor.darkGray
        loginTextField.borderStyle = UITextBorderStyle.roundedRect
        loginTextField.placeholder = "Email"
        loginTextField.font = UIFont.systemFont(ofSize: 17)
        loginTextField.textAlignment = .left
        loginTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        loginTextField.delegate = self
        loginTextField.keyboardType = UIKeyboardType.emailAddress
        loginTextField.returnKeyType = UIReturnKeyType.next
        view.addSubview(loginTextField)
        
        passwordTextField.bounds = CGRect(x: 0, y: 0, width: view.bounds.width - 80, height: 50)
        passwordTextField.center = CGPoint(x: view.bounds.width / 2, y: 200)
        //        passwordTextField.backgroundColor = UIColor.lightGray
        passwordTextField.textColor = UIColor.darkGray
        passwordTextField.borderStyle = UITextBorderStyle.roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 17)
        passwordTextField.textAlignment = .left
        passwordTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
    }
    
    func setupButton() {
        loginButton = UIButton(type: UIButtonType.system)
        loginButton.bounds = CGRect(x: 0, y: 0, width: view.bounds.width / 2 - 80 , height: 50)
        let loginButtonWidth = loginButton.bounds.width
        loginButton.center = CGPoint(x: (loginButtonWidth / 2) + 40, y: 300)
        loginButton.backgroundColor = UIColor.lightGray
        loginButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Login", for: UIControlState.normal)
        loginButton.titleLabel!.font = UIFont.systemFont(ofSize: 17)
        loginButton.addTarget(self, action: #selector(ViewController.loginButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(loginButton)
        
        signUpButton = UIButton(type: UIButtonType.system)
        signUpButton.bounds = CGRect(x: 0, y: 0, width: view.bounds.width / 2 - 80 , height: 50)
        let signUpButtonWidth = signUpButton.bounds.width
        signUpButton.center = CGPoint(x: (view.bounds.width / 2) + (signUpButtonWidth / 2) + 40, y: 300)
        signUpButton.backgroundColor = UIColor.lightGray
        signUpButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        signUpButton.layer.cornerRadius = 5
        signUpButton.setTitle("Sign Up", for: UIControlState.normal)
        signUpButton.titleLabel!.font = UIFont.systemFont(ofSize: 17)
        signUpButton.addTarget(self, action: #selector(ViewController.signUpButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(signUpButton)
    }
    
    func loginButtonPressed(_ sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: {
            user, error in
            if error != nil{
                print("login error")
            } else {
                print("logged in")
            }
        })
    }
    
    func signUpButtonPressed(_ sender: AnyObject) {
        FIRAuth.auth()?.createUser(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: {
            user, error in
            if error != nil {
                print("sign up error")
            } else {
                print("user Created")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTextFields()
        setupButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
            return true
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
}
