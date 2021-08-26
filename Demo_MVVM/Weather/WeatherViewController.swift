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
        initViewModel()
    }
    
    //MARK:- CONFIGURE
    func updateUI(viewModel:WeatherViewModel){
        weatherDescriptionLabel.text = viewModel.weatherDescription
        weatherTemperatureLabel.text = viewModel.temperature
    }
    
    //MARK:- HELPERS
    
    func initViewModel(){
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.displayErrorMesssage(message)
                }
            }
        }
        
        viewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.weatherDescriptionLabel.text = self?.viewModel.weatherDescription
                self?.weatherTemperatureLabel.text = self?.viewModel.temperature
            }
        }
        
        viewModel.initFetchData(countryName)
    }
}
