//
//  MyTableViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 5/31/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var HeadTitle : String!
    
    var RecipeBook = [
        Recipe(recType: "Appetizers", recName: "Bruchetta", recImage: #imageLiteral(resourceName: "appetizers"),
    ingredients: [
                Ingredient(ingrType: "Bread", name: "Baguette", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "appetizers")),
                Ingredient(ingrType: "Fish", name: "Smaked Salmon", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "appetizers")),
                Ingredient(ingrType: "Cheese", name: "Mozarella", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "appetizers")),
                Ingredient(ingrType: "Herb", name: "Chive", amount: "2 oz", ingrImage: #imageLiteral(resourceName: "appetizers"))]),
        Recipe(recType: "Main Dish", recName: "Fried Chicken", recImage: #imageLiteral(resourceName: "maindish"),
    ingredients: [
                Ingredient(ingrType: "Meat", name: "Chicken", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "maindish")),
                Ingredient(ingrType: "Condiment", name: "Ketchup", amount: "50 oz", ingrImage: #imageLiteral(resourceName: "maindish")),
                Ingredient(ingrType: "Condiment", name: "Ranch Sauce", amount: "50 oz", ingrImage: #imageLiteral(resourceName: "maindish")),
                Ingredient(ingrType: "Vegetable", name: "Pototo", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "maindish"))])
    ]
    
    
    //Returns number of recipes of certain type and is called in
    //override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func numberOfRecipes(recType: String) -> Int{
        let totalRecipes = RecipeBook.count
        var total = 0
        for i in 0..<totalRecipes{
            if RecipeBook[i].recType.lowercased() == recType.lowercased(){
                total += 1
            }
        }
        return total
    }

    
    /*
    var AppetizerName = ["Appetizer One", "Appetizer Two", "Appetizer Three"]
    var AppetizerImage = [#imageLiteral(resourceName: "appetizers"), #imageLiteral(resourceName: "appetizers"), #imageLiteral(resourceName: "appetizers")]
    var MaindishName = ["Main Dish One", "Main Dish Two"]
    var MaindishImage = [#imageLiteral(resourceName: "maindish"),#imageLiteral(resourceName: "maindish")]
 */

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = self.HeadTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var ItemCount : Int!
        if self.HeadTitle == "Appetizers"{
            ItemCount = numberOfRecipes(recType: "Appetizers")        }
        else if self.HeadTitle == "Main Dish"{
            ItemCount = numberOfRecipes(recType: "Main Dish")
        }
        // #warning Incomplete implementation, return the number of rows
        return ItemCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RecipeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if self.HeadTitle == "Appetizers"{
            cell.textLabel?.text = RecipeBook[indexPath.row].recName
            cell.imageView?.image = RecipeBook[indexPath.row].recImage
        }
        else if self.HeadTitle == "Main Dish"{
            cell.textLabel?.text = RecipeBook[indexPath.row].recName
            cell.imageView?.image = RecipeBook[indexPath.row].recImage
        }

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
