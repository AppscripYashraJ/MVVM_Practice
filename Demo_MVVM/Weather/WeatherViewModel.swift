//
//  WeatherViewModel.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

protocol WeatherLoader {
    func loadWeatherData(countryName:String,completion:@escaping(Weather?)->Void)
}

class WeatherViewModel {
    private var weatherData: Weather?
    
    convenience init(_ data:Weather){
        self.init()
        self.weatherData = data
    }
    
    var weatherDescription: String {
        return weatherData?.weatherInfo.first?.longDescription.capitalized ?? ""
    }
    
    var temperature: String {
        guard let temp = weatherData?.temperatureInfo.temperature else { return "" }
        let temperatureInCelcius = temp - 273.15
        return "\(String(format: "%.2f", temperatureInCelcius))º Celcius"
    }
}

//MARK:- API CALL
extension WeatherViewModel: WeatherLoader {
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
