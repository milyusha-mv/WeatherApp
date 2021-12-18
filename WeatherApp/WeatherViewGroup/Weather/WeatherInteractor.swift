//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 24.11.2021.
//

import Foundation

protocol WeatherViewInteractorInputProtocol: AnyObject {
    init(presenter: WeatherViewInteractorOutputProtocol)
    func getDataForCollectionViewCell()
    func getDataForTableViewCell()
    func getDataForTodayDay()
    func getConstants()
}

protocol WeatherViewInteractorOutputProtocol: AnyObject {
    func dataForCollectionViewCellDidRecieve(featureWethers: [FeatureWeather])
    func dataForTableViewCellDidRecieved(currentWeathers: [CurrentWeather])
    func todayDayDidRecieved(dateUnix: Double)
    func constantsDidRecieved(text: String)
}

class WeatherViewInteractor: WeatherViewInteractorInputProtocol {
    
    func getConstants() {
        let text = DataManager.shared.getConstant()
        presenter.constantsDidRecieved(text: text)
    }
    
    func getDataForCollectionViewCell() {
        let requestData = DataManager.shared.requestData
        let weatherData = DataManager.shared.getWeatherData()
        if weatherData == nil {
            RequestManager.shared.fetchData(with: requestData, isCache: false) { weatherData in
                self.fillFeatureWeathers(for: weatherData)
            }
        }
        fillFeatureWeathers(for: weatherData)
    }
    
    func getDataForTableViewCell() {
        let requestData = DataManager.shared.requestData
        let weatherData = DataManager.shared.getWeatherData()
        if weatherData == nil {
            RequestManager.shared.fetchData(with: requestData, isCache: false) { weatherData in
                self.fillCurrentWeathers(for: weatherData)
            }
        }
        fillCurrentWeathers(for: weatherData)
    }
    
    func getDataForTodayDay() {
        let requestData = DataManager.shared.requestData
        
        let weatherData = DataManager.shared.getWeatherData()
        if weatherData == nil {
            
            RequestManager.shared.fetchData(with: requestData, isCache: false) { weatherData in
                guard let weatherData = weatherData else { return }
                guard let dateUnix = weatherData.now else { return }
                self.presenter.todayDayDidRecieved(dateUnix: dateUnix)
            }
        }
        guard let weatherData = weatherData else { return }
        guard let dateUnix = weatherData.now else { return }
        self.presenter.todayDayDidRecieved(dateUnix: dateUnix)
    }
    
    unowned let presenter: WeatherViewInteractorOutputProtocol!
    required init(presenter: WeatherViewInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
}

extension WeatherViewInteractor {
    func fillCurrentWeathers(for weatherData: WeatherData?) {
        var currentWeathers: [CurrentWeather] = []
        
        guard let weatherData = weatherData else { return }
    
        let titles = DataManager.shared.getTitles()
        let icons = DataManager.shared.getIcons()
        let valueSigns = DataManager.shared.getValueSigns()
        
        let values: [Any] = [weatherData.fact?.temp as Any,
                      weatherData.fact?.feelsLike as Any,
                      weatherData.fact?.windSpeed as Any,
                      weatherData.fact?.pressureMm as Any,
                      weatherData.fact?.humidity as Any]
                     // weatherData.fact?.obsTime as Any]
        
        for index in 0...values.count - 1 {
            let title = titles[index]
            guard let value = values[index] as? Int else { return }
            let icon = icons[title] ?? ""
            let valueSign = valueSigns[title] ?? ""
            let currentWeather = CurrentWeather(title: title,
                                                value: value,
                                                valueSign: valueSign,
                                                image: icon)
            currentWeathers.append(currentWeather)
        }
        presenter.dataForTableViewCellDidRecieved(currentWeathers: currentWeathers)
    }
}

extension WeatherViewInteractor {
    func fillFeatureWeathers(for weatherData: WeatherData?) {
        var featureWethers: [FeatureWeather] = []
        
        guard let weatherData = weatherData else { return }
        
        guard let count = weatherData.forecast?.parts?.count else { return }
        
        for index in 0...count - 1 {
            let partName = weatherData.forecast?.parts?[index].partName ?? ""
            let tempMin = weatherData.forecast?.parts?[index].tempMin ?? 0
            let tempMax = weatherData.forecast?.parts?[index].tempMax ?? 0
            let feelsLike = weatherData.forecast?.parts?[index].feelsLike ?? 0
            
            let partDays = DataManager.shared.getpartDay()
            let partDay = partDays[partName] ?? ""
            
            let nameOfImages = DataManager.shared.getNameOfImages()
            let imageCollection = nameOfImages[partName] ?? ""

            let featureWeather = FeatureWeather(partName: partDay,
                                        tempMin: tempMin,
                                        tempMax: tempMax,
                                        feelsLike: feelsLike,
                                        imageCollection: imageCollection)
            featureWethers.append(featureWeather)
        }
        self.presenter.dataForCollectionViewCellDidRecieve(featureWethers: featureWethers)
    }
}
