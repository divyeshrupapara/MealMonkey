//
//  UPITableViewCell.swift
//  MealMonkey
//
//  Created by Divyesh Rupapara on 08/08/25.
//

import UIKit

class UPITableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewCell])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
