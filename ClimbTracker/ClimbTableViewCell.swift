//
//  ClimbTableViewCell.swift
//  ClimbTracker
//
//  Created by this_guy on 5/27/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit

class ClimbTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: ClimbRatingView!
    @IBOutlet weak var gradeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
