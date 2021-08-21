//
//  NotesListViewController.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 21/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import UIKit

class NotesListViewController: UITableViewController {
    
    //MARK:- PROPERTIES
    private var viewModel = NotesListViewModel()
    
    private var notes: [Note]? {
        didSet {
            viewModel = NotesListViewModel(notes: notes ?? [Note]())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotes()
    }
    
    //MARK:- ACTIONS
    @IBAction func addNoteTapped(_ sender: UIBarButtonItem) {
        showAddNoteAlert()
    }
    
    //MARK:- HELPERS
    private func showAddNoteAlert(){
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new note", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            self.viewModel.addNote(textField.text ?? "")
            self.fetchNotes()
        }))
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new note"
            textField = alertTextField
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func fetchNotes(){
        notes = viewModel.fetchNotes()
    }
}

//MARK:- TABLEVIEW DATASOURCE
extension NotesListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifier, for: indexPath) as! NoteTableViewCell
        if let note = viewModel.noteAtIndexPath(indexPath.row) {
            cell.noteVM = NoteViewModel(note)
        }
        return cell
    }
}

//MARK:- TABLEVIEW DELEGATE
extension NotesListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let note = viewModel.noteAtIndexPath(indexPath.row) {
                viewModel.deleteNote(note)
                fetchNotes()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectNoteAtIndex(indexPath.row)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
