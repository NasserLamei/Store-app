//
//  ListCell.swift
//  Store App
//
//  Created by nassermac on 6/1/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var storenameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
