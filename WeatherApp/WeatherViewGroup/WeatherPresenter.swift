//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 24.11.2021.
//

import Foundation

struct Prediction {
    let partName: String
    let tempMin: Int
    let tempMax: Int
    let feelsLike: Int
    let imageCollection: String
}

class WeatherPresenter: WeatherViewOutputProtocol {
    
    var interactor: WeatherViewInteractorInputProtocol!
    unowned let view: WeatherViewInputProtocol
    
    required init(view: WeatherViewInputProtocol) {
        self.view = view
    }
    
    func getDataForLabel() {
        interactor.getConstants()
    }
    
    func getPredictionWeather() {
        interactor.getDataForCollectionViewCell()
    }
    
    func getTodayWeather() {
        interactor.getDataForTableViewCell()
    }
    
    func getTodayDay() {
        interactor.getDataForTodayDay()
    }
}

extension WeatherPresenter: WeatherViewInteractorOutputProtocol {
    func todayDayDidRecieved(dateUnix: Double) {
        let date = Date(timeIntervalSince1970: dateUnix)
        let formatter  = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.setLocalizedDateFormatFromTemplate("dd MM")
        let dateTime = formatter.string(from: date)
        let todayDay = "Погода на \(dateTime)"
        view.showTodayDay(todayDay: todayDay)
    }
    
    func dataForCollectionViewCellDidRecieve(predictions: [Prediction]) {
        let section = CollectionSection()
        predictions.forEach { prediction in
            section.rows.append(CollectionCell(prediction: prediction))
        }
        view.reloadCollectionViewData(for: section)
    }
    
    func dataForTableViewCellDidRecieved() {
    }
    
    func constantsDidRecieved(text: String) {
        view.setDataForLabel(text: text)
    }
    
}
