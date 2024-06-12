import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet var image: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    struct Maindata {
        let imageName: String
        let name: String
        let price: String
        let currency: String
    }
    
    let data: [Maindata] = [
        Maindata(imageName: "vege", name: "Boston Lettuce", price: "1.19", currency: "€/piece"),
        Maindata(imageName: "vege", name: "Cabig", price: "1.19", currency: "€/piece"),
        Maindata(imageName: "vege", name: "Boston Lettuce", price: "1.19", currency: "€/piece"),
        Maindata(imageName: "vege", name: "Boston Lettuce", price: "1.19", currency: "€/piece"),
        Maindata(imageName: "vege", name: "Boston Lettuce", price: "1.19", currency: "€/piece"),
        Maindata(imageName: "vege", name: "Boston Lettuce", price: "1.19", currency: "€/piece"),
        Maindata(imageName: "vege", name: "Boston Lettuce", price: "1.19", currency: "€/piece")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        table.rowHeight = 200
        searchbar.layer.cornerRadius = 15
        image.layer.cornerRadius = 10
        
    }
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        // Get the corresponding data for the current row
        let rowData = data[indexPath.row]
        
        // Configure the cell with the data
        cell.iconImageview.image = UIImage(named: rowData.imageName)
        cell.name.text = rowData.name
        cell.price.text = rowData.price
        cell.currency.text = rowData.currency
        
        return cell
    }
}

