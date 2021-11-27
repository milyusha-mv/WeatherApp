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
}

protocol WeatherViewInteractorOutputProtocol: AnyObject {
    func dataForCollectionViewCellDidRecieved()
    func dataForTableViewCellDidRecieved()
    func todayDayDidRecieved(humidity: Int)
}

class WeatherViewInteractor: WeatherViewInteractorInputProtocol {
    func getDataForCollectionViewCell() {
        presenter.dataForTableViewCellDidRecieved()
    }
    
    func getDataForTableViewCell() {
        presenter.dataForCollectionViewCellDidRecieved()
    }
    
    func getDataForTodayDay() {
        let requestData = DataManager.shared.requestData
        RequestManager.shared.fetchData(with: requestData) { weatherData in
            guard let weatherData = weatherData else { return }
            self.presenter.todayDayDidRecieved(humidity: weatherData.fact?.humidity ?? 0)
        }
    }
    
    unowned let presenter: WeatherViewInteractorOutputProtocol!
    required init(presenter: WeatherViewInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
}
