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
    }
}

extension WeatherPresenter: WeatherViewInteractorOutputProtocol {
    
}
