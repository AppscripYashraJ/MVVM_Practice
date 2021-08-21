//
//  DatabaseManager.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 21/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager{
    static let shared = DatabaseManager()
    private let realm = try! Realm()
    
    private init(){}
    
    //MARK:- CREATE
    func addNote(object: Note){
        do {
            try realm.write({
                realm.add(object)
            })
        } catch {
            print("error adding realm object")
        }
    }
    
    //MARK:- UPDATE
    func updateNote(object: Object){
        guard let note = object as? Note  else {return}
        do{
            try realm.write({
                note.isCompleted = !note.isCompleted
            })
        } catch {
            print("error updating realm")
        }
    }
    
    //MARK:- READ
    func fetchNotes() -> [Note]{
        return Array(realm.objects(Note.self))
    }
    
    //MARK:- DELETE
    func deleteNote(object: Object){
        do {
            try realm.write({
                realm.delete(object)
            })
        } catch {
            print("error deleting realm object")
        }
    }
}
