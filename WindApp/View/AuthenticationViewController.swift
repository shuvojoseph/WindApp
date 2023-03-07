//
//  ViewController.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/7/23.
//

import UIKit

class AuthenticationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func gotoSendFund(_ sender: Any) {
        
        let sendFundViewController = self.storyboard?.instantiateViewController(withIdentifier: "sendFund") as! SendFundViewController
        self.navigationController?.pushViewController(sendFundViewController, animated: true)
 
    }
    
}

