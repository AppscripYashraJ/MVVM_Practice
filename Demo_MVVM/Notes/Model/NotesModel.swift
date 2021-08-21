//
//  NotesModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 21/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isCompleted: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    
    required convenience init(text:String,isCompleted:Bool){
        self.init()
        self.title = text
        self.isCompleted = isCompleted
        self.dateCreated = Date()
    }
}
