//
//  MyShoppingListTableViewCell.swift
//  Recipe-Shopping
//
//  Created by Rose Lee on 6/20/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class MyShoppingListTableViewCell: UITableViewCell {

    @IBOutlet weak var listingredient: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
