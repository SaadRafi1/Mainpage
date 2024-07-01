import UIKit

class CardpaymentVC: UIViewController {
    @IBOutlet weak var namefield: UITextField!
    @IBOutlet weak var cardimage: UIImageView!
    @IBOutlet weak var cvcField: UITextField!
    @IBOutlet weak var expiryField: UITextField!
    @IBOutlet weak var cardNumberField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let border = UIColor(red: 220/255, green: 214/255, blue: 229/255, alpha: 1.0).cgColor
        cardimage.layer.cornerRadius = 10
        namefield.layer.borderWidth = 1
        namefield.layer.cornerRadius = 5
        namefield.layer.borderColor = border
        cvcField.layer.cornerRadius = 10
        cvcField.layer.borderWidth = 1
        cvcField.layer.cornerRadius = 5
        cvcField.layer.borderColor = border
        expiryField.layer.cornerRadius = 10
        expiryField.layer.borderWidth = 1
        expiryField.layer.cornerRadius = 5
        expiryField.layer.borderColor = border
        cardNumberField.layer.cornerRadius = 10
        cardNumberField.layer.borderWidth = 1
        cardNumberField.layer.cornerRadius = 5
        cardNumberField.layer.borderColor = border
    }
}

extension UITextField {
    
   
}

