//
//  LaunchInteractor.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 12.12.2021.
//

import Foundation

protocol LaunchInteractorOutputProtocol: AnyObject {
    func dataForWeatherViewControllerDidRecieved()
    func dataForWeatherViewControllerDidNotRecieved()
}

protocol LaunchInteractorInputProtocol: AnyObject {
    init(presenter: LaunchInteractorOutputProtocol)
    func fetchDataForWeatherViewController()
    func setLocationToDataManager(latitude: Double, longitude: Double)
}

class LaunchInteractor: LaunchInteractorInputProtocol {
    
    unowned let presenter: LaunchInteractorOutputProtocol!
    required init(presenter: LaunchInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func setLocationToDataManager(latitude: Double, longitude: Double){
        DataManager.shared.setRequestData(latitude: latitude, longitude: longitude)
    }
    
    func fetchDataForWeatherViewController() {
        if let lastUnixtime = DataManager.shared.getTimeFromCache() {
            let currentUnixtime = Date().timeIntervalSince1970
            let chacheTime = DataManager.shared.getChacheTime()
            if (currentUnixtime - lastUnixtime) < chacheTime {
                let weatherData =  DataManager.shared.getWeatherDataFromCache()
                DataManager.shared.saveWeatherData(data: weatherData)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.presenter.dataForWeatherViewControllerDidRecieved()
                    }
            } else {
                fetchDataAndSaveCache()
                }
        } else {
            fetchDataAndSaveCache()
            }
    }
    
    func fetchDataAndSaveCache() {
        let requestData = DataManager.shared.requestData
        RequestManager.shared.fetchData(with: requestData, isCache: true) { answer in
            if answer == nil {
                self.presenter.dataForWeatherViewControllerDidNotRecieved()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.presenter.dataForWeatherViewControllerDidRecieved()
                    }
            }
        }
    }
}
