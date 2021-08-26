//
//  WeatherService.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

enum APIErrors: Error{
    case failedToGetData
    case errorDecodingData
}

enum Router{
    case getWeatherData(String)
    
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return "api.openweathermap.org"
    }
    
    var path: String{
        return "/data/2.5/weather"
    }
    
    var paramters: [URLQueryItem]{
        switch self {
        case .getWeatherData(let countryName):
            let countryName = countryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return [URLQueryItem(name: "q", value: countryName),URLQueryItem(name: "appid", value: API_KEY)]
        }
    }
    
    var httpMethod: String{
        switch self {
        case .getWeatherData(_):
            return "GET"
        }
    }
    
}

class ServiceLayer{
    class func request<T:Codable>(router:Router,completion:@escaping(Result<T,Error>)->Void){
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.paramters
        
        guard let url = components.url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = router.httpMethod
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data,error == nil else {
                completion(.failure(APIErrors.failedToGetData))
                return
            }
            
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                completion(.success(value))
            } catch let error {
                print("error decoding data:",error)
                completion(.failure(APIErrors.errorDecodingData))
            }
        }
        task.resume()
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
