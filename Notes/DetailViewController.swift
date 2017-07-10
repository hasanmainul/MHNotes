//
//  DetailViewController.swift
//  Notes
//
//  Created by mainul on 7/9/17.
//  Copyright © 2017 mainul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var noteContentTextView: UITextView!
    
    var noteToEdit: Note?
    var isEditingNote = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        prepareData()
    }
    
    // MARK: - Custom Method
    
    func prepareData() {
        if isEditingNote {
            if let _ = noteToEdit {
                noteContentTextView.text = noteToEdit?.content
            }
        } else {
            noteContentTextView.text = ""
        }
    }

    func setupUI() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "noteBG")?.draw(in: self.view.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else{
            UIGraphicsEndImageContext()
        }
        
        title = "Note"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Nothing to save", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func saveButtonTapped(selector: Any) {
        
        let noteContent = noteContentTextView.text.trimmingCharacters(in: .whitespaces)
        
        guard !noteContent.isEmpty else {
            showAlert()
            return
        }
        
        let time = Date()
        let idTimeStamp = String(time.ticks)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm dd/MM/yyyy"
        let timeStamp = timeFormatter.string(from: time)
        
        if isEditingNote {
            let note = Note(id: (noteToEdit?.id)!, content: noteContent, timeStamp: timeStamp, updateTimeStamp: idTimeStamp)
            NotesManager.shared.updateNote(note: note)
            
        } else {
            
            let note = Note(id: idTimeStamp, content: noteContent, timeStamp: timeStamp, updateTimeStamp: idTimeStamp)
            
            NotesManager.shared.saveNoteToDefaults(note: note)
        }
        
        self.navigationController?.popViewController(animated: true)

    }

}
