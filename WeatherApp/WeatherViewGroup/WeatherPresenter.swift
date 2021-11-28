//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 24.11.2021.
//

import Foundation

enum PartDay: String {
    case night = "Ночь"
    case morning = "Утро"
}

struct Prediction {
    let part_name: String
    let temp_min: Int
    let temp_max: Int
    let feels_like: Int
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
    func todayDayDidRecieved(date: Date) {
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
            section.rows.append(WeatherCell(prediction: prediction))
        }
        view.reloadCollectionViewData(for: section)
    }
    
    func dataForTableViewCellDidRecieved() {
    }
    
    func constantsDidRecieved(text: String) {
        view.setDataForLabel(text: text)
    }
    
}
