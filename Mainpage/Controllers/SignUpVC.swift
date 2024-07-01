//
//  SignUpVC.swift
//  Mainpage
//
//  Created by o9tech on 26/06/2024.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    let userManager = UserDefaultManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let textFields: [UITextField] = [username,email,password]
         for textField in textFields {
             textField.layer.borderWidth = 1
             textField.layer.cornerRadius = 5
             let attributes: [NSAttributedString.Key: Any] = [
                 .font: UIFont.systemFont(ofSize: textField.font?.pointSize ?? 17.0, weight: .semibold), // Semi-bold font
                 .foregroundColor: UIColor.gray // Set color to black
             ]
             textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: attributes)
         }
    }
    
    @IBAction func SignUp(_ sender: Any) {
        guard let usernameText = username.text, !usernameText.isEmpty else {
            showAlert(message: "Username field is empty!")
            return
        }
        
        guard let emailText = email.text, !emailText.isEmpty else {
            showAlert(message: "Email field is empty!")
            return
        }
        
        guard isValidEmail(emailText) else {
            showAlert(message: "Invalid email format!")
            return
        }
        
        guard let passwordText = password.text, !passwordText.isEmpty else {
            showAlert(message: "Password field is empty!")
            return
        }
        
        // Save user data using UserDefaultManager
        userManager.username = usernameText
        userManager.email = emailText
        userManager.password = passwordText
        showSuccessAlert()
        print("Signup details: Username - \(usernameText), Email - \(emailText), Password - \(passwordText)")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func showSuccessAlert() {
          let alert = UIAlertController(title: "Success", message: "Sign up successful!", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
              // Optionally, you can navigate to another view controller or perform additional actions after sign-up
              self?.navigationController?.popViewController(animated: true)
          }
          alert.addAction(okAction)
          present(alert, animated: true, completion: nil)
      }
    }
    
