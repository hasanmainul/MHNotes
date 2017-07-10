//
//  NotesManager.swift
//  Notes
//
//  Created by mainul on 7/10/17.
//  Copyright © 2017 mainul. All rights reserved.
//

import UIKit

class NotesManager: NSObject {
    
    override init() {
        super.init()
    }
    
    private var noteDictArray = [[String: AnyObject]]()
    
    static let shared = NotesManager()
    let defaults = UserDefaults.standard
    
    func saveNoteToDefaults(note: Note) {
        let noteDict = note.objectToDict()
        noteDictArray.append(noteDict)
        defaults.set(noteDictArray, forKey: Constants.notesKey)
        defaults.synchronize()
    }
    
    func getNotes() -> [Note]? {
        var notes = [Note]()
        noteDictArray = defaults.object(forKey: Constants.notesKey) as? [[String: AnyObject]] ?? [[String: AnyObject]]()
        for eachNoteDict in noteDictArray {
            let note = Note(dict: eachNoteDict)
            notes.append(note)
        }
        return notes
    }
    
    func updateNote(note: Note) {
        noteDictArray = defaults.object(forKey: Constants.notesKey) as? [[String: AnyObject]] ?? [[String: AnyObject]]()
        let noteDict = note.objectToDict()
        
        for (index, value) in noteDictArray.enumerated() {
            if value[Constants.noteIdKey] as! String == noteDict[Constants.noteIdKey] as! String {
                noteDictArray.remove(at: index)
                noteDictArray.append(noteDict)
                break
            }
        }
        
        defaults.set(noteDictArray, forKey: Constants.notesKey)
        defaults.synchronize()
    }
    
    func deleteNote(note: Note) {
        noteDictArray = defaults.object(forKey: Constants.notesKey) as? [[String: AnyObject]] ?? [[String: AnyObject]]()
        let noteDict = note.objectToDict()
        
        for (index, value) in noteDictArray.enumerated() {
            if value[Constants.noteIdKey] as! String == noteDict[Constants.noteIdKey] as! String {
                noteDictArray.remove(at: index)
                break
            }
        }
        
        defaults.set(noteDictArray, forKey: Constants.notesKey)
        defaults.synchronize()
        
    }
    
}
