//
//  AuthenticationViewModel.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/8/23.
//

import Foundation

protocol AuthenticationViewModelDelegate {
    func checkIfValidUserName()
    func didReceiveLoginResponse()
}

struct AuthenticationViewModel
{
    var delegate : AuthenticationViewModelDelegate?
    
    func validateUserName()
    {
        
    }
    
    func loginUser()
    {
      
    }
    
}
