//
//  AuthenticationViewControllerExtension.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/11/23.
//

import Foundation
import UIKit

extension AuthenticationViewController
{
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == " "
        {
            return false
        }
        
        return true
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
    
    
    func didReceiveLoginResponse(loginResponse: LoginResponse?) {
        if(loginResponse?.status == true)
        {
            debugPrint("Send to SendFundViewController")
            let sendFundViewController = self.storyboard?.instantiateViewController(withIdentifier: "sendFund") as! SendFundViewController
            sendFundViewController.userInfo = loginResponse?.data?.userInfo
            sendFundViewController.accountInfo = loginResponse?.data?.accountInfo
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
