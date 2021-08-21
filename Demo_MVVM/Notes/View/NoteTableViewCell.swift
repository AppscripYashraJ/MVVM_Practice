//
//  NoteTableViewCell.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 21/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    //MARK:- PROPERTIES
    static let reuseIdentifier = "NoteTableViewCell"
    
    var noteVM: NoteViewModel?{
        didSet{
            updateUI(viewModel: noteVM)
        }
    }
    
    //MARK:- LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- COFIGURE
    func updateUI(viewModel:NoteViewModel?){
        titleLabel.text = viewModel?.title
        accessoryType = viewModel?.isCompleted == true ? .checkmark : .none
        createdAtLabel.text = viewModel?.createdDate
    }
}
