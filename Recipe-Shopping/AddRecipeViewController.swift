//
//  AddRecipeViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 6/7/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeViewController: UIViewController
{
    // Declared Variables //
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Image: UITextField!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var previewImageError: UILabel!
    
    
    // Declared Variables //
    var newItem : DishDO!
    var TypeOfRecipe : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Preview(_ sender: Any)
    {
        // Unhides the error message if the user inputed a image name that is not found in our Assets. Sets a placeholder image instead.
        if(previewImageError.isHidden == false)
        {
            previewImageError.isHidden = true
        }
        
        let name = Image.text!
        
        previewImage.image = UIImage(named: name)
        if(previewImage.image == nil || previewImage.image == #imageLiteral(resourceName: "placeholder"))
        {
            previewImage.image = UIImage(named: "placeholder")
            previewImageError.isHidden = false
        }
    }
    
    
    @IBAction func Cancel(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any)
    {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        {
            newItem = DishDO(context: appDelegate.persistentContainer.viewContext)
            
            newItem.iType = self.TypeOfRecipe
            // Crashes if the image name does not exist in the app so this checks for that. -S.T.
            if(previewImageError.isHidden == false)
            {
                previewImageError.isHidden = true
            }
            let name = Image.text!
            previewImage.image = UIImage(named: name)
            
            if(previewImage.image == nil || previewImage.image == #imageLiteral(resourceName: "placeholder")) // This will set the image as placeholder in CoreData instead of crashing the app with an unknown image name. -S.T.
            {
                previewImage.image = UIImage(named: "placeholder")
                //previewImageError.isHidden = false
                newItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: "placeholder")!)!)
            }
            else // This will set the image as the specified image name and will avoid the crash. -S.T.
            {
                newItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: Image.text!)!)!)
            }
            newItem.iName = Name.text!
            
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
