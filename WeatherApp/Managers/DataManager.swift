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
    
    var requestData = RequestData(host: "api.weather.yandex.ru",
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
    func getChacheTime() -> Double {
        300
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

// Work with UserDefaults
extension DataManager {
    func saveWeatherDataCache(data: Data?) {
        guard let data = data else { return }
        do {
            let dataSave = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
            UserDefaults.standard.set(dataSave, forKey: "weatherData")
            
            let unixtime = Date().timeIntervalSince1970
            UserDefaults.standard.set(unixtime, forKey: "unixtime")
        } catch {
            print(error)
        }
    }
    func getWeatherDataFromCache() -> WeatherData? {
        var weatherData: WeatherData?
        let data = UserDefaults.standard.object(forKey: "weatherData")
        do {
            if let cache = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                weatherData  = try decoder.decode(WeatherData.self, from: cache as! Data)
            }
        } catch {
            print("Couldn't read file.")
        }
        return weatherData
    }
    
    func getTimeFromCache() -> Double? {
        return UserDefaults.standard.value(forKey: "unixtime") as? Double
    }
}

extension DataManager {
    func setRequestData(latitude: Double, longitude: Double) {
        requestData.lat = "\(latitude)"
        requestData.lon = "\(longitude)"
    }
}

