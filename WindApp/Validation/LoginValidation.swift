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
        var regex = "(.)\\__"
        if userName.range(of: regex, options: .regularExpression) != nil {
            print("found consecutive characters \"_\"")
            return ValidationResult(success: false, error: "found consecutive characters \"_\"")
        }
        
        regex = "(.)\\."
        if userName.range(of: regex, options: .regularExpression) != nil {
            print("found consecutive characters \".\"")
            return ValidationResult(success: false, error: "found consecutive characters \".\"")
        }
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._")
        if userName.rangeOfCharacter(from: characterset.inverted) != nil {
            print("@userName Can not contain special characters!")
            return ValidationResult(success: false, error: "@userName Can not contain special characters!")
        }
        
        if(userName.count < 4 || userName.count > 32)
        {
            print("Username length is not correct")
            return ValidationResult(success: false, error: "Username length is not correct")
        }
        
        
        return ValidationResult(success: true, error: nil)
    }
}
