//
//  SendFundViewController.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/7/23.
//

import UIKit

class SendFundViewController: UIViewController,UITextFieldDelegate,SendFundViewModelDelegate {

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var fundView: UIView!
    @IBOutlet weak var insufficientBalanceLabel: UILabel!
    @IBOutlet weak var addFundButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userWalletAdress: UILabel!
    @IBOutlet weak var userCurrency: UILabel!
    @IBOutlet weak var userBalance: UILabel!
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView! 
    
    
    var userInfo:UserInfo?
    var accountInfo:AccountInfo?
    
    private var sendFundViewModel = SendFundViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Send Fund"
        sendFundViewModel.delegate = self
        changeNavigationBackButton()
        makeUsernameHolderViewCardview()
        sufficientBalance()
        loadUserData()
        
        userInputTextField.addTarget(self, action: #selector(userInputTextFieldDidChange(_:)), for: .editingChanged)
        userInputTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userInputTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews()
    {
        drawFundViewGradientBorderline()
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        //insufficientBalance()
    }
    
    @objc func userInputTextFieldDidChange(_ textField: UITextField) {
        
        print("Username Input: \(String(describing: textField.text))")
        sendFundViewModel.checkSufficientBalance(userInput: textField.text, balance: accountInfo?.balance)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
