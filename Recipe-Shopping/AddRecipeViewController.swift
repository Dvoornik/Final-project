//
//  AddRecipeViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 6/7/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeViewController: UIViewController {
    
    @IBOutlet weak var RType: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Image: UITextField!
    
    var newItem : DishDO!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Save(_ sender: Any) {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            newItem = DishDO(context: appDelegate.persistentContainer.viewContext)
            
            newItem.iType = RType.text!
            newItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: Image.text!)!)!)
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
