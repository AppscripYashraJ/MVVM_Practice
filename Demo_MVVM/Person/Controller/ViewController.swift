//
//  ViewController.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 19/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    //MARK:- PROPERTIES
    let personData = [
        Person(firstName: "Yashraj", lastBName: "Gujar"),
        Person(firstName: "Pritesh", lastBName: "Doshi"),
        Person(firstName: "Abhilash", lastBName: "Oke")
    ]
    
    private var personListVM : PersonListViewModel? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personListVM = PersonListViewModel(person: personData)
    }
}

//MARK:- TABLEVIEW DATASOURCE
extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return personListVM?.numberOfSection ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personListVM?.numberOfRowsInSection() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuserIdentifer, for: indexPath) as! PersonTableViewCell
        let viewModel = self.personListVM?.personAtIndex(indexPath.row)
        cell.personVM = viewModel
        return cell
    }
    
}

//MARK:- TABLEVIEW DELEGTE
extension ViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
}

