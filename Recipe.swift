//
//  Recipe.swift
//  Recipe-Shopping
//
//  Created by alena on 6/1/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    var recType = ""
    var recName = ""
    var recImage = UIImage(named: "")
    var ingredients : [Ingredient] = []

    init(recType: String, recName: String, recImage: UIImage, ingredients: [Ingredient]){
        self.recType = recType
        self.recName = recName
        self.recImage = recImage
        self.ingredients = ingredients
    }
}
