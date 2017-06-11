//
//  MyTableViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 5/31/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var HeadTitle : String!
    var MyDish : [DishDO] = []
    var fetchResultsController : NSFetchedResultsController<DishDO>!
    
    var dishes = ["Bruchetta","Fried Chicken"]
    var type = ["Appetizers","Main Dish"]
    var image = ["appetizers","maindish"]
    
    
    /*var AppetizersRecipeBook = [
        Recipe(recType: "Appetizers", recName: "Bruchetta", recImage: #imageLiteral(resourceName: "appetizers"),
    ingredients: [
                Ingredient(ingrType: "Bread", name: "Baguette", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "appetizers")),
                Ingredient(ingrType: "Fish", name: "Smoked Salmon", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "appetizers")),
                Ingredient(ingrType: "Cheese", name: "Mozarella", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "appetizers")),
                Ingredient(ingrType: "Herb", name: "Chives", amount: "2 oz", ingrImage: #imageLiteral(resourceName: "appetizers"))])
        ]
    
    var MainDishesRecipeBook = [
        Recipe(recType: "Main Dish", recName: "Fried Chicken", recImage: #imageLiteral(resourceName: "maindish"),
    ingredients: [
                Ingredient(ingrType: "Meat", name: "Chicken", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "maindish")),
                Ingredient(ingrType: "Condiment", name: "Ketchup", amount: "50 oz", ingrImage: #imageLiteral(resourceName: "maindish")),
                Ingredient(ingrType: "Condiment", name: "Ranch Sauce", amount: "50 oz", ingrImage: #imageLiteral(resourceName: "maindish")),
                Ingredient(ingrType: "Vegetable", name: "Potato", amount: "1 lb", ingrImage: #imageLiteral(resourceName: "maindish"))])
    ]*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //addData()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = self.HeadTitle
        
        /*let fetchRequest : NSFetchRequest<DishDO> = DishDO.fetchRequest()
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    MyDish = fetchedObjects
            
                }
            }
                catch {
                    print(error)
                }
            }*/
        }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        switch type {
            case .insert:
                if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            case .delete:
                if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            MyDish = fetchedObjects as! [DishDO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
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
        
        /*var ItemCount : Int!
        var Item : DishDO
        Item = MyDish[section]
        if self.HeadTitle == Item.iType {
            ItemCount = MyDish.count
        }
        else if self.HeadTitle == Item.iType{
            ItemCount = MyDish.count
        }
        else {
            ItemCount = 1
        }
        // #warning Incomplete implementation, return the number of rows*/
        
        return MyDish.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RecipeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var cellItem : DishDO
        cellItem = MyDish[indexPath.row]
        
        cell.textLabel?.text = cellItem.iName
        cell.imageView?.image = UIImage(data: cellItem.iImage as! Data)
        
        /*if self.HeadTitle == cellItem.iType
        {
            cell.textLabel?.text = cellItem.iName
            cell.imageView?.image = UIImage(data: cellItem.iImage as! Data)
        }
        else if self.HeadTitle == cellItem.iType
        {
            cell.textLabel?.text = cellItem.iName
            cell.imageView?.image = UIImage(data: cellItem.iImage as! Data)
        }*/

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
    
    
    /*func addData() {
        
        var newItem: DishDO
    
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            
            for i in 0...dishes.count - 1 {
                
                newItem = DishDO(context: appDelegate.persistentContainer.viewContext)
                newItem.iName = dishes[i]
                newItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: image[i])!)!)
                newItem.iType = type[i]
                appDelegate.saveContext()
            }
        }
    }*/




}
