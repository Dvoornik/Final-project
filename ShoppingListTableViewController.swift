//
//  ShoppingListTableViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 6/16/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var HeadTitle : String!
    var MyShoppingList : [ShoppingList] = []
    var fetchResultsController : NSFetchedResultsController<ShoppingList>!
    var NewShoppingList : ShoppingList!
    var selectedList : String!
    var secController : MyShoppingListTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // self.navigationItem.title = self.HeadTitle
        self.navigationItem.title = "Shopping List"
        self.navigationItem.hidesBackButton = true

        let fetchRequest : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "iSLname", ascending: true)
        //fetchRequest.predicate = NSPredicate(format: "iType == %@", self.HeadTitle)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    MyShoppingList = fetchedObjects
                    print(MyShoppingList.count)
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
            MyShoppingList = fetchedObjects as! [ShoppingList]
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
        // #warning Incomplete implementation, return the number of rows
        return MyShoppingList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ShoppingListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShoppingListTableViewCell

        // Configure the cell...
        
        var cellItem : ShoppingList
        cellItem = MyShoppingList[indexPath.row]
        cell.shoppinglistName.text = cellItem.iSLname

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("selected", indexPath.section, indexPath.row)
        secController.MyShopList = MyShoppingList[indexPath.row].iSLname
    }

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
            context.delete(itemToDelete)
            appDelegate.saveContext()

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
        }
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
        print(segue.identifier)
        if segue.identifier == "MyShoppingList" {
            print("shop list")
            secController = segue.destination as? MyShoppingListTableViewController
            // {
                print("my title")
                // secController.HeadTitle = selectedList
            // }
        }
    }
    
    @IBAction func AddShoppingList(_ sender: Any) {
        let AddShoppinglistName = UIAlertController(title: "New Shopping List", message: "Add Shopping List Name", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default){
            (action: UIAlertAction!) -> Void in
            let name = AddShoppinglistName.textFields![0].text
                                        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            self.NewShoppingList = ShoppingList(context: appDelegate.persistentContainer.viewContext)
                                            
            self.NewShoppingList.iSLname = name
                                            
            appDelegate.saveContext()
        }
                                        
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default){ (action: UIAlertAction!) -> Void in
        }
        
        AddShoppinglistName.addTextField {
            (textField: UITextField!) -> Void in
        }
        
        AddShoppinglistName.addAction(saveAction)
        AddShoppinglistName.addAction(cancelAction)
        
        self.present(AddShoppinglistName,
                     animated: true,
                     completion: nil)
    
        
    }

}
