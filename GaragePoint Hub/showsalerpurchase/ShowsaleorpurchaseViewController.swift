//
//  ShowsaleorpurchaseViewController.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class ShowsaleorpurchaseViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var vehiclesRecords: [SaleOrPurchase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let savedData = UserDefaults.standard.array(forKey: "SaleOrPurchaseRecords") as? [Data] {
            let decoder = JSONDecoder()
            vehiclesRecords = savedData.compactMap { data in
                do {
                    let productsData = try decoder.decode(SaleOrPurchase.self, from: data)
                    return productsData
                } catch {
                    print("Error decoding product: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        noDataLabel.text = "No data data found.Please add some data" // Set the message
        // Show or hide the table view and label based on data availability
        if vehiclesRecords.isEmpty {
            TableView.isHidden = true
            noDataLabel.isHidden = false  // Show the label when there's no data
        } else {
            TableView.isHidden = false
            noDataLabel.isHidden = true   // Hide the label when data is available
        }
        print(vehiclesRecords)  // Check if data is loaded
        TableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehiclesRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! showsaleandpurchaseTableViewCell
        
        let work = vehiclesRecords[indexPath.item]
        
        cell.selecttypelb.text = work.saleOrPurchaseType
        cell.vehicleTypeLabel.text = work.vehicleType
        cell.vehiclename.text = work.vehicleTitle
        cell.ContactLabel.text = work.contact
        cell.amount.text = "Rs:$\(work.amount)"
        cell.noteslb.text = "Description: \(work.notes)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from the RepairVehicle array
            vehiclesRecords.remove(at: indexPath.row)
            
            // Update the UserDefaults
            let encoder = JSONEncoder()
            do {
                let updatedData = try vehiclesRecords.map { try encoder.encode($0) }
                UserDefaults.standard.set(updatedData, forKey: "SaleOrPurchaseRecords")
            } catch {
                print("Error updating UserDefaults after deletion: \(error.localizedDescription)")
            }
            
            // Reload the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Check if there's no data left
            if vehiclesRecords.isEmpty {
                TableView.isHidden = true
                noDataLabel.isHidden = false
            }
        }
        
    }
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
