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
    func showErrorAlert()
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
    
    func showErrorAlert() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            let alert = UIAlertController(title: "Ошибка", message: "Произошла ошибка получения данных", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
                self.activityIndicator.isHidden = false
                self.presenter.launchScreenStart()
            }))
            self.present(alert, animated: true)
        }
    }
}
