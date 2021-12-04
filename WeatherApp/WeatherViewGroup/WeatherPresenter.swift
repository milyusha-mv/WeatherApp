//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 24.11.2021.
//

import Foundation

struct FeatureWeather {
    let partName: String
    let tempMin: Int
    let tempMax: Int
    let feelsLike: Int
    let imageCollection: String
}

struct CurrentWeather {
    let title: String
    let value: Int
    let valueSign: String
    let image: String
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
    
    func getFeatureWeather() {
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
    
    func dataForCollectionViewCellDidRecieve(featureWethers: [FeatureWeather]) {
        let section = CollectionSection()
        featureWethers.forEach { featureWeather in
            section.rows.append(CollectionCell(featureWeather: featureWeather))
        }
        view.reloadCollectionViewData(for: section)
    }
    
    func dataForTableViewCellDidRecieved(currentWeathers: [CurrentWeather]) {
        let section = TableSection()
        currentWeathers.forEach { currentWeather in
            section.rows.append(TableCell(currentWeather: currentWeather))
        }
        view.reloadTableViewData(for: section)
    }
    
    func constantsDidRecieved(text: String) {
        view.setDataForLabel(text: text)
    }
    
}
