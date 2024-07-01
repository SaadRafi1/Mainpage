import UIKit

class SplashScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigateBasedOnLoginStatus()
        }
    }
    func navigateBasedOnLoginStatus() {
        let userManager = UserDefaultManager.shared
        if userManager.isLoggedIn {
            navigateToMainPage()
        } else {
            navigateToLogin()
        }
    }
    func navigateToMainPage() {
        let mainPageVC = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        navigationController?.setViewControllers([mainPageVC], animated: true)
    }
    
    func navigateToLogin() {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}

