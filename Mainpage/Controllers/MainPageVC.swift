import UIKit

class MainPageVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var addedtocart: UIButton!
    @IBOutlet weak var heartcount: UIButton!
    @IBOutlet weak var searchbar: UITextField!
    
    var cartCount: Int = 0 {
        didSet {
            addedtocart.setTitle("\(cartCount)", for: .normal)
        }
    }
    var heartCount: Int = 0 {
        didSet {
            heartcount.setTitle("\(heartCount)", for: .normal)
        }
    }

    struct Maindata {
        let imageName: String
        let name: String
        let price: String
        var like: String
        let buycart: String
    }
    
    var data: [Maindata] = [
        Maindata(imageName: "vege", name: "Boston Lettuce", price: "1.19 €/piece", like: "heart", buycart: "cart"),
        Maindata(imageName: "purplecauliflower", name: "Purple Cauliflower", price: "1.29 €/piece", like: "heart", buycart: "cart"),
        Maindata(imageName: "pumpkin", name: "Pumpkin", price: "3.34 €/piece", like: "heart", buycart: "cart"),
        Maindata(imageName: "savoycabbage", name: "Savoy Cabbage", price: "2.48 €/piece", like: "heart", buycart: "cart"),
        Maindata(imageName: "cabbage", name: "Cabbage", price: "2.16 €/piece", like: "heart", buycart: "cart"),
        Maindata(imageName: "jackfruit", name: "Jack Fruit", price: "4.32 €/piece", like: "heart", buycart: "cart")
    ]
    
    var filteredData: [Maindata] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageiCON = UIImageView(image: UIImage(named: "searchicon"))
        let iconSize = CGSize(width: 20, height: 20)
        imageiCON.frame = CGRect(x: 5, y: 0, width: iconSize.width, height: iconSize.height)
        imageiCON.contentMode = .scaleAspectFit
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width + 10, height: iconSize.height))
        contentView.addSubview(imageiCON)
        searchbar.leftView = contentView
        searchbar.leftViewMode = .always
        searchbar.clearButtonMode = .whileEditing
        table.rowHeight = 150
        searchbar.layer.cornerRadius = 10
        searchbar.layer.borderWidth = 1
        searchbar.layer.borderColor = UIColor(red: 220/255, green: 214/255, blue: 229/255, alpha: 1.0).cgColor
        searchbar.delegate = self
        filteredData = data
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredData.count : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let rowData = isSearching ? filteredData[indexPath.row] : data[indexPath.row]
        cell.iconImageview.image = UIImage(named: rowData.imageName)
        cell.iconImageview.layer.cornerRadius = 10
        cell.name.text = rowData.name
        cell.price.text = rowData.price
        
        let attributedString = NSMutableAttributedString(string: rowData.price)
        let range = (rowData.price as NSString).range(of: "€/piece")
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: rowData.price.count))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 25), range: NSRange(location: 0, length: rowData.price.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 149/255, green: 134/255, blue: 168/255, alpha: 1.0), range: range)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: range)
        cell.price.attributedText = attributedString
        let cartImage = UIImage(named: rowData.buycart)
        cell.buycart.setImage(cartImage, for: .normal)
        cell.buycart.layer.cornerRadius = 8
        cell.buycart.tag = indexPath.row
        cell.buycart.addTarget(self, action: #selector(addToCart(_:)), for: .touchUpInside)
        let buttonImage = UIImage(named: rowData.like)
        cell.like.setImage(buttonImage, for: .normal)
        cell.like.layer.borderWidth = 1
        cell.like.layer.cornerRadius = 8
        let borderColor = UIColor(red: 220/255, green: 214/255, blue: 229/255, alpha: 1.0).cgColor
        cell.like.layer.borderColor = borderColor
        cell.like.tag = indexPath.row
        cell.like.addTarget(self, action: #selector(Liked(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let searchText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        filterContentForSearchText(searchText)
        return true
    }
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredData = data
            isSearching = false
        } else {
            filteredData = data.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            isSearching = true
        }
        
        table.reloadData()
    }
    // MARK: - Button Actions
    
    @objc func addToCart(_ sender: UIButton) {
        _ = IndexPath(row: sender.tag, section: 0)
        if sender.isSelected {
            cartCount -= 1
            sender.isSelected = false
        } else {
            cartCount += 1
            sender.isSelected = true
        }
    }
    @objc func Liked(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if data[indexPath.row].like == "heart" {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            data[indexPath.row].like = "heart.fill"
            heartCount += 1
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            data[indexPath.row].like = "heart"
            heartCount -= 1
        }
        heartcount.setTitle("\(heartCount)", for: .normal)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = isSearching ? filteredData[indexPath.row] : data[indexPath.row]
        let descriptionController = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionController") as! DescriptionVC
        descriptionController.selectedData = selectedData
        self.navigationController?.pushViewController(descriptionController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

