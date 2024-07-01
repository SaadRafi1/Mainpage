//
//  LoginVC.swift
//  Mainpage
//
//  Created by o9tech on 26/06/2024.
//

import UIKit

class LoginVC: UIViewController {
   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    let userManager = UserDefaultManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        let textFields: [UITextField] = [email,password]
        for textField in textFields {
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = UIColor.black.cgColor
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: textField.font?.pointSize ?? 17.0, weight: .semibold),
                .foregroundColor: UIColor.lightGray
            ]
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: attributes)
        }
    }
    
    @IBAction func BtnSignUp(_ sender: Any) {
        if let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC {
            navigationController?.pushViewController(signupVC, animated: true)
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        guard let emailText = email.text, !emailText.isEmpty else {
            showAlert(message: "Email field is empty!")
            return
        }
        
        guard let passwordText = password.text, !passwordText.isEmpty else {
            showAlert(message: "Password field is empty!")
            return
        }
        // Retrieve stored email and password using UserDefaultManager
        let storedEmail = userManager.email
        let storedPassword = userManager.password
        // Check if storedEmail and storedPassword are not empty
        if !storedEmail.isEmpty && !storedPassword.isEmpty {
            if emailText == storedEmail && passwordText == storedPassword {
                userManager.isLoggedIn = true
                navigateToMainPage()
              
            } else {
                showAlert(message: "Incorrect email or password.")
            }
        } else {
            showAlert(message: "A user with that email id does not exist")
        }
    }
    func navigateToMainPage() {
        let mainPageVC = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        navigationController?.setViewControllers([mainPageVC], animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
