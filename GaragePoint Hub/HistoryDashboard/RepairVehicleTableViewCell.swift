//
//  RepairVehicleTableViewCell.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 16/01/2025.
//

import UIKit

class RepairVehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vehicleTitle: UILabel!
    @IBOutlet weak var vehicleType: UILabel!
    @IBOutlet weak var repairDate: UILabel!
    @IBOutlet weak var amountRepair: UILabel!
    @IBOutlet weak var repairDetails: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
