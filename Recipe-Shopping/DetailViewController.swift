//
//  DetailViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 5/31/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollContainer: UITextView!
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var RecipeDescription: UITextView!
    
    var recipeDetail : DishDO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.RecipeName.text = self.recipeDetail.iName
        self.RecipeImage.image = UIImage(data: self.recipeDetail.iImage as! Data)
        self.RecipeDescription.text = self.recipeDetail.iDescription
        
        //Name of recipe on navigation bar
        navigationItem.title = self.recipeDetail.iName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
