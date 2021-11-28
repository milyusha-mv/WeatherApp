//
//  RequestManager.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 25.11.2021.
//

import Foundation

class RequestManager {
    private init () {}
    static let shared = RequestManager()
    
    func fetchData(with requestData: RequestData, complition: @escaping (WeatherData?) -> Void) {
        var weatherData: WeatherData?
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = requestData.host
            components.path = requestData.path
            components.queryItems = [
                URLQueryItem(name: "lat", value: requestData.lat),
                URLQueryItem(name: "lon", value: requestData.lon),
                URLQueryItem(name: "lang", value: requestData.lang)
            ]
            return components.url
        }
        
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(requestData.apiKey, forHTTPHeaderField: requestData.header)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    weatherData  = try JSONDecoder().decode(WeatherData.self, from: data)
                    DataManager.shared.saveWeatherData(data: weatherData)
                    DispatchQueue.main.async {
                        complition(weatherData)
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}
