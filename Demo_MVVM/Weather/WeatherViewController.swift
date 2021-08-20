//
//  WeatherViewController.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    
    //MARK:- PROPERTIES
    private let viewModel =  WeatherViewModel()
    
    var countryName: String = ""
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = countryName
        getWeatherData()
    }
    
    //MARK:- CONFIGURE
    func updateUI(viewModel:WeatherViewModel){
        weatherDescriptionLabel.text = viewModel.weatherDescription
        weatherTemperatureLabel.text = viewModel.temperature
    }
    
    //MARK:- HELPERS
    private func getWeatherData(){
        viewModel.loadWeatherData(countryName: countryName) { [weak self] (weather) in
            DispatchQueue.main.async {
                if let data = weather {
                    self?.updateUI(viewModel: WeatherViewModel(data))
                } else {
                    self?.displayErrorMesssage("No data available")
                }
            }
        }
    }
}
