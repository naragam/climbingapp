//
//  ClimbTableViewController.swift
//  ClimbTracker
//
//  Created by this_guy on 5/27/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit
import os.log

class ClimbTableViewController: UITableViewController {

    //MARK: Properties
    
    var climbs = [Climb]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedClimbs = loadClimbs() {
            climbs += savedClimbs
        }
        else {
            //Load the sample data
            loadSampleClimbs()
        }
        
        //Load the sample data
        //loadSampleClimbs()
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
        return climbs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ClimbTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ClimbTableViewCell else {
            fatalError("The dequeued cell is not an instance of ClimbTableViewCell.")
        }
        
        //Fetches the appropriate climb for the data source layout
        let climb = climbs[indexPath.row]
        
        cell.nameLabel.text = climb.name
        cell.photoImageView.image = climb.photo
        cell.ratingControl.rating = climb.rating        
        switch (climb.grade) {
        case 0:
            cell.gradeLabel.text = "5." + String("Intro")
        case 1:
            cell.gradeLabel.text = "5." + String("5")
        case 2:
            cell.gradeLabel.text = "5." + String("6")
        case 3:
            cell.gradeLabel.text = "5." + String("7")
        case 4:
            cell.gradeLabel.text = "5." + String("8")
        case 5:
            cell.gradeLabel.text = "5." + String("9")
        case 6:
            cell.gradeLabel.text = "5." + String("10a")
        case 7:
            cell.gradeLabel.text = "5." + String("10b")
        case 8:
            cell.gradeLabel.text = "5." + String("10c")
        case 9:
            cell.gradeLabel.text = "5." + String("10d")
        case 10:
            cell.gradeLabel.text = "5." + String("11a")
        case 11:
            cell.gradeLabel.text = "5." + String("11b")
        case 12:
            cell.gradeLabel.text = "5." + String("11c")
        case 13:
            cell.gradeLabel.text = "5." + String("11d")
        case 14:
            cell.gradeLabel.text = "5." + String("12a")
        case 15:
            cell.gradeLabel.text = "5." + String("12b")
        case 16:
            cell.gradeLabel.text = "5." + String("12c")
        case 17:
            cell.gradeLabel.text = "5." + String("12d")
        case 18:
            cell.gradeLabel.text = "5." + String("13a")
        case 19:
            cell.gradeLabel.text = "5." + String("13b")
        case 20:
            cell.gradeLabel.text = "5." + String("13c")
        case 21:
            cell.gradeLabel.text = "5." + String("13d")
        case 22:
            cell.gradeLabel.text = "5." + String("13a")
        case 23:
            cell.gradeLabel.text = "5." + String("14b")
        case 24:
            cell.gradeLabel.text = "5." + String("14c")
        case 25:
            cell.gradeLabel.text = "5." + String("14d")
        case 26:
            cell.gradeLabel.text = "5." + String("15a")
        case 27:
            cell.gradeLabel.text = "5." + String("15b")
        case 28:
            cell.gradeLabel.text = "5." + String("15c")
        case 29:
            cell.gradeLabel.text = "5." + String("15d")
        case 30:
            cell.gradeLabel.text = "5." + String("16a")
        default:
            cell.gradeLabel.text = "5." + String("Intro")
        }
        

        // Configure the cell...

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            climbs.remove(at: indexPath.row)
            saveClimbs()
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
        
        case "AddClimb":
                os_log("Adding a new climb.", log: OSLog.default, type: .debug)
        
        case "ShowClimbDetail":
            
            guard let climbDetailViewController = segue.destination as? ClimbViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedClimbCell = sender as? ClimbTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedClimbCell) else {
                    fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedClimb = climbs[indexPath.row]
            climbDetailViewController.climb = selectedClimb
            
        case "climbToHomeSegue":
            os_log("Going back home.", log: OSLog.default, type: .debug)
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToClimbList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ClimbViewController, let climb = sourceViewController.climb {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Update an existing climb
                climbs[selectedIndexPath.row] = climb
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            
            else {
            //Add a new climb
            let newIndexPath = IndexPath(row: climbs.count, section: 0)
            
            climbs.append(climb)
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //Save the climbs.
            saveClimbs()
        }
    }

    @IBAction func GoHome(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "climbToHomeSegue", sender: self)
    }
    //MARK: Private Methods
    
    private func loadSampleClimbs() {
        let photo1 = UIImage(named: "NewRiverGorgeCave")
        
        guard let climb1 = Climb(name: "Fuck yo Couch", photo: photo1, rating: 1, grade: 5, attempts: 1, completion: 100, datetime: DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.full, timeStyle: DateFormatter.Style.medium)) else {
            fatalError("Unable to instantiate climb1")
        }
        
        climbs += [climb1]
    }
    
    private func saveClimbs() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(climbs, toFile: Climb.ArchiveUrl.path)
        
        if isSuccessfulSave {
            os_log("Climbs successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save climbs", log: OSLog.default, type: .error)
        }
    }
    
    private func loadClimbs() -> [Climb]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Climb.ArchiveUrl.path) as? [Climb]
    }
}
