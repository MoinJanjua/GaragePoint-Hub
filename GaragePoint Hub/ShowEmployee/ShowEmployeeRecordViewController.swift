//
//  ShowEmployeeRecordViewController.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class ShowEmployeeRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var workers: [Employee] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let savedData = UserDefaults.standard.array(forKey: "EmployeeDetails") as? [Data] {
            let decoder = JSONDecoder()
            workers = savedData.compactMap { data in
                do {
                    let productsData = try decoder.decode(Employee.self, from: data)
                    return productsData
                } catch {
                    print("Error decoding product: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        noDataLabel.text = "No data data found.Please add some data" // Set the message
        // Show or hide the table view and label based on data availability
        if workers.isEmpty {
            TableView.isHidden = true
            noDataLabel.isHidden = false  // Show the label when there's no data
        } else {
            TableView.isHidden = false
            noDataLabel.isHidden = true   // Hide the label when data is available
        }
        print(workers)  // Check if data is loaded
        TableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmployeeTableViewCell
      
        
        
        let work = workers[indexPath.item]
        cell.Employeename.text = work.name
        cell.positionLabel.text = work.designation
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy" // Adjust format as needed
        cell.dateofjoiningLabel.text = dateFormatter.string(from: work.joiningDate)
//        cell.configure(with: work)
        
//            if work.other.isEmpty
//            {
//                cell.others.text = "No description"
//            }
//            cell.timeleftlb.text = " : \(work.date)"
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from the workers array
            workers.remove(at: indexPath.row)
            
            // Update the UserDefaults
            let encoder = JSONEncoder()
            do {
                let updatedData = try workers.map { try encoder.encode($0) }
                UserDefaults.standard.set(updatedData, forKey: "EmployeeDetails")
            } catch {
                print("Error updating UserDefaults after deletion: \(error.localizedDescription)")
            }
            
            // Reload the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Check if there's no data left
            if workers.isEmpty {
                TableView.isHidden = true
                noDataLabel.isHidden = false
            }
        }
        
    }
@IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
 
