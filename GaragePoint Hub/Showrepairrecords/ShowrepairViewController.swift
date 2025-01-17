//
//  ShowrepairViewController.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class ShowrepairViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var RepairVehicles: [RepairVehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let savedData = UserDefaults.standard.array(forKey: "RepairDetails") as? [Data] {
            let decoder = JSONDecoder()
            RepairVehicles = savedData.compactMap { data in
                do {
                    let productsData = try decoder.decode(RepairVehicle.self, from: data)
                    return productsData
                } catch {
                    print("Error decoding product: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        noDataLabel.text = "No data data found.Please add some data" // Set the message
        // Show or hide the table view and label based on data availability
        if RepairVehicles.isEmpty {
            TableView.isHidden = true
            noDataLabel.isHidden = false  // Show the label when there's no data
        } else {
            TableView.isHidden = false
            noDataLabel.isHidden = true   // Hide the label when data is available
        }
        print(RepairVehicles)  // Check if data is loaded
        TableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RepairVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! showrepairTableViewCell
        
        let work = RepairVehicles[indexPath.item]
        cell.ownername.text = work.ownerName
        cell.vehiclename.text = work.vehicleTitle
        cell.mechanicname.text = work.selectedWorker
        cell.dateofrepair.text = work.repairDate
        cell.repairamount.text = "RS:\(work.amountRepair)"
        
        
        
        
//        cell.vehicleIssueLabel.text = "Vehicle issue: \(work.vehicleIssue)"
        
//        
//        cell.configure(with: work)
//        //            cell.assignedWorkerLabel.text = work.assignedWorker
//        cell.assignedWorkerLabel.text = "Worked by: \(work.assignedWorker)"
//        
//        //            if work.other.isEmpty
//        //            {
//        //                cell.others.text = "No description"
//        //            }
//        //            cell.timeleftlb.text = " : \(work.date)"
//        //
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from the RepairVehicles array
            RepairVehicles.remove(at: indexPath.row)
            
            // Update the UserDefaults
            let encoder = JSONEncoder()
            do {
                let updatedData = try RepairVehicles.map { try encoder.encode($0) }
                UserDefaults.standard.set(updatedData, forKey: "RepairDetails")
            } catch {
                print("Error updating UserDefaults after deletion: \(error.localizedDescription)")
            }
            
            // Reload the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Check if there's no data left
            if RepairVehicles.isEmpty {
                TableView.isHidden = true
                noDataLabel.isHidden = false
            }
        }
        
    }
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
