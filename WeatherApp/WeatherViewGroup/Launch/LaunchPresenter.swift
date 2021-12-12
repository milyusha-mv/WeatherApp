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
}

extension LaunchPresenter: LaunchInteractorOutputProtocol {
    func dataForWeatherViewControllerDidRecieved() {
        router.openWeatherViewController()
    }
    
}
