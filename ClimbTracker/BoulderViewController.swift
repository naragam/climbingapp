//
//  BoulderViewController.swift
//  ClimbTracker
//
//  Created by this_guy on 7/5/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit
import os.log

class BoulderViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: ClimbRatingView!
    @IBOutlet weak var BoulderSaveButton: UIBarButtonItem!
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeSlide: UISlider!
    
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var completionSlide: UISlider!
    
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var attemptsSlide: UISlider!
    
    @IBOutlet weak var BoulderDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    /*
     This value is either passed by 'BoulderTableViewController' in `prepare(for:sender)` or constructed as part of adding a new boulder
     */
    
    var boulder: Boulder?
    
    
    @IBAction func gradeSlider(_ sender: UISlider) {
        gradeSlide.value = roundf(sender.value)
        
        gradeLabel.text = "V" + String(Int(sender.value))
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
            attemptsLabel.text = String(attempts-1)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        BoulderDateTextField.text = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.full, timeStyle: DateFormatter.Style.medium)
        
        
        //Setup views if editing an existing boulder
        if let boulder = boulder {
            navigationItem.title = boulder.name
            nameTextField.text = boulder.name
            photoImageView.image = boulder.photo
            attemptsSlide.value = boulder.attempts
            completionSlide.value = boulder.completion
            gradeSlide.value = boulder.grade
            ratingControl.rating = boulder.rating
            gradeLabel.text = "V" + String(Int(boulder.grade))
            completionLabel.text = String(Int(boulder.completion)) + "%"
            switch (Int(boulder.attempts)) {
                case 1:
                attemptsLabel.text = "Flash"
                case 2:
                attemptsLabel.text = "Clean"
                case 7:
                attemptsLabel.text = "6+"
                default:
                attemptsLabel.text = String(boulder.attempts-1)
                }
            BoulderDateTextField.text = boulder.datetime
            
        }
        
        createDatePicker()
        
        //Enable the save button only if the text field has a valid Boulder name
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
        BoulderSaveButton.isEnabled = false
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        //The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
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
        
        BoulderDateTextField.inputAccessoryView = toolbar
        
        //assigning date picker to textfield
        BoulderDateTextField.inputView = datePicker
        
    }
    
    @objc func donePressed() {
        
        //format date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        
        BoulderDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismiessed in two different ways.
        let isPresentingInAddBoulderMode = presentingViewController is UINavigationController
        
        if isPresentingInAddBoulderMode {
            dismiss(animated: true, completion: nil)
        }
            
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
            
        else {
            fatalError("The BoulderViewController is not inside a navigation controller.")
        }
    }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === BoulderSaveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        let grade = gradeSlide.value
        let attempts = attemptsSlide.value
        let completion = completionSlide.value
        let datetime = BoulderDateTextField.text ?? ""
        
        boulder = Boulder(name: name, photo: photo, rating: rating, grade: grade, attempts: attempts, completion: completion, datetime: datetime)
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
        BoulderSaveButton.isEnabled = !text.isEmpty
    }
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
