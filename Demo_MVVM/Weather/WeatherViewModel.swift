//
//  WeatherViewModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

protocol WeatherLoaderProtocol {
    func loadWeatherData(countryName:String,completion:@escaping(Weather?)->Void)
}

class WeatherViewModel {
    private var weatherData: Weather? {
        didSet {
            self.updateUI?()
        }
    }
    
    let apiService: WeatherLoaderProtocol
    
     init(apiService: WeatherLoaderProtocol = APIService()){
        self.apiService = apiService
    }
    
    var weatherDescription: String {
        return weatherData?.weatherInfo?.first?.longDescription?.capitalized ?? ""
    }
    
    var temperature: String {
        guard let temp = weatherData?.temperatureInfo?.temp else { return "" }
        let temperatureInCelcius = temp - 273.15
        return "\(String(format: "%.2f", temperatureInCelcius))º Celcius"
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var updateUI: (()->())?
    var showAlertClosure: (()->())?
}

extension WeatherViewModel {
    func initFetchData(_ countryName: String){
        apiService.loadWeatherData(countryName: countryName, completion: { (weather) in
            if weather?.name == nil {
                self.alertMessage = "No data available"
            }
            self.weatherData = weather
            
        })
    }
}
