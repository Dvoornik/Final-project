//
//  ViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 5/31/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var bulgogiBtn: UIButton!
    @IBOutlet weak var cocktailBtn: UIButton!
    @IBOutlet weak var saladBtn: UIButton!
    @IBOutlet weak var cinndrinkBtn: UIButton!
    @IBOutlet weak var appetizerBtn: UIButton!
    @IBOutlet weak var pieBtn: UIButton!
    @IBOutlet weak var appName: UITextView!
    @IBOutlet weak var shoplistBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        appName.text = "DISHBOOK"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.bulgogiBtn.alpha = 0
        self.cocktailBtn.alpha = 0
        self.saladBtn.alpha = 0
        self.cinndrinkBtn.alpha = 0
        self.appetizerBtn.alpha = 0
        self.pieBtn.alpha = 0
        self.shoplistBtn.alpha = 0
        
        //animate buttons on initial view
        UIView.animate(withDuration: 2.0, delay: 2.0, options: [], animations:
            {
                self.bulgogiBtn.alpha = 1
                self.cocktailBtn.alpha = 1
                self.saladBtn.alpha = 1
                self.cinndrinkBtn.alpha = 1
                self.appetizerBtn.alpha = 1
                self.pieBtn.alpha = 1
                self.shoplistBtn.alpha = 1
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {

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
        else if segue.identifier == "Bulgogi"{
            
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
        else if (segue.identifier == "Cocktail" || segue.identifier == "Hotdrink"){
            let detailVC = segue.destination as! MyTableViewController
            detailVC.HeadTitle = "Drinks"
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

