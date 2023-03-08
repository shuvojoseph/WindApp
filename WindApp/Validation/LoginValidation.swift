//
//  LoginValidation.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/8/23.
//

import Foundation

struct LoginValidation {
    
    func validateUsername(userName:String) -> ValidationResult
    {
        if(userName.count<4)
        {
            return ValidationResult(success: false, error: "Username length is less than 4")
        }
        
        return ValidationResult(success: true, error: nil)
    }
}
