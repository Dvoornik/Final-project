//
//  Ingredient.swift
//  Recipe-Shopping
//
//  Created by alena on 6/1/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class Ingredient: NSObject
{
    var ingrType = ""
    var name = ""
    var ingrImage = UIImage(named: "")
    var amount = ""

    init(ingrType: String, name: String, amount: String, ingrImage: UIImage)
    {
        self.ingrType = ingrType
        self.name = name
        self.ingrImage = ingrImage
        self.amount = amount
    }
}

class myIngredientList: NSObject
{
    var ingname = ""
    var shoppinglist = ""
    
    init(name: String, listname: String) {
        self.ingname = name
        self.shoppinglist = listname
    }
}
