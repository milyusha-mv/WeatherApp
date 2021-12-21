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
    
    func fetchData(with requestData: RequestData, isCache: Bool, complition: @escaping (WeatherData?) -> Void) {
        var weatherData: WeatherData?
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = requestData.host
            components.path = requestData.path
            components.queryItems = [
                URLQueryItem(name: "lat", value: requestData.lat),
                URLQueryItem(name: "lon", value: requestData.lon),
                URLQueryItem(name: "limit", value: requestData.limit),
                URLQueryItem(name: "extra", value: requestData.extra)
            ]
            return components.url
        }
        
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(requestData.apiKey, forHTTPHeaderField: requestData.header)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("HTTP ERROR!")
                    complition(nil)
                }
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    weatherData  = try decoder.decode(WeatherData.self, from: data)
                    DataManager.shared.saveWeatherData(data: weatherData)
                    if isCache {
                        DataManager.shared.saveWeatherDataCache(data: data)
                    }
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
