//
//  WelcomeSViewController.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class WelcomeSViewController: UIViewController {
    @IBOutlet weak var StartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        applyGradientToButton(button: StartButton)
        
    }
    
    
    @IBAction func LetStartButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardSViewController") as! DashboardSViewController
        // self.tabBarController?.selectedIndex = 3
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
}
