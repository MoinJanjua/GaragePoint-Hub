import UIKit

class SaleHistoryViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var totalRepairAmount: UILabel!
    @IBOutlet weak var totalSaleAmount: UILabel!
    @IBOutlet weak var totalPurchaseAmount: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    var sales_list = [SaleOrPurchase]()
    var repairVehicles = [RepairVehicle]()
    var allRecords = [Allrecords]()

    var filteredRecords = [Allrecords]()

    // Totals
    var totalRepair: Double = 0.0
    var totalSale: Double = 0.0
    var totalPurchase: Double = 0.0

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        loadSalesData()
        loadRepairVehicleData()
        mapRecordsToAllrecords()
        filterRecords(by: .all)
        updateTotals()
    }

    func loadSalesData() {
        if let savedData = UserDefaults.standard.array(forKey: "SaleOrPurchaseRecords") as? [Data] {
            let decoder = JSONDecoder()
            sales_list = savedData.compactMap { data in
                do {
                    return try decoder.decode(SaleOrPurchase.self, from: data)
                } catch {
                    print("Error decoding sales data: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }

    func loadRepairVehicleData() {
        if let savedData = UserDefaults.standard.array(forKey: "RepairDetails") as? [Data] {
            let decoder = JSONDecoder()
            repairVehicles = savedData.compactMap { data in
                do {
                    return try decoder.decode(RepairVehicle.self, from: data)
                } catch {
                    print("Error decoding repair vehicle data: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }

    func mapRecordsToAllrecords() {
        var allCombinedRecords = [Allrecords]()

        for sale in sales_list {
            let record = Allrecords(
                vehicleTitle: sale.vehicleTitle,
                vehicleType: sale.vehicleType,
                saleOrPurchaseType: sale.saleOrPurchaseType,
                amountRepair: 0.0,
                sellamount: sale.saleOrPurchaseType == "Sale" ? sale.amount : 0.0,
                purchaseamount: sale.saleOrPurchaseType == "Purchase" ? sale.amount : 0.0,
                ownerName: sale.sellerName
            )
            allCombinedRecords.append(record)

            // Update totals
            if sale.saleOrPurchaseType == "Sale" {
                totalSale += sale.amount
            } else if sale.saleOrPurchaseType == "Purchase" {
                totalPurchase += sale.amount
            }
        }

        for repair in repairVehicles {
            let record = Allrecords(
                vehicleTitle: repair.vehicleTitle,
                vehicleType: repair.vehicleType,
                saleOrPurchaseType: "Repair",
                amountRepair: repair.amountRepair,
                sellamount: 0.0,
                purchaseamount: 0.0,
                ownerName: repair.ownerName
            )
            allCombinedRecords.append(record)

            // Update total repair amount
            totalRepair += repair.amountRepair
        }

        self.allRecords = allCombinedRecords
    }


    @IBAction func segmentedctrl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filterRecords(by: .all)
        case 1:
            filterRecords(by: .repair)
        case 2:
            filterRecords(by: .saleOrPurchase) // Displays only sale or purchase
        default:
            break
        }
    }

    func filterRecords(by filter: RecordFilter) {
        switch filter {
        case .all:
            filteredRecords = allRecords
        case .repair:
            filteredRecords = allRecords.filter { $0.saleOrPurchaseType == "Repair" }
        case .saleOrPurchase:
            filteredRecords = allRecords.filter { $0.saleOrPurchaseType == "Sale" || $0.saleOrPurchaseType == "Purchase" }
        }

        TableView.reloadData()
        TableView.isHidden = filteredRecords.isEmpty
        noDataLabel.isHidden = !filteredRecords.isEmpty
    }

    func updateTotals() {
        totalRepairAmount.text = "$\(totalRepair)"
        totalSaleAmount.text = "$\(totalSale)"
        totalPurchaseAmount.text = "$\(totalPurchase)"
    }
}

// Enum for filtering records
enum RecordFilter {
    case all
    case repair
    case saleOrPurchase
}

// TableView DataSource and Delegate
extension SaleHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = filteredRecords[indexPath.row]

        if record.saleOrPurchaseType == "Repair" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "repaircell", for: indexPath) as! RepairVehicleTableViewCell
            cell.vehicleTitle?.text = "Vehicle: \(record.vehicleTitle)"
            cell.repairDetails?.text = "Repair Amount: $\(record.amountRepair)"
            cell.vehicleType?.text = "Vehicle Type: \(record.vehicleType)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SaleTableViewCell
            cell.productName?.text = "Vehicle: \(record.vehicleTitle)"
            
            // Only display sale data if sale is found, otherwise show purchase
            if record.saleOrPurchaseType == "Sale" {
                cell.price?.text = "Sale Amount: $\(record.sellamount)"
                cell.selectedtype?.text = "Sale" // Correctly set the selected type
            } else if record.saleOrPurchaseType == "Purchase" {
                cell.price?.text = "Purchase Amount: $\(record.purchaseamount)"
                cell.selectedtype?.text = "Purchase" // Correctly set the selected type
            }
            
            cell.qty?.text = "Owner: \(record.ownerName)"
            return cell
            cell.vehicleType?.text = "Vehicle type: \(record.vehicleType)"
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
