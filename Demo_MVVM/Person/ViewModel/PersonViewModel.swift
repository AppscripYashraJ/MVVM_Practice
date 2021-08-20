//
//  PersonViewModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 19/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

struct PersonListViewModel{
    let person : [Person]
}

//MARK:- TABLEVIEW METHODS
extension PersonListViewModel {
    var numberOfSection : Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int{
        return self.person.count
    }
    
    func personAtIndex(_ index : Int)->PersonViewModel{
        let person = self.person[index]
        return PersonViewModel(person)
    }
}

struct PersonViewModel {
    private let person : Person
    
    var firstName : String {
        return person.firstName
    }
    
    var lastName: String {
        return person.lastBName
    }
}

extension PersonViewModel {
    init(_ person : Person) {
        self.person = person
    }
}
