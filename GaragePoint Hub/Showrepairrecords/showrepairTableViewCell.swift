//
//  showrepairTableViewCell.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class showrepairTableViewCell: UITableViewCell {

    @IBOutlet weak var mechanicname: UILabel!
    @IBOutlet weak var vehiclename: UILabel!
    @IBOutlet weak var dateofrepair: UILabel!
    
    @IBOutlet weak var ownername: UILabel!
    @IBOutlet weak var repairamount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
