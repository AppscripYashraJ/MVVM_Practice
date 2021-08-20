//
//  PersonTableViewCell.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 19/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    //MARK:- PROPERTIES
    static let reuserIdentifer = "PersonTableViewCell"
    
    var personVM : PersonViewModel?{
        didSet {
            self.configure()
        }
    }
    
    //MARK:- LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK:- HELPERS
    func configure(){
        guard let data = personVM else {return}
        firstName.text = data.firstName
        lastName.text = data.lastName
    }
}
