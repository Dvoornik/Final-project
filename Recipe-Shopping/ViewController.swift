//
//  ViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 5/31/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Appetizers"{
            
            let detailVC = segue.destination as! MyTableViewController
            detailVC.HeadTitle = "Appetizers"
        }
        else if segue.identifier == "MainDish" {
            
            let detailVC = segue.destination as! MyTableViewController
            detailVC.HeadTitle = "Main Dish"
            
            
           
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }



}

