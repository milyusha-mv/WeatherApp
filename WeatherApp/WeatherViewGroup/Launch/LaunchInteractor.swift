//
//  LaunchInteractor.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 12.12.2021.
//

import Foundation

protocol LaunchInteractorOutputProtocol: AnyObject {
    func dataForWeatherViewControllerDidRecieved()
}

protocol LaunchInteractorInputProtocol: AnyObject {
    init(presenter: LaunchInteractorOutputProtocol)
    func fetchDataForWeatherViewController()
}

class LaunchInteractor: LaunchInteractorInputProtocol {
    unowned let presenter: LaunchInteractorOutputProtocol!
    required init(presenter: LaunchInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchDataForWeatherViewController() {
        let requestData = DataManager.shared.requestData
        RequestManager.shared.fetchData(with: requestData) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.presenter.dataForWeatherViewControllerDidRecieved()
            }
        }
    }
}
