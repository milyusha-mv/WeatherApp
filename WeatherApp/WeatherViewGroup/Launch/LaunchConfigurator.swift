//
//  LaunchConfigurator.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 12.12.2021.
//

import Foundation

protocol LaunchConfiguratorProtocol: AnyObject {
    func configurate(with view: LaunchViewController)
}

class LaunchConfigurator: LaunchConfiguratorProtocol {
    func configurate(with view: LaunchViewController) {
        let presenter = LaunchPresenter(view: view)
        let interactor = LaunchInteractor(presenter: presenter)
        let router = LaunchRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
