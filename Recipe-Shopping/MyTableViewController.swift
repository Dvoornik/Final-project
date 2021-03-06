//
//  MyTableViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 5/31/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate
{
    // Declared Variables //
    var HeadTitle : String!
    var MyDish : [DishDO] = []
    var fetchResultsController : NSFetchedResultsController<DishDO>!
    
    var searchController: UISearchController!
    var searchResults : [DishDO] = []
    
    var presetRecipeName = ["Bruschetta", "Cheese and Crackers", "Fried Chicken", "Seafood Pasta", "Cheesecake", "Peach Pie", "Cosmopolitan", "Daiquiri", "Power Salad", "Steak Salad"]
    var presetRecipeType = ["Appetizers", "Appetizers", "Main Dish", "Main Dish", "Desserts", "Desserts", "Drinks", "Drinks", "Salads", "Salads"]
    var presetRecipeImage = ["bruschetta", "cheeseplatter", "fried_chicken", "seafoodpasta", "cheesecake", "peachpie", "metropolitancocktail", "daiquiri", "salad", "steaksalad"]
    var presetRecipeDescription = ["3 tablespoons olive oil\n1 tablespoon snipped fresh chives\n1 tablespoon snipped fresh basil\n1 tablespoon lemon juice\n1 clove garlic, minced\n2 cups seeded and chopped plum and/or yellow tomatoes\n1/2 cup finely chopped red onion\nSalt\nFreshly ground black pepper\n1 8 ounce loaf baguette-style French bread\n\n1. In a medium bowl stir together 1 tablespoon of the olive oil, the chives, basil, lemon juice, and garlic. Add tomatoes and onion; toss to coat. Season to taste with salt and pepper. Set aside.\n\n2. Cut the bread into 36 slices. Arrange bread slices on 2 large baking sheets. Lightly brush one side of each slice with some of the remaining 2 tablespoons olive oil. Broil bread, one pan at a time, 3 to 4 inches from heat for 2 to 3 minutes or until toasted. Turn bread and broil other side for 1 to 2 minutes or until toasted.",
        "1 box of plain crackers\nAssorted blocks of cheeses\n\n1. Slice cheeses into small slices that can fit on the crackers.\n2. Lay crackers on a plate.\n3. Lay desired number of cheese slices on top of crackers.",
        "1 2 1/2 - 3 - pound broiler-fryer chicken cut up\n1/2 cup all-purpose flour\n1/2 teaspoon salt\n1/2 teaspoon pepper\n1 5 - ounce can evaporated milk\n2/3 cup water\nLard, shortening, or cooking oil\n\n1. In a shallow dish, stir together the all-purpose flour, salt, and pepper. Set aside.\n\n2. In a bowl, stir together the evaporated milk and the water. Set aside.\n\n3. In a 12-inch skillet, heat enough lard, shortening, or cooking oil over medium heat to make 1/2-inch depth. Dip the chicken pieces in the milk mixture. Then, roll chicken in the flour mixture.\n\n4. Cook the chicken in hot fat, uncovered, about 10 minutes or until the pieces are golden on the bottom. Turn and cook the pieces about 15 minutes more or until meat is easily pierced with a fork and no longer pink.\n\n5. Remove chicken pieces from the skillet. Drain the chicken on paper towels. Serve warm. Makes 4 to 6 servings.",
        "1 can of tomato sauce\n5 large prawns\n1/4 lb mussels\nParsley\nLinguine pasta\n5 garlic cloves\n\n1. Heat oil in a saucepan over medium heat. Add garlic to oil and cook, stirring, until golden brown. While garlic browns, pour tomatoes into a bowl; break them up using clean hands. Once garlic is browned, add tomatoes and their juices.\n2. Cook pasta according to package directions.\n3.Mix sauce and pasta. Serve and enjoy.",
        "9 graham cracker boards (4 crackers each)\n1 tablespoon sugar\npinch salt\n5 tablespoons unsalted butter\n4 8 - ounce packages cream cheese, softened\n1 1/4 cups sugar\n3 large eggs\n3 tablespoons all-purpose flour\n1 tablespoon vanilla extract\n\n1. Heat oven to 325 degrees.\n\n2. Place graham crackers in large resealable plastic bag and crush with a rolling pin. Transfer crumbs to small bowl and add sugar and salt. Stir in melted butter until all crumbs are evenly moistened.\n\n3. In large bowl, beat cream cheese until smooth. Add sugar and beat on low speed until blended. Add eggs, one at a time, beating well after each. Beat in flour and vanilla. Pour filling into crust.\n\n4. Bake cheesecake at 325 degrees for 1 hour. Turn oven off, prop door open and let cool in oven for 30 minutes. Remove from oven and cool completely. Refrigerate overnight. To serve, release and remove side of pan before slicing.",
        "5 cups fresh peaches, sliced\n1 cup sugar\n1⁄3-1⁄2 cup all-purpose flour\n1⁄4-1⁄2 teaspoon cinnamon\n2 tablespoons butter\n2 tablespoons sugar\n\nPreheat oven to 425 degrees F.\nStir together flour, 1 cup sugar, and cinnamon and set aside.\nWash, peel, and slice fresh peaches.\nMix together peaches with the combined dry ingredients.\nTurn into pastry-lined pie pan and dot with butter.\nCover with top crust, cut slits in it, seal the edges.\nSprinkle top with 2 tablespoons of sugar.\nCover the edges with foil to prevent over browning; remove foil for the last 15 minutes of baking.\nBake 35 to 45 minutes or until crust is brown and juice begins to bubble through the slits in the crust.\nPie may be frozen for future use.",
        "Ingredients: 1/2 oz Fresh lime juice, 1 oz Cranberry juice, 1/2 oz Cointreau, 1 1/2 oz Vodka Citron\n\nAdd all ingredients into cocktail shaker filled with ice. Shake well and double strain into large cocktail glass. Garnish with lime wheel.",
        "Ingredients: 1 1/2 oz White rum, 1/2 oz Simple syrup, 1 oz Lime juice\n\nPour all ingredients into shaker with ice cubes. Shake well. Strain in chilled cocktail glass.",
        "1 pkg (18 oz) Foxy Romaine Hearts, chopped\n1 large sweet potato, cooked and cut into rounds or cubed\n1 red onion, thinly sliced\n1/2 cup crumbled goat cheese\n1/4 cup chopped toasted pecans\n\n1. Dijon Mustard Dressing: Whisk together olive oil, maple syrup, vinegar, mustard, salt and pepper. Set aside.\n2. Autumn Power Salad: Divide romaine among 6 bowls. Top evenly with sweet potato, red onion, goat cheese, pecans, pumpkin seeds and dried cranberries. Drizzle with dressing.",
        "1/2 head romaine lettuce, cut into bite-size pieces\n1 large head Belgian endive, thinly sliced crosswise (about 1 1/2 cups)\n1/2 red onion, thinly sliced into rings\n3 cups fresh baby arugula\n\nIn a large bowl, combine the romaine lettuce, Belgian endive, red onion, baby arugula and cherry tomatoes, and half of the cheese. Toss the salad with enough vinaigrette to coat. Season the salad with salt and pepper, to taste. Arrange the salad on a platter.\n\nCut the steaks crosswise into thin slices. Arrange the steak slices atop the salad and sprinkle with the remaining cheese. Drizzle more vinaigrette over the steak slices and serve."]

    
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
        loadPresetData()
        
        //navigationController?.navigationBar.barTintColor = UIColor.black
        //navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = self.HeadTitle
        
        let fetchRequest : NSFetchRequest<DishDO> = DishDO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "iName", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "iType == %@", self.HeadTitle)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
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
            
        }
        
        //Add a searchController and searchBar to the app
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        //Next line fixes the bug to ensure that the search bar does not remain on the screen when
        //user navigates to different controller and the searchController is still active
        definesPresentationContext = true
        
        //Set search bar's background to match the rest of the view
        self.searchController.searchBar.backgroundImage = UIImage(named: "tablesample.png")
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        //Hide search bar from view until explicitly pulled down
        self.tableView.contentOffset = CGPoint(x: 0, y: 44)
        
        //Make 'Cancel' button in search bar white
        (UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])).tintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor.black
        //Add background view to the table view
        let backgroundImage : UIImage = UIImage(named: "tablesample.png")!
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        //Gets rid of empty extra cells at the end of TV
        tableView.tableFooterView = UIView(frame: .zero)
        
        //fill the view with the image; or use .scaleAspectFit to fit the image to the view (will leave white spaces though)
        imageView.contentMode = .scaleAspectFill
        
        //Blur effect
        /*
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        */
    }
    
    //Method to make table view cells transparent
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAt indexPath: IndexPath){
        //casting
        let myCell = cell as! RecipeTableViewCell
        //set cell's color to a partly transparent color
        myCell.backgroundColor = UIColor(white: 1, alpha: 0.5)
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

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searchController.isActive{
            return searchResults.count
        }
        else{
            return MyDish.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "RecipeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecipeTableViewCell
        
        var cellItem : DishDO
        if searchController.isActive{
            cellItem = searchResults[indexPath.row]
        }
        else{
            cellItem = MyDish[indexPath.row]
        }
        
        // Configure the cell...
        
        //cell.textLabel?.text = cellItem.iName
        //cell.imageView?.image = UIImage(data: cellItem.iImage as! Data)
        
            //display rounded image
            cell.cellRecipeImage?.layer.cornerRadius = cell.cellRecipeImage.frame.size.width/2.0
            cell.cellRecipeImage?.clipsToBounds = true
            cell.cellRecipeImage?.layer.masksToBounds = true
        
            cell.cellRecipeName?.text = cellItem.iName
            cell.cellRecipeType?.text = cellItem.iType
            cell.cellRecipeImage?.image = UIImage(data: cellItem.iImage as! Data)
        
            //fly-in animation
            var rotationTransform : CATransform3D = CATransform3DIdentity
            rotationTransform = CATransform3DTranslate(rotationTransform, -250, -250, 0)
            cell.cellRecipeImage?.layer.transform = rotationTransform
            UIView.animate(withDuration: 3.0, animations: { cell.cellRecipeImage?.layer.transform = CATransform3DIdentity})
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if searchController.isActive{
            return false
        }
        else{
            return true
        }
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                let context = appDelegate.persistentContainer.viewContext
                let itemToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(itemToDelete)
                appDelegate.saveContext()
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //hide search bar when transitioning between controllers
        self.tableView.contentOffset = CGPoint(x: 0, y: 44)
        
        if segue.identifier == "AddRecipe"{
            
            let detailVC = segue.destination as! AddRecipeViewController
            detailVC.TypeOfRecipe = self.HeadTitle
        }
        
        else if segue.identifier == "DetailViewRecipe" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                detailVC.recipeDetail = searchController.isActive ? searchResults[indexPath.row] : MyDish[indexPath.row]
            }
            
            //display only back arrow image without text in segue view
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        }

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func filterContentForSearchText(searchText: String) {
        searchResults = MyDish.filter({(ToDoItem: DishDO) -> Bool in
            let nameMatch = ToDoItem.iName?.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return nameMatch != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController){
        if let textToSearch = searchController.searchBar.text{
            filterContentForSearchText(searchText: textToSearch)
            tableView.reloadData()
        }
    }
    
    //For loading preset recipes to the recipe database
    func loadPresetData() {
        
        var addItem : DishDO!
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let request: NSFetchRequest<DishDO> = DishDO.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            do {
                MyDish = try context.fetch(request)
            } catch {
                print(error)
            }
        }
        
        if MyDish.count == 0 {
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                if MyDish.count == 0 {
                    
                    for i in 0...presetRecipeName.count - 1 {
                        addItem = DishDO(context: appDelegate.persistentContainer.viewContext)
                        addItem.iName = presetRecipeName[i]
                        addItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: presetRecipeImage[i])!)!)
                        addItem.iDescription = presetRecipeDescription[i]
                        addItem.iType = presetRecipeType[i]
                        appDelegate.saveContext()
                    }
                }
                
            }
        }
    }

}
