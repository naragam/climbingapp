//
//  DesignableSlider.swift
//  ClimbTracker
//
//  Created by this_guy on 5/27/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit

@IBDesignable

class DesignableSlider: UISlider {

    @IBInspectable var thumbImage: UIImage? {
        didSet{
            setThumbImage(thumbImage, for: .normal)
            setThumbImage(thumbImage, for: .highlighted)
        }
    }

}
