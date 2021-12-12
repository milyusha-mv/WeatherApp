//
//  LaunchRouter.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 12.12.2021.
//

import Foundation

protocol LaunchRouterInputProtocol: AnyObject {
    init(viewController: LaunchViewController)
    func openWeatherViewController()
}

class LaunchRouter: LaunchRouterInputProtocol {
    unowned var viewController: LaunchViewController
    
    required init(viewController: LaunchViewController) {
        self.viewController = viewController
    }
    
    func openWeatherViewController() {
        viewController.performSegue(withIdentifier: "segueToWeatherView", sender: nil)
    }
}
