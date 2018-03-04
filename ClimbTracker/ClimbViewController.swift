//
//  ClimbViewController.swift
//  ClimbTracker
//
//  Created by this_guy on 5/1/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit
import os.log

class ClimbViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: ClimbRatingView!
    @IBOutlet weak var climbSaveButton: UIBarButtonItem!
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeSlide: UISlider!
    
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var completionSlide: UISlider!
    
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var attemptsSlide: UISlider!
    
    @IBOutlet weak var ClimbDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    /*
     This value is either passed by 'ClimbTableViewController' in `prepare(for:sender)` or constructed as part of adding a new climb
     */

    var climb: Climb?
    
    
    @IBAction func gradeSlider(_ sender: UISlider) {
        gradeSlide.value = roundf(sender.value)
        
        let grade = Int(sender.value)
        
        switch (grade) {
        case 0:
            gradeLabel.text = "5." + String("Intro")
        case 1:
            gradeLabel.text = "5." + String("5")
        case 2:
            gradeLabel.text = "5." + String("6")
        case 3:
            gradeLabel.text = "5." + String("7")
        case 4:
            gradeLabel.text = "5." + String("8")
        case 5:
            gradeLabel.text = "5." + String("9")
        case 6:
            gradeLabel.text = "5." + String("10a")
        case 7:
            gradeLabel.text = "5." + String("10b")
        case 8:
            gradeLabel.text = "5." + String("10c")
        case 9:
            gradeLabel.text = "5." + String("10d")
        case 10:
            gradeLabel.text = "5." + String("11a")
        case 11:
            gradeLabel.text = "5." + String("11b")
        case 12:
            gradeLabel.text = "5." + String("11c")
        case 13:
            gradeLabel.text = "5." + String("11d")
        case 14:
            gradeLabel.text = "5." + String("12a")
        case 15:
            gradeLabel.text = "5." + String("12b")
        case 16:
            gradeLabel.text = "5." + String("12c")
        case 17:
            gradeLabel.text = "5." + String("12d")
        case 18:
            gradeLabel.text = "5." + String("13a")
        case 19:
            gradeLabel.text = "5." + String("13b")
        case 20:
            gradeLabel.text = "5." + String("13c")
        case 21:
            gradeLabel.text = "5." + String("13d")
        case 22:
            gradeLabel.text = "5." + String("13a")
        case 23:
            gradeLabel.text = "5." + String("14b")
        case 24:
            gradeLabel.text = "5." + String("14c")
        case 25:
            gradeLabel.text = "5." + String("14d")
        case 26:
            gradeLabel.text = "5." + String("15a")
        case 27:
            gradeLabel.text = "5." + String("15b")
        case 28:
            gradeLabel.text = "5." + String("15c")
        case 29:
            gradeLabel.text = "5." + String("15d")
        case 30:
            gradeLabel.text = "5." + String("16a")
        default:
            gradeLabel.text = "5." + String("Intro")
        }
    }
    
    
    @IBAction func completionSlider(_ sender: UISlider) {
        completionSlide.value = roundf(sender.value)
        
        completionLabel.text = String(Int(sender.value)) + "%"
    }
    
    @IBAction func attemptsSlider(_ sender: UISlider) {
        attemptsSlide.value = roundf(sender.value)
        
        let attempts = Int(sender.value)
        
        switch (attempts) {
        case 1:
            attemptsLabel.text = "Flash"
        case 2:
            attemptsLabel.text = "Clean"
        case 7:
            attemptsLabel.text = "6+"
        default:
            attemptsLabel.text = String(attempts)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        ClimbDateTextField.text = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.full, timeStyle: DateFormatter.Style.medium)
        
        
        //Setup views if editing an existing Climb
        if let climb = climb {
            navigationItem.title = climb.name
            nameTextField.text = climb.name
            photoImageView.image = climb.photo
            attemptsSlide.value = climb.attempts
            completionSlide.value = climb.completion
            gradeSlide.value = climb.grade
            ratingControl.rating = climb.rating
            
            switch (climb.grade) {
            case 0:
                gradeLabel.text = "5." + String("Intro")
            case 1:
                gradeLabel.text = "5." + String("5")
            case 2:
                gradeLabel.text = "5." + String("6")
            case 3:
                gradeLabel.text = "5." + String("7")
            case 4:
                gradeLabel.text = "5." + String("8")
            case 5:
                gradeLabel.text = "5." + String("9")
            case 6:
                gradeLabel.text = "5." + String("10a")
            case 7:
                gradeLabel.text = "5." + String("10b")
            case 8:
                gradeLabel.text = "5." + String("10c")
            case 9:
                gradeLabel.text = "5." + String("10d")
            case 10:
                gradeLabel.text = "5." + String("11a")
            case 11:
                gradeLabel.text = "5." + String("11b")
            case 12:
                gradeLabel.text = "5." + String("11c")
            case 13:
                gradeLabel.text = "5." + String("11d")
            case 14:
                gradeLabel.text = "5." + String("12a")
            case 15:
                gradeLabel.text = "5." + String("12b")
            case 16:
                gradeLabel.text = "5." + String("12c")
            case 17:
                gradeLabel.text = "5." + String("12d")
            case 18:
                gradeLabel.text = "5." + String("13a")
            case 19:
                gradeLabel.text = "5." + String("13b")
            case 20:
                gradeLabel.text = "5." + String("13c")
            case 21:
                gradeLabel.text = "5." + String("13d")
            case 22:
                gradeLabel.text = "5." + String("13a")
            case 23:
                gradeLabel.text = "5." + String("14b")
            case 24:
                gradeLabel.text = "5." + String("14c")
            case 25:
                gradeLabel.text = "5." + String("14d")
            case 26:
                gradeLabel.text = "5." + String("15a")
            case 27:
                gradeLabel.text = "5." + String("15b")
            case 28:
                gradeLabel.text = "5." + String("15c")
            case 29:
                gradeLabel.text = "5." + String("15d")
            case 30:
                gradeLabel.text = "5." + String("16a")
            default:
                gradeLabel.text = "5." + String("Intro")
            }
            completionLabel.text = String(Int(climb.completion)) + "%"
            switch (Int(climb.attempts)) {
                case 1:
                attemptsLabel.text = "Flash"
                case 2:
                attemptsLabel.text = "Clean"
                case 7:
                attemptsLabel.text = "6+"
                default:
                attemptsLabel.text = String(climb.attempts)
            }
            
            ClimbDateTextField.text = climb.datetime
        }
        
        createDatePicker()
        
        //Enable the save button only if the text field has a valid climb name
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save button while editing.
        climbSaveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //Mark: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user cancelled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        //Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: Date picker function
    @IBAction func createDatePicker() {
        
        //format for picker
        datePicker.datePickerMode = .dateAndTime
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //Barbutton item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        ClimbDateTextField.inputAccessoryView = toolbar
        
        //assigning date picker to textfield
        ClimbDateTextField.inputView = datePicker
        
    }
    
    func donePressed() {
        
        //format date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        
        ClimbDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismiessed in two different ways.
        let isPresentingInAddClimbMode = presentingViewController is UINavigationController
        
        if isPresentingInAddClimbMode {
            dismiss(animated: true, completion: nil)
        }
        
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        
        else {
            fatalError("The ClimbViewController is not inside a navigation controller.")
        }
    }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === climbSaveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        let grade = gradeSlide.value
        let attempts = attemptsSlide.value
        let completion = completionSlide.value
        let datetime = ClimbDateTextField.text ?? ""
        
        climb = Climb(name: name, photo: photo, rating: rating, grade: grade, attempts: attempts, completion: completion, datetime: datetime)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhone(_ sender: UITapGestureRecognizer) {
        //based on https://www.raywenderlich.com/93276/implementing-tesseract-ocr-ios
        
        //Hide the keyboard.
        nameTextField.resignFirstResponder()
        // Create a UIAlertController with the action sheet style to present a set of capture options to the user.
        let imagePickerActionSheet = UIAlertController(title: "Take or upload a photo",
                                                       message: nil, preferredStyle: .actionSheet)
        // If the device has a camera, add the Take Photo button to imagePickerActionSheet. Selecting this button creates and presents an instance of UIImagePickerController with sourceType .Camera.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Smile real purdy for me!",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker,
                                                             animated: true,
                                                             completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        // Add a Choose Existing button to imagePickerActionSheet. Selecting this button creates and presents an instance of UIImagePickerController with sourceType .PhotoLibrary.
        let libraryButton = UIAlertAction(title: "Already got one, Ma!",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker,
                                                         animated: true,
                                                         completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        // Add a Cancel button to imagePickerActionSheet. Selecting this button cancels your UIImagePickerController, even though you don’t specify an action beyond setting the style as .Cancel.
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        // Finally, present your instance of UIAlertController.
        present(imagePickerActionSheet, animated: true,
                completion: nil)
    }
    
    //MARK: Private methods
    private func updateSaveButtonState() {
        //Disable the save button if the text field is empty.
        let text = nameTextField.text ?? ""
        climbSaveButton.isEnabled = !text.isEmpty
    }
}

