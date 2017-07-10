//
//  Notes.swift
//  Notes
//
//  Created by mainul on 7/10/17.
//  Copyright © 2017 mainul. All rights reserved.
//

import Foundation

struct Note {
    let id: String
    var content: String
    var timeStamp: String
    var updateTimeStamp: String
    
    init(id: String, content: String, timeStamp: String, updateTimeStamp: String) {
        self.id = id
        self.content = content
        self.timeStamp = timeStamp
        self.updateTimeStamp = updateTimeStamp
    }
    
    init(dict: [String: AnyObject]) {
        self.id = dict[Constants.noteIdKey] as! String
        self.content = dict[Constants.noteContentKey] as! String
        self.timeStamp = dict[Constants.noteTimeStampKey] as! String
        self.updateTimeStamp = dict[Constants.noteUpdateTimeStamp] as! String
    }
    
    func objectToDict() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        dict[Constants.noteIdKey] = id as AnyObject
        dict[Constants.noteContentKey] = content as AnyObject
        dict[Constants.noteTimeStampKey] = timeStamp as AnyObject
        dict[Constants.noteUpdateTimeStamp] = updateTimeStamp as AnyObject
        return dict
    }
    
}
