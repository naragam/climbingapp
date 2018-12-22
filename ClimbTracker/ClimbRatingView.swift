//
//  ClimbRatingView.swift
//  ClimbTracker
//
//  Created by this_guy on 5/7/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit

@IBDesignable class ClimbRatingView: UIStackView {
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var ratingSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var ratingCount: Int = 3 {
        didSet {
            setupButtons()
        }
    }
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")}
        
        //Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //If the selected rating represents the current rating, reset the rating to 0
            rating = 0
        } else {
            // Otherwise set the rating to the selected rating
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let middleFinger = UIImage(named: "middleFinger", in: bundle, compatibleWith: self.traitCollection)
        let middleFingerSelected = UIImage(named: "middleFingerSelected", in: bundle, compatibleWith: self.traitCollection)
        
        let fistBump = UIImage(named: "fistBump", in: bundle, compatibleWith: self.traitCollection)
        let fistBumpSelected = UIImage(named: "fistBumpSelected", in: bundle, compatibleWith: self.traitCollection)
        
        let thumbsUp = UIImage(named: "thumbsUp", in: bundle, compatibleWith: self.traitCollection)
        let thumbsUpSelected = UIImage(named: "thumbsUpSelected", in: bundle, compatibleWith: self.traitCollection)
        
        for i in 0..<ratingCount {
            //Create the button
            let button = UIButton()
            switch (i) {
            case 0:
                button.setImage(middleFinger, for: .normal)
                button.setImage(middleFingerSelected, for: .selected)
                button.setImage(middleFingerSelected, for: .highlighted)
                button.setImage(middleFingerSelected, for: [.highlighted, .selected])
            case 1:
                button.setImage(fistBump, for: .normal)
                button.setImage(fistBumpSelected, for: .selected)
                button.setImage(fistBumpSelected, for: .highlighted)
                button.setImage(fistBumpSelected, for: [.highlighted, .selected])
            case 2:
                button.setImage(thumbsUp, for: .normal)
                button.setImage(thumbsUpSelected, for: .selected)
                button.setImage(thumbsUpSelected, for: .highlighted)
                button.setImage(thumbsUpSelected, for: [.highlighted, .selected])
            default:
                button.setImage(middleFinger, for: .normal)
                button.setImage(middleFingerSelected, for: .selected)
                button.setImage(middleFingerSelected, for: .highlighted)
                button.setImage(middleFingerSelected, for: [.highlighted, .selected])
            }
            
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: ratingSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant:ratingSize.width).isActive = true
            
            //Setup the button action
            button.addTarget(self, action: #selector(ClimbRatingView.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Add the button to the stack
            addArrangedSubview(button)
            
            //Add the new button to the rating button array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is the rating, that button should be selected
            button.isSelected = index+1 == rating
        }
    }
}
