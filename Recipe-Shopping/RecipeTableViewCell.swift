//
//  RecipeTableViewCell.swift
//  Recipe-Shopping
//
//  Created by Steve Xuan Tu on 6/12/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell
{
    // Declared Outlets //
    @IBOutlet weak var cellRecipeName: UILabel!
    @IBOutlet weak var cellRecipeType: UILabel!
    @IBOutlet weak var cellRecipeImage: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
