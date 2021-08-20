//
//  Weather.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let weatherInfo: [WeatherInfo]
    let temperatureInfo: TemperatureInfo
    
    enum CodingKeys: String,CodingKey{
        case weatherInfo = "weather"
        case temperatureInfo = "main"
    }
}

struct WeatherInfo: Codable {
    let shortDescription: String
    let longDescription: String
    
    enum CodingKeys: String,CodingKey{
        case shortDescription = "main"
        case longDescription = "description"
    }
}

struct TemperatureInfo: Codable{
    let temperature: Double
    let humidity: Double
    
    enum CodingKeys: String,CodingKey{
        case temperature = "temp"
        case humidity = "humidity"
    }
}
