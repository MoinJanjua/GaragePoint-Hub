//
//  EmployeeTableViewCell.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Employeename: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var dateofjoiningLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
