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
                                  lat: "58.0105",
                                  lon: "56.2502",
                                  limit: "4",
                                  extra: "true")
    
    private let nameOfImages: [String: String] = ["day": "day",
                                                  "evening": "evening",
                                                  "morning": "morning",
                                                  "night": "night"]
    
    private let partDays: [String: String] = ["day": "День",
                                              "evening": "Вечер",
                                              "morning": "Утро",
                                              "night": "Ночь"]
    private let titles = ["Температура",
                          "Ощущается как",
                          "Скорость ветра",
                          "Давление",
                          "Влажность",
                          "Время"]
    
    private let icons: [String: String] = ["Температура": "temp",
                                           "Ощущается как": "temp",
                                           "Скорость ветра": "wind_speed",
                                           "Давление": "pressure_mm",
                                           "Влажность": "humidity",
                                           "Время": "time"]
    
    private let valueSigns: [String: String] = ["Температура": "°",
                                           "Ощущается как": "°",
                                           "Скорость ветра": "м/с",
                                           "Давление": "мм",
                                           "Влажность": "%",
                                           "Время": ""]
}

extension DataManager {
    func getConstant() -> String {
        "СЕЙЧАС"
    }
}

extension DataManager {
    func saveWeatherData(data: WeatherData?) {
        self.weatherData = data
    }
    func getWeatherData() -> WeatherData? {
        self.weatherData
    }
    func getNameOfImages() -> [String: String] {
        nameOfImages
    }
    func getpartDay() -> [String: String] {
        partDays
    }
    func getTitles() -> [String] {
        titles
    }
    func getIcons() -> [String: String] {
        icons
    }
    func getValueSigns() -> [String: String] {
        valueSigns
    }
    
}
