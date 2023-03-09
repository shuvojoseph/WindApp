//
//  AuthenticationViewModel.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/8/23.
//

import Foundation

protocol AuthenticationViewModelDelegate {
    func didReceiveLoginResponse(loginResponse: LoginResponse?)
    func enableContinueButton()
    func disableContinueButton()
}

class AuthenticationViewModel
{
    
    var delegate : AuthenticationViewModelDelegate?
    var isValidUserName:Bool = false
    var isPinEntered:Bool = false
    
    
    func validateUserName(userName:String)
    {
        //print(userName)
        let validationResult = LoginValidation().validateUsername(userName: userName)
        
        isValidUserName = validationResult.success
        checkAndUpdateContinueButton()
    }
    
    func checkAndUpdateContinueButton()
    {
        //print("isValidUserName \(isValidUserName) isPinEntered \(isPinEntered)")
        if(isValidUserName && isPinEntered)
        {
            //print("Enable Button.")
            delegate?.enableContinueButton()
        }
         else {
            delegate?.disableContinueButton()
            //print("Button not Enabled.")
        }
    }
    
    func loginUser(loginRequest: LoginRequest)
    {
            
            let loginResource = LoginResource()
        
            loginResource.loginUser(loginRequest: loginRequest) { (loginApiResponse) in

                //print(loginApiResponse)
                //return the response we get from loginResource
                DispatchQueue.main.async {
                    self.delegate?.didReceiveLoginResponse(loginResponse: loginApiResponse)
                }
            }
    }
}
