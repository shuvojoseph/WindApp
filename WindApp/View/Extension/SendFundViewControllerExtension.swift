//
//  SendFundViewControllerExtension.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/11/23.
//

import Foundation
import UIKit

extension SendFundViewController
{
    func changeNavigationBackButton()
    {
        let navBackImage = UIImage(systemName: "arrow.backward")
        self.navigationController?.navigationBar.backIndicatorImage = navBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = navBackImage
        self.navigationController?.navigationBar.topItem?.title = "";
    }
    
    func makeUsernameHolderViewCardview()
    {
        usernameView.layer.cornerRadius = 9.0
        usernameView.layer.shadowColor = UIColor.gray.cgColor
        usernameView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        usernameView.layer.shadowRadius = 4.0
        usernameView.layer.shadowOpacity = 0.3
    }
    
    func drawFundViewGradientBorderline()
    {
        fundView.layer.cornerRadius = 9.0
        fundView.gradientBorder(colors: [UIColor(red: 252/255, green: 171/255, blue: 113/255, alpha: 1) , UIColor(red: 128/255, green: 90/255, blue: 234/255, alpha: 1)], isVertical: true)
    }
    
    func loadUserData()
    {
        loadUserInfo()
        loadAccountInfo()
    }
    
    func loadUserInfo()
    {
        if let unwrappedUserName = userInfo?.userName
        {
            userName.text = "@\(unwrappedUserName)"
        }
        
        if let unwrappedWalletAdress = userInfo?.walletAddress
        {
            userWalletAdress.text = "-\(unwrappedWalletAdress)"
        }
        
        makeUserImageCircular()
        if let userImageUrl = userInfo?.profileImage
        {
            userImage.downloaded(from: userImageUrl)
        }
    }
    
    func makeUserImageCircular()
    {
        userImage.layer.borderWidth = 1.0
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
    }
    
    func loadAccountInfo()
    {
        if let unwrappedUserCurrency = accountInfo?.currency
        {
            userCurrency.text = unwrappedUserCurrency
            
            if let unwrappedUserBalance = accountInfo?.balance
            {
                userBalance.text = "Balance \(unwrappedUserCurrency) \(unwrappedUserBalance)"
            }
        }
    }
    
    func enableInsufficientBalance() {
        //print("enable")
        enableContinueButton()
        sufficientBalance()
    }
    
    func disableInsufficientBalance() {
        //print("disaable")
        disableContinueButton()
        insufficientBalance()
    }
    
    func insufficientBalance()
    {
        insufficientBalanceLabel.isHidden = false
        addFundButton.isHidden = false
    }
    
    func sufficientBalance()
    {
        insufficientBalanceLabel.isHidden = true
        addFundButton.isHidden = true
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
}

extension UIView {
    func gradientBorder(colors: [UIColor], isVertical: Bool){
        self.layer.masksToBounds = true
        
        //Create gradient layer
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero, size: self.bounds.size)
        gradient.colors = colors.map({ (color) -> CGColor in
            color.cgColor
        })

        //Set gradient direction
        if(isVertical){
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }
        else {
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }

        //Create shape layer
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.path = UIBezierPath(roundedRect: gradient.frame.insetBy(dx: 1, dy: 1), cornerRadius: self.layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        //Add layer to view
        self.layer.addSublayer(gradient)
        gradient.zPosition = 0
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
