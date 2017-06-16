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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar for current view controller
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.isNavigationBarHidden = false;
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
        else if segue.identifier == "MainDish" || segue.identifier == "Bulgogi" || segue.identifier == "Soup" || segue.identifier == "Meatpie"{
            
            let detailVC = segue.destination as! MyTableViewController
            detailVC.HeadTitle = "Main Dish"
        }
        else if segue.identifier == "ShoppingList" {
            
            let detailVC = segue.destination as! ShoppingListTableViewController
            detailVC.HeadTitle = "Shopping List"
        }
        else if segue.identifier == "Desserts" {
            let detailVC = segue.destination as! MyTableViewController
            detailVC.HeadTitle = "Desserts"
        }
        else if segue.identifier == "Salads"{
            let detailVC = segue.destination as! MyTableViewController
            detailVC.HeadTitle = "Salads"
        }
        else if (segue.identifier == "Drinks" || segue.identifier == "Cocktail" || segue.identifier == "Hotdrink"){
            let detailVC = segue.destination as! MyTableViewController
            detailVC.HeadTitle = "Drinks"
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }



}

