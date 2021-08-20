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
    private var viewModel: WeatherViewModel?{
        didSet {
            self.updateUI()
        }
    }
    
    var loader : WeatherLoader!
    
    var countryName: String = ""
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.loadWeatherData(countryName: countryName) { [weak self] (weather) in
            DispatchQueue.main.async {
                if let data = weather {
                    self?.viewModel = WeatherViewModel(data)
                } else {
                    self?.displayErrorMesssage("No data available")
                }
            }
        }
    }
    
    //MARK:- CONFIGURE
    func updateUI(){
        weatherDescriptionLabel.text = viewModel?.weatherDescription
        weatherTemperatureLabel.text = viewModel?.temperature
    }
}
