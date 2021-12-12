//
//  LaunchViewController.swift
//  WeatherApp
//
//  Created by Михаил Милюша on 12.12.2021.
//

import Foundation
import UIKit

protocol LaunchViewOutputProtocol: AnyObject {
    func launchScreenStart()
}

protocol LaunchViewInputProtocol: AnyObject {
}

class LaunchViewController: UIViewController, LaunchViewInputProtocol {
    var presenter: LaunchViewOutputProtocol!
    private let configurator: LaunchConfiguratorProtocol = LaunchConfigurator()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configurate(with: self)
        activityIndicator.startAnimating()
        presenter.launchScreenStart()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let weatherVC = segue.destination as! WeatherViewController
        let configurator: ConfiguratorProtocol = Configurator()
        configurator.configurate(with: weatherVC)
    }
}
