//
//  ListViewController.swift
//  Notes
//
//  Created by mainul on 7/9/17.
//  Copyright © 2017 mainul. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var noteListTableView: UITableView!
    
    var noteDeleteIndexPath: IndexPath?
    
    var dummyDataSource = [String]()
    var allNotes: [Note]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        preFetchData()
        setupUI()
        
        noteListTableView.reloadData()
    }
    
    // MARK: - Custom Methods
    
    func preFetchData() {
        dummyDataSource = ["Note 1",  "Note 2", "Note 3", "Note 4", "Note 5"]
        allNotes = NotesManager.shared.getNotes()
        allNotes = allNotes?.sorted(by: { (aNote, bNote) -> Bool in
            return aNote.updateTimeStamp > bNote.updateTimeStamp
        })
    }
    
    func setupUI() {
        noteListTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func confirmDelete(data: Note) {
        let alert = UIAlertController(title: "Delete Note", message: "Are you sure?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [unowned self] _ in
            if let indexPath = self.noteDeleteIndexPath {
                self.noteListTableView.beginUpdates()
                
                let noteToDelete = self.allNotes?[indexPath.row]
                
                NotesManager.shared.deleteNote(note: noteToDelete!)
                self.allNotes?.remove(at: indexPath.row)
                
                self.noteListTableView.deleteRows(at: [indexPath], with: .automatic)
                
                self.noteDeleteIndexPath = nil
                
                self.noteListTableView.endUpdates()
                
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { [unowned self] _ in
            self.noteDeleteIndexPath = nil
        }))
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource and UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = allNotes {
            return allNotes!.count
        }
        return dummyDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        
        cell.selectionStyle = .none
        
        if let _ = allNotes {
            let note = allNotes![indexPath.row]
            cell.textLabel?.text = note.content
            cell.detailTextLabel?.text = note.timeStamp
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let _ = allNotes {
                noteDeleteIndexPath = indexPath
                let noteToDelete = allNotes![indexPath.row]
                confirmDelete(data: noteToDelete)
                tableView.setEditing(false, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = allNotes {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
            detailVC.isEditingNote = true
            detailVC.noteToEdit = allNotes![indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
