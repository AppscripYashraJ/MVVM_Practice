//
//  CountriesViewController.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import UIKit

class CountriesViewController: UITableViewController {
    
    //MARK:- PROPERTIES
    private var countriesList : [Country] = {
        var data = [Country]()
        for x in countryList {
            data.append(Country(name: x))
        }
        return data
    }()
    
    private var countriesViewModel: CountriesListViewModel?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countriesViewModel = CountriesListViewModel(countryName: countriesList)
    }
}

//MARK:- TABLEVIEW DATASOURCE
extension CountriesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countriesViewModel?.numberOfSection ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel?.numberOfRowsInSection() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifer, for: indexPath) as! CountryTableViewCell
        let vm = countriesViewModel?.countryAtIndex(indexPath.row)
        cell.countriesViewModel = vm
        return cell
    }
}

//MARK:- TABLEVIEW DELEGATE
extension CountriesViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let name = countriesViewModel?.didSelectRow(indexPath.row) {
            if let weatherVC = storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController {
                weatherVC.countryName = name
                weatherVC.loader = RemoteWeatherDataLoader()
                self.navigationController?.pushViewController(weatherVC, animated: true)
            }
        }
        
    }
}
