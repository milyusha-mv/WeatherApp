//
//  DataManager.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 25.11.2021.
//

import Foundation

class DataManager {
    private init () {}
    static let shared = DataManager()
    var weatherData: WeatherData?
    
    let requestData = RequestData(host: "api.weather.yandex.ru",
                                  header: "X-Yandex-API-Key",
                                  apiKey: "ce929102-9793-4d2b-a73d-0424b45f723f",
                                  path: "/v2/informers",
                                  lang: "ru_RU",
                                  lat: "58.0105",
                                  lon: "56.2502")
}

extension DataManager {
    func getConstant() -> String {
        "Сейчас"
    }
}

extension DataManager {
    func saveWeatherData(data: WeatherData?) {
        self.weatherData = data
    }
    func getWeatherData() -> WeatherData? {
        self.weatherData
    }
}
