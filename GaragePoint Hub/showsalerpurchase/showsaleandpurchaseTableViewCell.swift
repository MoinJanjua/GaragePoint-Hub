//
//  showsaleandpurchaseTableViewCell.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class showsaleandpurchaseTableViewCell: UITableViewCell {
    @IBOutlet weak var selecttypelb: UILabel!
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var vehiclename: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var ContactLabel: UILabel!
    @IBOutlet weak var noteslb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
