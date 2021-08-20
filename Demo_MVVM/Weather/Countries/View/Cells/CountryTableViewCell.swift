//
//  CountryTableViewCell.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    //MARK:- OUTLETS
    @IBOutlet weak var countryName: UILabel!
    
    //MARK:- PROPERTIES
    static let reuseIdentifer = "CountryTableViewCell"
    var countriesViewModel: CountryViewModel?{
        didSet{
            configureUI()
        }
    }
    //MARK:- LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- CONFIGURE
    private func configureUI(){
        guard let data = self.countriesViewModel else {return}
        countryName.text = data.countryName
    }
    
}
