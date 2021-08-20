//
//  WeatherViewModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

class WeatherViewModel {
    let weatherData: Weather
    
    init(_ data:Weather){
        self.weatherData = data
    }
    
    var weatherDescription: String {
        return weatherData.weatherInfo.first?.longDescription ?? ""
    }
    
    var temperature: String {
        let temp = weatherData.temperatureInfo.temperature
        let temperatureInCelcius = temp - 273.15
        return "\(String(format: "%.2f", temperatureInCelcius))º Celcius"
    }
}

class RemoteWeatherDataLoader: WeatherLoader{
    
    func loadWeatherData(countryName: String, completion: @escaping (Weather?) -> Void) {
        WeatherService.getWeatherData(countryName) { (result) in
            switch result{
            case .success(let data):
                completion(data)
            case .failure(_):
                completion(nil)
            }
        }
    }
}


protocol WeatherLoader {
    func loadWeatherData(countryName:String,completion:@escaping(Weather?)->Void)
}
