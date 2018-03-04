//
//  BoulderTableViewController.swift
//  ClimbTracker
//
//  Created by this_guy on 7/5/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit
import os.log

class BoulderTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var boulders = [Boulder]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedboulders = loadBoulders() {
            boulders += savedboulders
        }
        else {
            //Load the sample data
            loadSampleBoulders()
        }
        
        //Load the sample data
        //loadSampleBoulders()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return boulders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BoulderTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BoulderTableViewCell else {
            fatalError("The dequeued cell is not an instance of BoulderTableViewCell.")
        }
        
        //Fetches the appropriate boulder for the data source layout
        let boulder = boulders[indexPath.row]
        
        cell.nameLabel.text = boulder.name
        cell.photoImageView.image = boulder.photo
        cell.ratingControl.rating = boulder.rating
        cell.gradeLabel.text = "V" + String(Int(boulder.grade))
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            boulders.remove(at: indexPath.row)
            saveBoulders()
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddBoulder":
            os_log("Adding a new boulder.", log: OSLog.default, type: .debug)
            
        case "ShowBoulderDetail":
            
            guard let boulderDetailViewController = segue.destination as? BoulderViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBoulderCell = sender as? BoulderTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBoulderCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBoulder = boulders[indexPath.row]
            boulderDetailViewController.boulder = selectedBoulder
            
        case "boulderToHomeSegue":
            os_log("Going back home.", log: OSLog.default, type: .debug)
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToBoulderList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? BoulderViewController, let boulder = sourceViewController.boulder {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Update an existing boulder
                boulders[selectedIndexPath.row] = boulder
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
                
            else {
                //Add a new boulder
                let newIndexPath = IndexPath(row: boulders.count, section: 0)
                
                boulders.append(boulder)
                
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //Save the boulders.
            saveBoulders()
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleBoulders() {
        let photo1 = UIImage(named: "NewRiverGorgeCave")
        
        guard let boulder1 = Boulder(name: "Fuck yo Couch", photo: photo1, rating: 1, grade: 5, attempts: 1, completion: 100, datetime: DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.full, timeStyle: DateFormatter.Style.medium)) else {
            fatalError("Unable to instantiate boulder1")
        }
        
        boulders += [boulder1]
    }
    
    private func saveBoulders() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(boulders, toFile: Boulder.ArchiveUrl.path)
        
        if isSuccessfulSave {
            os_log("Boulders successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save boulders", log: OSLog.default, type: .error)
        }
    }
    
    private func loadBoulders() -> [Boulder]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Boulder.ArchiveUrl.path) as? [Boulder]
    }
}

