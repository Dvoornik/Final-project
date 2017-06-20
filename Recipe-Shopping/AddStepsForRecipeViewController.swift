//
//  AddStepsForRecipeViewController.swift
//  Recipe-Shopping
//
//  Created by Steve Xuan Tu on 6/19/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class AddStepsForRecipeViewController: UIViewController
{
    ////////// Declared Outlets //////////
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDescription: UITextView!
    
    ////////// Declared Variables //////////
    var newRecipe : DishDO!
    var recipeNameString : String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Add background to add view controller
        var backgroundImage : UIImage = UIImage(named: "detailbackground.png")!
        let myInsets : UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backgroundImage = backgroundImage.resizableImage(withCapInsets: myInsets)
        self.view.backgroundColor = UIColor.init(patternImage:backgroundImage)

        // Do any additional setup after loading the view.
        if(recipeNameString == "")
        {
            recipeName.text = "My Recipe"
        }
        else
        {
            recipeName.text = recipeNameString
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Cancel(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any)
    {
        // Save the recipe steps to the recipe object. Does not save it to CoreData yet. -S.T.
        // Strangely, this will result in a fatal error... -S.T.
        newRecipe.iDescription = String(recipeDescription.text)
        
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
