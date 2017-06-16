



import UIKit

import CoreData



class IngredientsTableViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    
    ////////// Declared Variables //////////
    var newItem : IngredientMO!
    
    var imagePassed : String?
    var descriptionPassed : String?
    
    var Ingredient : [IngredientMO] = []
    
    var sheaders : [Character] = []
    
    var sections : [Character: [String]] = [:]
    
    var index : [Int] = []
    
    var secIndex : [Int] = []
    
    var rowIndex : [Int] = []
    
    var oldSecCount : Int = 0
    
    var searchResults : [IngredientMO] = []
    var searchController : UISearchController!
    var fetchResultsController : NSFetchedResultsController<IngredientMO>!
    
    func update_table() {
        
        
        
        var scount = 0
        
        var rcount = 0
        
        var lastSymbol: Character = "?"
        
        var words = [String]()
        
        
        
        oldSecCount = index.count
        
        
        
        sheaders = []
        
        sections = [:]
        
        index = []
        
        secIndex = []
        
        rowIndex = []
        
        
        
        var i = 0
        
        
        
        for e in Ingredient {
            
            //print(Ingredient[i].ingname!)
            
            let word = e.ingname!
            
            if (word != "") {
                
                let symbol = word[word.startIndex]
                
                if (lastSymbol != symbol) {
                    
                    if (scount > 0) {
                        
                        sections[lastSymbol] = words
                        
                    }
                    
                    index.append(i)
                    
                    words = []
                    
                    scount = scount + 1
                    
                    rcount = 0
                    
                    sheaders.append(symbol)
                    
                }
                
                lastSymbol = symbol
                
                words.append(word)
                
            }
            
            secIndex.append(scount)
            
            rowIndex.append(rcount)
            
            rcount = rcount + 1
            
            print(secIndex[i], rowIndex[i])
            
            i = i + 1
            
        }
        
        sections[lastSymbol] = words
        
        
        
        print(sheaders)
        
        print(index)
        
        print(sections)
        
    }
    
    
    
    override func viewDidLoad()
        
    {
        
        super.viewDidLoad()
        
        //self.tableView.backgroundColor = UIColor.black
        
        
        
        // Code for the Search Bar
        
        self.searchController = UISearchController(searchResultsController: nil)
        
        self.searchController.searchBar.sizeToFit()
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.searchController.searchResultsUpdater = self
        
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        
        
        let fetchRequest : NSFetchRequest<IngredientMO> = IngredientMO.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "ingname", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
            
        {
            
            let context = appDelegate.persistentContainer.viewContext
            
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchResultsController.delegate = self
            
            
            
            do
                
            {
                
                try fetchResultsController.performFetch()
                
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    
                    Ingredient = fetchedObjects
                    
                    update_table()
                    
                }
                
            } catch { print(error) }
            
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool)
        
    {
        
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
        
    }
    
    
    
    /*
     
     override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
     
     let strArray = Array(sheaders).map { String($0) }
     
     return strArray
     
     }
     
     
     
     override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
     
     return index
     
     }
     
     */
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
        
    {
        
        cell.backgroundColor = UIColor.clear
        
    }
    
    
    
    override func didReceiveMemoryWarning()
        
    {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int
        
    {
        
        if (searchController.isActive)
            
        {
            
            return 1
            
        }
            
        else
            
        {
            
            return sheaders.count
            
        }
        
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        
        if (searchController.isActive)
            
        {
            
            return searchResults.count
            
        }
            
        else
            
        {
            
            // return Ingredient.count
            
            let symbol = sheaders[section]
            
            return sections[symbol]!.count
            
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
        
    {
        
        if (searchController.isActive)
            
        {
            
            return "Search Results"
            
        }
            
        else
            
        {
            
            return String(sheaders[section])
            
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
        
        
        
        var cellItem : IngredientMO
        
        
        
        if(searchController.isActive)
            
        {
            
            cellItem = searchResults[indexPath.row]
            
        }
            
        else
            
        {
            
            // cellItem = Ingredient[indexPath.row]
            
            cellItem = Ingredient[index[indexPath.section] + indexPath.row]
            
        }
        
        
        
        // Configure the cell...
        
        
        
        cell.ingname?.text = cellItem.ingname
        
        /*EXTRA
        cell.ElementNumber?.text = cellItem.elementNumber
        
        cell.ElementSymbol?.text = cellItem.elementSymbol
        
        cell.ElementMass?.text = cellItem.elementMass
        
        let icon = UIImage(named: cellItem.elementImage!)
        
        if (icon == nil) {
            
            cell.Photo?.image = #imageLiteral(resourceName: "placeholder")
            
        } else {
            
            cell.Photo?.image = UIImage(named: cellItem.elementImage!)
            
        }
        */
        
        
        return cell
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        
    {
        
        print("selected", index[indexPath.section], indexPath.section, indexPath.row)
        
        let selectedElement = searchController.isActive ? searchResults[indexPath.row] : Ingredient[index[indexPath.section] + indexPath.row]
        
        /*EXTRA
        imagePassed = selectedElement.elementImage
        
        descriptionPassed = selectedElement.elementDescription
        
        performSegue(withIdentifier: "ElementDetailSegue", sender: self)
 */
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
        
    {
        
        if(searchController.isActive)
            
        {
            
            return false
            
        }
            
        else
            
        {
            
            return true
            
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
        
    {
        
        if editingStyle == .delete
            
        {
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
                
            {
                
                let context = appDelegate.persistentContainer.viewContext
                
                var path = indexPath
                
                path.row = index[indexPath.section] + indexPath.row
                
                path.section = 0
                
                // let itemToDelete = self.fetchResultsController.object(at: indexPath)
                
                print(indexPath.row, indexPath.section, path.row, path.section)
                
                let itemToDelete = self.fetchResultsController.object(at: path)
                
                context.delete(itemToDelete)
                
                appDelegate.saveContext()
                
            }
            
        }
            
        else if editingStyle == .insert
            
        {
            
            
            
        }
        
    }
    
    
    /*EXTRA
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        
    {
        
        if(segue.identifier == "ElementDetailSegue")
            
        {
            
            if let indexPath = self.tableView.indexPathForSelectedRow
                
            {
                
                let elementDetailVC = segue.destination as! ElementDetailController
                
                elementDetailVC.ElementDetail = searchController.isActive ? searchResults[indexPath.row] : Ingredient[index[indexPath.section] + indexPath.row]
                
            }
            
        }
        
    }
    */
    
    
    func addData(newItem : IngredientMO)
        
    {
        
        Ingredient.append(newItem)
        
    }
    
    
    
    func filterContentForSearchText(searchText: String)
        
    {
        
        searchResults = Ingredient.filter({ (ElementItem: IngredientMO) -> Bool in
            
            let nameMatch = ElementItem.ingname?.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            
            //let numberMatch = ElementItem.elementNumber?.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            
            //return (nameMatch != nil || numberMatch != nil) })
            
            return nameMatch != nil })
        
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController)
        
    {
        
        if let textToSearch = searchController.searchBar.text
            
        {
            
            filterContentForSearchText(searchText: textToSearch)
            
            tableView.reloadData()
            
        }
        
    }
    
    
    
    // Functions for the NSFetchedResultsController
    
    
    
    func controllerWillChangeContent(_ controler: NSFetchedResultsController<NSFetchRequestResult>)
        
    {
        
        tableView.beginUpdates()
        
    }
    
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
        
    {
        
        if let fetchedObjects = controller.fetchedObjects
            
        {
            
            print("ok 2")
            
            Ingredient = fetchedObjects as! [IngredientMO]
            
            // update_table()
            
        }
        
        
        
        print("ok 1")
        
        
        
        switch type
            
        {
            
        case .insert:
            
            if var newIndexPath = newIndexPath
                
            {
                
                update_table()
                
                print("insert", newIndexPath.section, newIndexPath.row, secIndex[newIndexPath.row], rowIndex[newIndexPath.row])
                
                newIndexPath.section = secIndex[newIndexPath.row] - 1
                
                newIndexPath.row = rowIndex[newIndexPath.row]
                
                
                
                print(oldSecCount, sheaders.count)
                
                
                
                if (oldSecCount < sheaders.count) {
                    
                    tableView.insertSections([newIndexPath.section], with: .fade)
                    
                }
                
                tableView.insertRows(at: [newIndexPath], with: .fade)
                
                
                
            }
            
        case .delete:
            
            if var indexPath = indexPath
                
            {
                
                print("delete", indexPath.section, indexPath.row, secIndex[indexPath.row], rowIndex[indexPath.row])
                
                
                
                print(oldSecCount, sheaders.count)
                
                
                
                indexPath.section = secIndex[indexPath.row] - 1
                
                let oldRow = indexPath.row
                
                indexPath.row = rowIndex[indexPath.row]
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                let symbol = sheaders[secIndex[oldRow]-1]
                
                if (sections[symbol]!.count == 1)
                    
                {
                    
                    tableView.deleteSections([secIndex[oldRow]-1], with: .fade)
                    
                }
                
                
                
                update_table()
                
            }
            
        case .update:
            
            if let indexPath = indexPath
                
            {
                
                print("update")
                
                
                
                print("update", indexPath.section, indexPath.row)
                
                tableView.reloadRows(at: [indexPath], with: .fade)
                
            }
            
        default:
            
            print("default")
            
            tableView.reloadData()
            
        }
        
    }
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
        
    {
        
        tableView.endUpdates()
        
    }
    
    @IBAction func AddIngredientbtn(_ sender: Any) {
        let clickAddIngedient = UIAlertController(title: "New Ingredient", message: "Add New Ingredient", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let saveAction = UIAlertAction(title: "Save",style: .default) { (action: UIAlertAction!) -> Void in
            
            
            //let textField = clickAddIngedient.textFields!
            let name = clickAddIngedient.textFields?[0].text
            print("save")
            print("save")
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
            {
                self.newItem = IngredientMO(context: appDelegate.persistentContainer.viewContext)
                
                self.newItem.ingname = name
                
                appDelegate.saveContext()
                
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction!) -> Void in
            }
            
        clickAddIngedient.addTextField {
            (textField: UITextField!) -> Void in
            }
            
        clickAddIngedient.addAction(saveAction)
        clickAddIngedient.addAction(cancelAction)
            
        self.present(clickAddIngedient, animated: true, completion: nil)

        
    }

    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

