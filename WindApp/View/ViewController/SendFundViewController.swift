//
//  SendFundViewController.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/7/23.
//

import UIKit

class SendFundViewController: UIViewController {

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var fundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Send Fund"
        changeNavigationBackButton()
        makeUsernameHolderViewCardview()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews()
    {
        drawFundViewGradientBorderline()
    }
    
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
        fundView.gradientBorder(colors: [UIColor.red , UIColor.blue], isVertical: true)
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
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 0)
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
