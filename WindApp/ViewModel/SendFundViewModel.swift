//
//  SendFundViewModel.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/11/23.
//

import Foundation

protocol SendFundViewModelDelegate {
    func enableInsufficientBalance()
    func disableInsufficientBalance()
}

class SendFundViewModel
{
    var delegate : SendFundViewModelDelegate?
    
    func checkSufficientBalance(userInput:String?, balance:Double?)
    {
        if let userInput = userInput, let balance = balance
        {
            if let userInputDouble = Double(userInput)
            {
                if(userInputDouble <= balance)
                {
                    delegate?.enableInsufficientBalance()
                }
                else{
                    delegate?.disableInsufficientBalance()
                }
            }
            
        }
    }
}
