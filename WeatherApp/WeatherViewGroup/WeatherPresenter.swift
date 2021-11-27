//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 24.11.2021.
//

import Foundation

class WeatherPresenter: WeatherViewOutputProtocol {
    
    var interactor: WeatherViewInteractorInputProtocol!
    unowned let view: WeatherViewInputProtocol
    
    required init(view: WeatherViewInputProtocol) {
        self.view = view
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
    func dataForCollectionViewCellDidRecieved() {
        
    }
    
    func dataForTableViewCellDidRecieved() {
        
    }
    
    func todayDayDidRecieved(humidity: Int) {
        let todayDay = "\(humidity)"
        view.showTodayDay(todayDay: todayDay)
    }
    
    
}
