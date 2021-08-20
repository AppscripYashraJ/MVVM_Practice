//
//  WeatherService.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

class WeatherService {
    static func getWeatherData(_ countryName: String,completion:@escaping(Result<Weather,Error>)->Void){
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(countryName)&appid=\(API_KEY)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: urlString ?? "") else {
            completion(.failure(APIErrors.failedToGetData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIErrors.failedToGetData))
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weatherData))
            } catch let err {
                print("Error decoding data:",err)
                completion(.failure(APIErrors.errorDecodingData))
            }
        }
        
        task.resume()
    }
}

enum APIErrors: Error{
    case failedToGetData
    case errorDecodingData
}
