//
//  IngredientTableViewCell.swift
//  Recipe-Shopping
//
//  Created by Yong Liu on 6/14/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    
    @IBOutlet var ingname: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
