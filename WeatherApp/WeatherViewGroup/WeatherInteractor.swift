//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 24.11.2021.
//

import Foundation

protocol WeatherViewInteractorInputProtocol: AnyObject {
    init(presenter: WeatherViewInteractorOutputProtocol)
    
}

protocol WeatherViewInteractorOutputProtocol: AnyObject {
    
}

class WeatherViewInteractor: WeatherViewInteractorInputProtocol {
    unowned let presenter: WeatherViewInteractorOutputProtocol!
    required init(presenter: WeatherViewInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
}
