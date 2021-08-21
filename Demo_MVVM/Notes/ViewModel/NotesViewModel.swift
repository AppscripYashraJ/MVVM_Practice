//
//  NotesViewModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 21/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

class NotesViewModel {
    
    private var notes : [Note]?
    
    convenience init(notes: [Note]){
        self.init()
        self.notes = notes
    }
}

//MARK:- DATABASE UPDATES
extension NotesViewModel {
    func addNote(_ text:String){
        DatabaseManager.shared.addNote(object:Note(text: text, isCompleted: false))
    }
    
    func fetchNotes() -> [Note]{
        var notes = DatabaseManager.shared.fetchNotes()
        notes.sort { (note1, note2) -> Bool in
            return  note1.dateCreated > note2.dateCreated
        }
        return notes
    }
    
    func deleteNote(_ note:Note){
        DatabaseManager.shared.deleteNote(object: note)
    }
    
    func updateNote(note:Note){
        DatabaseManager.shared.updateNote(object: note)
    }
}

//MARK:- TABLEVIEW METHODS
extension NotesViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows()->Int?{
        return notes?.count
    }
    
    func noteAtIndexPath(_ index:Int)->Note?{
        let note = notes?[index]
        return note
    }
    
    func selectNoteAtIndex(_ index:Int){
        if let note = notes?[index] {
            self.updateNote(note: note)
        }
    }
}

