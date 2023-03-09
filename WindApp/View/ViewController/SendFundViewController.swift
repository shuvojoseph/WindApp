//
//  SendFundViewController.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/7/23.
//

import UIKit

class SendFundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Send Fund"
        changeNavigationBackButton()
        // Do any additional setup after loading the view.
    }
    
    func changeNavigationBackButton()
    {
        let yourBackImage = UIImage(systemName: "arrow.backward")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.topItem?.title = "";
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
