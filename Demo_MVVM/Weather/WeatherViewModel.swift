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
    
    var countryName: String?{
        return weatherData?.name
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

class APIService: WeatherLoaderProtocol {
    func loadWeatherData(countryName: String, completion: @escaping (Weather?) -> Void) {
        ServiceLayer.request(router: Router.getWeatherData(countryName)) { (result:Result<Weather,Error>) in
            switch result{
            case .success(let data):
                completion(data)
            case .failure(_):
                completion(nil)
            }
        }
    }
}

class MockAPIService:WeatherLoaderProtocol {
    
    var completionClosure: ((Weather) -> ())?
    func loadWeatherData(countryName: String, completion: @escaping (Weather?) -> Void) {
        //Fetch Mock Data
        let data = StubGenerator().stubWeatherData()
        if countryName == data.name {
            completion(data)
        } else {
            completion(nil)
        }
    }
}

class StubGenerator {
    func stubWeatherData() -> Weather {
        let path = Bundle.main.path(forResource: "content", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let weatherData = try! decoder.decode(Weather.self, from: data)
        return weatherData
    }
}
