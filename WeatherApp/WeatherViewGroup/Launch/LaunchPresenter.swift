//
//  LaunchPresenter.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 12.12.2021.
//

import Foundation

class LaunchPresenter: LaunchViewOutputProtocol {
    
    var interactor: LaunchInteractorInputProtocol!
    var router: LaunchRouterInputProtocol!
    
    unowned let view: LaunchViewInputProtocol
    
    required init(view: LaunchViewInputProtocol) {
        self.view = view
    }
    
    func launchScreenStart() {
        interactor.fetchDataForWeatherViewController()
    }
    
    func saveLocation(latitude: Double, longitude: Double) {
        interactor.setLocationToDataManager(latitude: latitude, longitude: longitude)
    }
}

extension LaunchPresenter: LaunchInteractorOutputProtocol {
    func dataForWeatherViewControllerDidNotRecieved() {
        view.showErrorAlert(title: "Fail", message: "An error occurred while fetching data")
    }
    
    func dataForWeatherViewControllerDidRecieved() {
        router.openWeatherViewController()
    }
    
}
