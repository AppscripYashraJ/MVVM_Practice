//
//  Weather.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

//struct Weather: Codable {
//    let weatherInfo: [WeatherInfo]
//    let temperatureInfo: TemperatureInfo
//    
//    enum CodingKeys: String,CodingKey{
//        case weatherInfo = "weather"
//        case temperatureInfo = "main"
//    }
//}
//
//struct WeatherInfo: Codable {
//    let shortDescription: String
//    let longDescription: String
//    
//    enum CodingKeys: String,CodingKey{
//        case shortDescription = "main"
//        case longDescription = "description"
//    }
//}
//
//struct TemperatureInfo: Codable{
//    let temperature: Double
//    let humidity: Double
//    
//    enum CodingKeys: String,CodingKey{
//        case temperature = "temp"
//        case humidity = "humidity"
//    }
//}


struct Weather : Codable {
    
    let temperatureInfo : TemperatureInfo?
    let name : String?
    let weatherInfo : [WeatherInfo]?
    
    enum CodingKeys: String, CodingKey {
        case temperatureInfo = "main"
        case name = "name"
        case weatherInfo = "weather"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temperatureInfo = try values.decodeIfPresent(TemperatureInfo.self, forKey: .temperatureInfo)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        weatherInfo = try values.decodeIfPresent([WeatherInfo].self, forKey: .weatherInfo)
    }
    
}

struct WeatherInfo : Codable {
    let shortDescription: String?
    let longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case shortDescription = "main"
        case longDescription = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        
    }
    
}

struct TemperatureInfo : Codable {
    let humidity : Int?
    let temp : Double?
    
    enum CodingKeys: String, CodingKey {
        case humidity = "humidity"
        case temp = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
    }
    
}
