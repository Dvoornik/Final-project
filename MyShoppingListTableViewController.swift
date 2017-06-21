//
//  MyShoppingListTableViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 6/7/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

import CoreData

class MyShoppingListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var MyShopList : String!
    var MyIngredientList : [IngredientListMO] = []
    var fetchResultsController : NSFetchedResultsController<IngredientListMO>!
    var NewIngredientList : IngredientMO!
    var secController : IngredientsTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // print(self.HeadTitle)
        // self.navigationItem.hidesBackButton = true
        
        self.navigationItem.title =  self.MyShopList
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backAction))
        
        // self.navigationItem.leftBarButtonItem?.title = "ShoppingList"
        // self.navigationItem.leftBarButtonItem?.action = #selector(backAction)
        
        let fetchRequest : NSFetchRequest<IngredientListMO> = IngredientListMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "ingname", ascending: true)
        //fetchRequest.predicate = NSPredicate(format: "iType == %@", self.HeadTitle)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "shoppinglist == %@", MyShopList)
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            do {
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    MyIngredientList = fetchedObjects
                    print(MyIngredientList.count)
                }
            }
            catch {
                print(error)
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Add background view to the table view
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black
        let backgroundImage : UIImage = UIImage(named: "groconwhiteboard.jpeg")!
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        //Gets rid of empty extra cells at the end of TV
        tableView.tableFooterView = UIView(frame: .zero)
        
        //fill the view with the image; or use .scaleAspectFit to fit the image to the view (will leave white spaces though)
        imageView.contentMode = .scaleAspectFill
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
        // #warning Incomplete implementation, return the number of rows
        return MyIngredientList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MyShoppingListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyShoppingListTableViewCell
        
        // Configure the cell...
        
        var cellItem : IngredientListMO
        cellItem = MyIngredientList[indexPath.row]
        cell.listingredient.text = cellItem.ingname
        
        return cell
    }
    
    /*
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     {
     print("selected", indexPath.section, indexPath.row)
     secController.MyShopList = MyShoppingList[indexPath.row].iSLname
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                let context = appDelegate.persistentContainer.viewContext
                let itemToDelete = self.fetchResultsController.object(at: indexPath)
                
                print("delete", indexPath.section, indexPath.row)
                
                print(itemToDelete)
                
                context.delete(itemToDelete)
                appDelegate.saveContext()
                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
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
            // MyShoppingList = fetchedObjects as! [ShoppingList]
            MyIngredientList = fetchedObjects as! [IngredientListMO]
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if segue.identifier == "AddIngredient" {
            print("ingredient list")
            secController = segue.destination as? IngredientsTableViewController
            secController.MyShopList = MyShopList
        }
    }
    
    func backAction(){
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        for aViewController:UIViewController in viewControllers {
            if aViewController.isKind(of: ShoppingListTableViewController.self) {
                _ = self.navigationController?.popToViewController(aViewController, animated: true)
            }
        }
    }
}
