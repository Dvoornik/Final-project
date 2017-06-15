//
//  AddIngredientViewController.swift
//  Recipe-Shopping
//
//  Created by Connie Lun on 6/14/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//


import UIKit
import CoreData

class AddIngredientViewController: UIViewController {
    
    // Declared Variables //
 
    @IBOutlet weak var IngredientName: UITextField!
    @IBOutlet weak var ImageName: UITextField!
    @IBOutlet weak var Preview: UIButton!
    @IBOutlet weak var PreviewImage: UIImageView!
    @IBOutlet weak var PreviewImageError: UILabel!

    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var Save: UIButton!
    
    var newItem : IngredientMO!
    var TypeOfRecipe : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Save.layer.cornerRadius = 5
        Cancel.layer.cornerRadius = 5
        Preview.layer.cornerRadius = 5
        
       PreviewImage.image = #imageLiteral(resourceName: "placeholder")
        

        print("load Add Ingredient")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Preview(_ sender: Any)
    {
        // Unhides the error message if the user inputed a image name that is not found in our Assets. Sets a placeholder image instead.
        
        print("preview press")
        
        if(PreviewImageError.isHidden == false)
        {
            PreviewImageError.isHidden = true
        }
        
        let name = ImageName.text!
        
        PreviewImage.image = UIImage(named: name)
        if(PreviewImage.image == nil || PreviewImage.image == #imageLiteral(resourceName: "placeholder"))
        {
            PreviewImage.image = UIImage(named: "placeholder")
            PreviewImageError.isHidden = false
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        print("cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any)
    {
        print("save")
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        {
            newItem = IngredientMO(context: appDelegate.persistentContainer.viewContext)
            
            // newItem.ingrType = self.TypeOfRecipe
            // Crashes if the image name does not exist in the app so this checks for that.
            if(PreviewImageError.isHidden == false)
            {
                PreviewImageError.isHidden = true
            }
            let name = ImageName.text!
            PreviewImage.image = UIImage(named: name)
            if(PreviewImage.image == nil || PreviewImage.image == #imageLiteral(resourceName: "placeholder"))
            {
                PreviewImage.image = UIImage(named: "placeholder")
                PreviewImageError.isHidden = false
            }
            if(PreviewImage.image != nil || PreviewImage.image == #imageLiteral(resourceName: "placeholder"))
            {
                // did not finish....
                //newItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: Image.text!)!)!)
            }
            // newItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: ImageName.text!)!)!)
            newItem.ingname = IngredientName.text!
            
            appDelegate.saveContext()
        }
        self.dismiss(animated: true, completion: nil)
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
