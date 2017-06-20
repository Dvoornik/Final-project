//
//  AddRecipeViewController.swift
//  Recipe-Shopping
//
//  Created by Sergey on 6/7/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{
    //////////// Declared Outlets ////////////
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Image: UITextField!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var previewImageError: UILabel!
    @IBOutlet weak var autocompleteTableView: UITableView!

    
    //////////// Declared Variables ////////////
    var newItem : DishDO!
    var TypeOfRecipe : String!
    var autocompleteList : [String] = ["antipasto", "blinzy", "bruschetta", "bruschettafunghi", "bulgogi", "caipirinha", "capreze", "cheeseplatter", "cherrydaiquiri", "cherrypie", "chocolateicecream", "cinnaparts", "cocktail", "currentspie", "daiquiri", "foilcherrypie", "fruitcheeseboard", "greekmezze", "greenteaicecream", "icecream", "icereamassortment", "icedtea", "iris", "lemonade", "maindish", "meatpie", "metropolitancocktail", "pasta", "peachpie", "pineappleicecream", "placeholder", "pomegrandeliqueur", "pomegrandemojito", "prunepie", "raspberrypie", "redvelvet", "roastedchicken", "salad", "seafoodpasta", "taco", "tea", "tortillasoup"]
    var autocompleteResults : [String] = []
    var recipeSteps : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Image.delegate = self
        autocompleteTableView.delegate = self
        
        //Add background to add view controller
        var backgroundImage : UIImage = UIImage(named: "detailbackground.png")!
        let myInsets : UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backgroundImage = backgroundImage.resizableImage(withCapInsets: myInsets)
        self.view.backgroundColor = UIColor.init(patternImage:backgroundImage)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addSteps(_ sender: Any)
    {
        // Perform the segue into the Add Steps VC. -S.T.
        performSegue(withIdentifier: "addStepSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // if the segue ID is this... -S.T.
        if(segue.identifier == "addStepSegue")
        {
            // ... send the recipe name and the recipe object to the Add Step VC for clarity to the user. -S.T.
            let addStepVC = segue.destination as! AddStepsForRecipeViewController
            if(Name.text != nil || Name.text != "")
            {
                print("1 inside addStepVC")
                //addStepVC.newRecipe = newItem
                addStepVC.recipeText = addData
                print("inside addStepVC")
                //print(addStepVC.recipeText)
                //addStepVC.recipeNameString = recipeSteps
                addStepVC.recipeNameString = Name.text!
            }
            else // This prevents a crash if the user leaves the Name textfield empty.
            {
                //addStepVC.recipeNameString = recipeSteps
                //addStepVC.newRecipe = newItem
            }
        }
        print("do I get called?")
    }
    
    func addData(newText: String){
        recipeSteps = newText
        print("Printing recipe Steps")
        print(recipeSteps)
    }
    
    @IBAction func Preview(_ sender: Any)
    {
        // Unhides the error message if the user inputed a image name that is not found in our Assets. Sets a placeholder image instead. -S.T.
        if(previewImageError.isHidden == false)
        {
            previewImageError.isHidden = true
        }
        
        let name = Image.text!
        
        previewImage.image = UIImage(named: name)
        if(previewImage.image == nil || previewImage.image == #imageLiteral(resourceName: "placeholder"))
        {
            previewImage.image = UIImage(named: "placeholder")
            previewImageError.isHidden = false
        }
    }
    
    @IBAction func Cancel(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any)
    {
        print("Inside Save button in AddRecipeController @ start")
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        {
            newItem = DishDO(context: appDelegate.persistentContainer.viewContext)
            
            newItem.iType = self.TypeOfRecipe
            // Crashes if the image name does not exist in the app so this checks for that. -S.T.
            if(previewImageError.isHidden == false)
            {
                previewImageError.isHidden = true
            }
            let name = Image.text!
            previewImage.image = UIImage(named: name)
            
            if(previewImage.image == nil || previewImage.image == #imageLiteral(resourceName: "placeholder")) // This will set the image as placeholder in CoreData instead of crashing the app with an unknown image name. -S.T.
            {
                previewImage.image = UIImage(named: "placeholder")
                //previewImageError.isHidden = false
                newItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: "placeholder")!)!)
            }
            else // This will set the image as the specified image name and will avoid the crash. -S.T.
            {
                newItem.iImage = NSData(data:UIImagePNGRepresentation(UIImage(named: Image.text!)!)!)
            }
            newItem.iName = Name.text!
            print("Inside Save button in AddRecipeController @ right before recipe steps")
            newItem.iDescription = recipeSteps
            // saveContext should also save the recipe steps if you already added them. -S.T.
            appDelegate.saveContext()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    /////////////////////////////////////////////////////
    //////////// Autocomplete Tableview code ////////////
    /////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return autocompleteResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autocompleteCell", for: indexPath) as UITableViewCell
        // Cells will repopulate with the autocompletion results as you type in the Image textfield.
        cell.textLabel!.text = autocompleteResults[indexPath.row]
        return cell
    }
    // Takes the string in the Image textfield and finds any matching string in the autocomplete array. -S.T.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchAutocompleteEntriesWithSubstring(substring)
        return true
    }
    // Finds any matching string in the array and returns that to the tableview.
    func searchAutocompleteEntriesWithSubstring(_ substring: String)
    {
        autocompleteResults.removeAll(keepingCapacity: false)
        for key in autocompleteList
        {
            let myString : NSString! = key as NSString
            let substringRange : NSRange! = myString.range(of: substring)
            if (substringRange.location  == 0)
            {
                autocompleteResults.append(key)
            }
        }
        autocompleteTableView.reloadData()
    }
    // This allows autocompletion to happen by clicking on a cell. Will replace/autocomplete the Image textfield with the cell's text.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        Image.text = selectedCell.textLabel!.text!
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
