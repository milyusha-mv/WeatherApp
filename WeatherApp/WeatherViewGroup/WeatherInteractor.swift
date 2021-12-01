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
    func dataForCollectionViewCellDidRecieve(predictions: [Prediction])
    func dataForTableViewCellDidRecieved()
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
            RequestManager.shared.fetchData(with: requestData) { weatherData in
                self.fillPredictions(for: weatherData)
            }
        }
        fillPredictions(for: weatherData)
    }
    
    func getDataForTableViewCell() {
    }
    
    func getDataForTodayDay() {
        let requestData = DataManager.shared.requestData
        
        let weatherData = DataManager.shared.getWeatherData()
        if weatherData == nil {
            
            RequestManager.shared.fetchData(with: requestData) { weatherData in
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
    func fillPredictions(for weatherData: WeatherData?) {
        var predictions: [Prediction] = []
        
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

            let prediction = Prediction(partName: partDay,
                                        tempMin: tempMin,
                                        tempMax: tempMax,
                                        feelsLike: feelsLike,
                                        imageCollection: imageCollection)
            predictions.append(prediction)
        }
        self.presenter.dataForCollectionViewCellDidRecieve(predictions: predictions)
    }
    
}
