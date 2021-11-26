//
//  WeatherConfigurator.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 24.11.2021.
//

import Foundation

protocol ConfiguratorProtocol: AnyObject {
    func configurate(with view: WeatherViewController)
}

class Configurator: ConfiguratorProtocol {
    func configurate(with view: WeatherViewController) {
        let presenter = WeatherPresenter(view: view)
        let interactor = WeatherViewInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
    
}
