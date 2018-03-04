//
//  OptionsViewController.swift
//  ClimbTracker
//
//  Created by this_guy on 6/18/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Mark: Properties
    @IBOutlet weak var ClimbingButton: UIImageView!
    @IBOutlet weak var BoulderingButton: UIImageView!
    @IBOutlet weak var DataButton: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //Mark: Actions
    @IBAction func GoToClimbing(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "climbSegue", sender: self)
        print("going to climb!")
    }
    
    
    @IBAction func GoToBouldering(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "boulderSegue", sender: self)
        print("going to boulder!")
    }

    @IBAction func GoToData(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "dataSegue", sender: self)
        print("going to data!")
    }
}
