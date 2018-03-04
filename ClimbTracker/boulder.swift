//
//  boulder.swift
//  ClimbTracker
//
//  Created by this_guy on 7/5/17.
//  Copyright © 2017 this_guy. All rights reserved.
//

import UIKit
import os.log

class Boulder: NSObject, NSCoding {
    
    // MARK: Propeties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var grade: Float
    var attempts: Float
    var completion: Float
    var datetime: String
    
    //Mark: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("boulders")
    
    //Mark: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let grade = "grade"
        static let attempts = "attempts"
        static let completion = "completion"
        static let datetime = "datetime"
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int, grade: Float, attempts: Float, completion: Float, datetime: String) {
        
        //The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 3) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
        self.grade = grade
        self.attempts = attempts
        self.completion = completion
        self.datetime = datetime
        
    }
    
    //Mark: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(grade, forKey: PropertyKey.grade)
        aCoder.encode(attempts, forKey: PropertyKey.attempts)
        aCoder.encode(completion, forKey: PropertyKey.completion)
        aCoder.encode(datetime, forKey: PropertyKey.datetime)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //The name is required. Of we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a boulder object.", log: OSLog.default, type:.debug)
            return nil
        }
        
        //Because photo is an optional property of Climb, just use a conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        let grade = aDecoder.decodeFloat(forKey: PropertyKey.grade)
        
        let attempts = aDecoder.decodeFloat(forKey: PropertyKey.attempts)
        
        let completion = aDecoder.decodeFloat(forKey: PropertyKey.completion)
        
        guard let datetime = aDecoder.decodeObject(forKey: PropertyKey.datetime) as? String else {
            os_log("Unable to decode the datetime for a boulder object.", log: OSLog.default, type:.debug)
            return nil
        }
        
        //Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, grade: grade, attempts: attempts, completion: completion, datetime: datetime)
    }
    
}

