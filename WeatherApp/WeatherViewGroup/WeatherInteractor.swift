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
    func todayDayDidRecieved(date: Date)
    func constantsDidRecieved(text: String)
}

class WeatherViewInteractor: WeatherViewInteractorInputProtocol {
    
    func getConstants() {
        let text = DataManager.shared.getConstant()
        presenter.constantsDidRecieved(text: text)
    }
    
    func getDataForCollectionViewCell() {
        let requestData = DataManager.shared.requestData
        var predictions: [Prediction] = []
    
        let weatherData = DataManager.shared.getWeatherData()
        if weatherData == nil {
            RequestManager.shared.fetchData(with: requestData) { weatherData in
                guard let weatherData = weatherData else { return }
                
                guard let count = weatherData.forecast?.parts?.count else { return }
                
                for index in 0...count - 1 {
                    let part_name = weatherData.forecast?.parts?[index].part_name ?? ""
                    let temp_min = weatherData.forecast?.parts?[index].temp_min ?? 0
                    let temp_max = weatherData.forecast?.parts?[index].temp_max ?? 0
                    let feels_like = weatherData.forecast?.parts?[index].feels_like ?? 0
                    
                    let prediction = Prediction(part_name: part_name,
                                                temp_min: temp_min,
                                                temp_max: temp_max,
                                                feels_like: feels_like,
                                                imageCollection: "test")
                    predictions.append(prediction)
                }
                self.presenter.dataForCollectionViewCellDidRecieve(predictions: predictions)
            }
        }
        
        guard let weatherData = weatherData else { return }
        
        guard let count = weatherData.forecast?.parts?.count else { return }
        
        for index in 0...count - 1 {
        
            let part_name = weatherData.forecast?.parts?[index].part_name ?? ""
            let temp_min = weatherData.forecast?.parts?[index].temp_min ?? 0
            let temp_max = weatherData.forecast?.parts?[index].temp_max ?? 0
            let feels_like = weatherData.forecast?.parts?[index].feels_like ?? 0
            
            let prediction = Prediction(part_name: part_name,
                                        temp_min: temp_min,
                                        temp_max: temp_max,
                                        feels_like: feels_like,
                                        imageCollection: "test")
            predictions.append(prediction)
        }
        presenter.dataForCollectionViewCellDidRecieve(predictions: predictions)
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
                let date = Date(timeIntervalSince1970: dateUnix)
                let formatter  = DateFormatter()
                formatter.dateStyle = .short
                formatter.string(from: date)
                self.presenter.todayDayDidRecieved(date: date)
            }
        }
        guard let weatherData = weatherData else { return }
        guard let dateUnix = weatherData.now else { return }
        let date = Date(timeIntervalSince1970: dateUnix)
        self.presenter.todayDayDidRecieved(date: date)
    }
    
    unowned let presenter: WeatherViewInteractorOutputProtocol!
    required init(presenter: WeatherViewInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
}
