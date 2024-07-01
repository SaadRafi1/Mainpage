import UIKit

class DescriptionVC: UIViewController {
    var selectedData: VegetableData?
    
    @IBOutlet weak var Likebtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCornerRadius: UIView!
    @IBOutlet weak var AddToCartBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var grams: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor(red: 220/255, green: 214/255, blue: 229/255, alpha: 1.0).cgColor
        
        Likebtn.layer.borderWidth = 1
        Likebtn.layer.cornerRadius = 8
        Likebtn.layer.borderColor = color
        AddToCartBtn.layer.cornerRadius = 8
        viewCornerRadius.layer.cornerRadius = 30
        if let data = selectedData {
            titleLabel.text = data.veg_name
            price.text = "\(data.veg_price) €/piece"
            image.image = UIImage(named: "pumpkin")
            grams.text = "\(data.veg_gram) gr / piece"
        }
    }
    @IBAction func AddToCartBtn(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "Cardpaymentcontroller") as! CardpaymentVC
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
}

