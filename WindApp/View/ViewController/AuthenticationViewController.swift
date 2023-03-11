//
//  ViewController.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/7/23.
//

import UIKit
import SVPinView

class AuthenticationViewController: UIViewController, AuthenticationViewModelDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var pinView: SVPinView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    private var authenticationViewModel = AuthenticationViewModel()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        usernameTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationViewModel.delegate = self
        authenticationViewModel.checkAndUpdateContinueButton()
        configurePinView()
        usernameTextField.addTarget(self, action: #selector(usernmaeTextFieldDidChange(_:)), for: .editingChanged)
        usernameTextField.delegate = self
    }
    
    func configurePinView() {
        
        pinView.pinLength = 4
        pinView.secureCharacter = "\u{25CF}"
        pinView.interSpace = 10
        pinView.textColor = UIColor.black
        pinView.borderLineColor = UIColor.systemGray
        pinView.activeBorderLineColor = UIColor.black
        pinView.borderLineThickness = 1
        pinView.shouldSecureText = true
        pinView.allowsWhitespaces = false
        pinView.style = .underline
        
        pinView.placeholder = "****"
        pinView.deleteButtonAction = .deleteCurrentAndMoveToPrevious
        pinView.keyboardAppearance = .default
        pinView.tintColor = .white
        //pinView.becomeFirstResponderAtIndex = 0
        pinView.shouldDismissKeyboardOnEmptyFirstField = false
        
        pinView.font = UIFont.systemFont(ofSize: 15)
        pinView.keyboardType = .phonePad
        pinView.pinInputAccessoryView = { () -> UIView in
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
            doneToolbar.barStyle = UIBarStyle.default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(dismissKeyboard))
            
            var items = [UIBarButtonItem]()
            items.append(flexSpace)
            items.append(done)
            
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            return doneToolbar
        }()
        
        pinView.didFinishCallback = didFinishEnteringPin(pin:)
        pinView.didChangeCallback = { pin in
            print("The entered pin is \(pin)")
            self.authenticationViewModel.isPinEntered = false
            self.authenticationViewModel.checkAndUpdateContinueButton()
        }
    }
    
    func didFinishEnteringPin(pin:String) {
        //showAlert(title: "Success", message: "The Pin entered is \(pin)")
        authenticationViewModel.isPinEntered = true
        authenticationViewModel.checkAndUpdateContinueButton()
    }
    
    @objc func usernmaeTextFieldDidChange(_ textField: UITextField) {
        //print("Username Input: " + textField.text!)
        //authenticationViewModel.validateUserName(userName: textField.text!)
        print("Username Input: " + (textField.text?.lowercased())!)
        authenticationViewModel.validateUserName(userName: (textField.text?.lowercased())!)
    }
    
    // MARK: Helper Functions
    @IBAction func gotoSendFund(_ sender: Any) {
        let request = LoginRequest(user: usernameTextField.text?.lowercased(), pin: pinView.getPin())
        authenticationViewModel.loginUser(loginRequest: request)
    }
        
}

