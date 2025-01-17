//
//  SaleTableViewCell.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 16/01/2025.
//

import UIKit

class SaleTableViewCell: UITableViewCell  {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var vehicleType: UILabel!
    @IBOutlet weak var selectedtype: UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

