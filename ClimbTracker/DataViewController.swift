//
//  DataViewController.swift
//  ClimbTracker
//
//  Created by this_guy on 7/5/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit
import os.log

class DataViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func GoHome(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "dataToHomeSegue", sender: self)
    }
}


