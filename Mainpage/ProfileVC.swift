//
//  ProfileVC.swift
//  Mainpage
//
//  Created by o9tech on 27/06/2024.
//

import UIKit

class ProfileVC: UIViewController {
    let userManager = UserDefaultManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func signout(_ sender: Any) {
        userManager.isLoggedIn = false
        navigateToLogin()
    }
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            navigationController?.setViewControllers([loginVC], animated: false)
        }
    }
}
