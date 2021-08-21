//
//  NotesViewModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 21/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

struct NotesListViewModel {
    let notes: [Note]
    
    init(notes:[Note] = [Note]()) {
        self.notes = notes
    }
}

//MARK:- TABLEVIEW METHODS
extension NotesListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows()->Int?{
        return notes.count
    }
    
    func noteAtIndexPath(_ index:Int)->Note?{
        return notes[index]
    }
    
    func selectNoteAtIndex(_ index:Int){
        updateNote(note: notes[index])
    }
}

//MARK:- DATABASE MANIPUATIONS
extension NotesListViewModel {
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

struct NoteViewModel {
    private var note :Note
    
    init(_ note:Note) {
        self.note = note
    }
    
    var title: String {
        note.title
    }
    
    var createdDate:String {
        let date = note.dateCreated
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second,.minute,.hour,.day,.month,.year]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return "\(formatter.string(from: date, to: Date()) ?? "") ago"
    }
    
    var isCompleted: Bool{
        return note.isCompleted
    }
}
