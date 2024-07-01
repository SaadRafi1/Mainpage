import UIKit

class MainPageVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var addedtocart: UIButton!
    @IBOutlet weak var heartcount: UIButton!
    @IBOutlet weak var searchbar: UITextField!
    
    var veges: [VegetableData]? {
        didSet {
            DispatchQueue.main.async {
                self.filteredData = self.veges ?? []
                self.table.reloadData()
            }
        }
    }
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

    var filteredData: [VegetableData] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vegemanager = VegetableManager()
        vegemanager.fetchdata { (vege) in
            print(vege.data)
            self.veges = vege.data
        }
        
        setupSearchBar()
        table.rowHeight = 150
        searchbar.delegate = self
    }
    
    private func setupSearchBar() {
        let imageiCON = UIImageView(image: UIImage(named: "searchicon"))
        let iconSize = CGSize(width: 20, height: 20)
        imageiCON.frame = CGRect(x: 5, y: 0, width: iconSize.width, height: iconSize.height)
        imageiCON.contentMode = .scaleAspectFit
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width + 10, height: iconSize.height))
        contentView.addSubview(imageiCON)
        searchbar.leftView = contentView
        searchbar.leftViewMode = .always
        searchbar.clearButtonMode = .whileEditing
        searchbar.layer.cornerRadius = 10
        searchbar.layer.borderWidth = 1
        searchbar.layer.borderColor = UIColor(red: 220/255, green: 214/255, blue: 229/255, alpha: 1.0).cgColor
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let rowData = filteredData[indexPath.row]
        
        cell.iconImageview.image = UIImage(named: "pumpkin")
        cell.iconImageview.layer.cornerRadius = 10
        cell.name.text = rowData.veg_name
        cell.price.text = "\(rowData.veg_price) €/piece"
        
        let attributedString = NSMutableAttributedString(string: cell.price.text ?? "")
        let range = (cell.price.text! as NSString).range(of: "€/piece")
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 25), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 149/255, green: 134/255, blue: 168/255, alpha: 1.0), range: range)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: range)
        cell.price.attributedText = attributedString
        
        let cartImage = UIImage(named: "cart")
        cell.buycart.setImage(cartImage, for: .normal)
        cell.buycart.layer.cornerRadius = 8
        cell.buycart.tag = indexPath.row
        cell.buycart.addTarget(self, action: #selector(addToCart(_:)), for: .touchUpInside)
        
        let buttonImage = UIImage(named: "heart")
        cell.like.setImage(buttonImage, for: .normal)
        cell.like.layer.borderWidth = 1
        cell.like.layer.cornerRadius = 8
        let borderColor = UIColor(red: 220/255, green: 214/255, blue: 229/255, alpha: 1.0).cgColor
        cell.like.layer.borderColor = borderColor
        cell.like.tag = indexPath.row
      //  cell.like.addTarget(self, action: #selector(Liked(_:)), for: .touchUpInside)
        
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
            filteredData = veges ?? []
            isSearching = false
        } else {
            filteredData = veges?.filter { $0.veg_name.lowercased().contains(searchText.lowercased()) } ?? []
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
    
  /*  @objc func Liked(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if filteredData[indexPath.row].like == "heart" {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            filteredData[indexPath.row].like = "heart.fill"
            heartCount += 1
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            filteredData[indexPath.row].like = "heart"
            heartCount -= 1
        }
        heartcount.setTitle("\(heartCount)", for: .normal)
    }*/
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = filteredData[indexPath.row]
        let descriptionController = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionController") as! DescriptionVC
        descriptionController.selectedData = selectedData
        self.navigationController?.pushViewController(descriptionController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

