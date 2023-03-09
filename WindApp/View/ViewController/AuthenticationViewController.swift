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
        // Do any additional setup after loading the view.
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
        pinView.becomeFirstResponderAtIndex = 0
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
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func enableContinueButton()
    {
        continueButton.isEnabled = true
        continueButton.backgroundColor = UIColor(red: 104/255, green: 76/255, blue: 255/255, alpha: 1)
    }
    
    func disableContinueButton()
    {
        continueButton.isEnabled = false
        continueButton.backgroundColor = UIColor(red: 181/255, green: 166/255, blue: 255/255, alpha: 1)
    }
    
    func didFinishEnteringPin(pin:String) {
        //showAlert(title: "Success", message: "The Pin entered is \(pin)")
        authenticationViewModel.isPinEntered = true
        authenticationViewModel.checkAndUpdateContinueButton()
    }
    
    // MARK: Helper Functions
    /*
     func showAlert(title:String, message:String) {
     let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
     alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
     self.present(alert, animated: true, completion: nil)
     }
     */
    
    @objc func usernmaeTextFieldDidChange(_ textField: UITextField) {
        //print("Username Input: " + textField.text!)
        //authenticationViewModel.validateUserName(userName: textField.text!)
        print("Username Input: " + (textField.text?.lowercased())!)
        authenticationViewModel.validateUserName(userName: (textField.text?.lowercased())!)
    }
    
    @IBAction func gotoSendFund(_ sender: Any) {
        let request = LoginRequest(user: usernameTextField.text, pin: pinView.getPin())
        authenticationViewModel.loginUser(loginRequest: request)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == " "
        {
            return false
        }
        
        return true
    }
    
    func didReceiveLoginResponse(loginResponse: LoginResponse?) {
        if(loginResponse?.status == true)
        {
            debugPrint("Send to SendFundViewController")
            let sendFundViewController = self.storyboard?.instantiateViewController(withIdentifier: "sendFund") as! SendFundViewController
            self.navigationController?.pushViewController(sendFundViewController, animated: true)
        }
        else
        {
            //print(loginResponse?.messages)
            let alert = UIAlertController(title: "Error", message: loginResponse?.messages[0], preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

