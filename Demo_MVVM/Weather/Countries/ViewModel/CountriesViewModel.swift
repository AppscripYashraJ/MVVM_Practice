//
//  CountriesViewModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

struct CountriesListViewModel{
    let countryName: [Country]
}

extension CountriesListViewModel {
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return countryName.count
    }
    
    func countryAtIndex(_ index:Int) -> CountryViewModel{
        let country = countryName[index]
        return CountryViewModel(country)
    }
    
    func didSelectRow(_ index:Int) -> String {
        let country = countryName[index]
        return country.name
    }
}

struct CountryViewModel {
    private let country: Country
    
    var countryName: String {
        return country.name
    }
}

extension CountryViewModel {
    init(_ country:Country) {
        self.country = country
    }
}
