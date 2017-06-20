//
//  ShoppingListTableViewCell.swift
//  Recipe-Shopping
//
//  Created by Rose Lee on 6/20/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    @IBOutlet weak var shoppinglistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
